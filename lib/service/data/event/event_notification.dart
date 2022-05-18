import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/entity/entities.dart';

/// 提醒ID
class EventNoticeId {
  /// 事件ID
  late final String eventId;
  static const String eventIdKey = "event_id";

  /// 提醒时间
  late final DateTime noticeTime;
  static const String noticeTimeKey = "notice_time";

  /// 构造
  EventNoticeId(this.eventId, this.noticeTime);

  /// 解码
  static EventNoticeId? decode(String eventNoticeId) {
    Map<String, dynamic> noticeIdMap = json.decode(eventNoticeId);
    String? eventId = noticeIdMap[eventIdKey] as String?;
    String? noticeTimeStr = noticeIdMap[noticeTimeKey] as String?;
    if (null == eventId || null == noticeTimeStr) return null;
    EventNoticeId id = EventNoticeId(eventId, _noticeTimeDecode(noticeTimeStr));
    return id;
  }

  /// 编码
  String encode() {
    return json.encode({eventIdKey: eventId, noticeTimeKey: noticeTimeEncode()});
  }

  /// 提醒时间编码
  String noticeTimeEncode() {
    return noticeTime.millisecondsSinceEpoch.toString();
  }

  /// 提醒时间解码
  static DateTime _noticeTimeDecode(String noticeTimeStr) {
    return DateTime.fromMillisecondsSinceEpoch(int.parse(noticeTimeStr));
  }

  /// 发送通知的int id
  int get notificationId => encode().hashCode;
}

/// 事件提醒服务
class EventNoticeService {
  EventNoticeService._();

  static EventNoticeService? _instance;

  static EventNoticeService get instance => _instance ??= EventNoticeService._();

  /// 日志
  static _log(String msg) => debugPrint("[事件通知服务]:$msg");

  /// 记录当前未提醒的队列，防止重复添加提醒
  /// 同时维护两套数据，分别是这个静态数据和shared_preferences里面的数据
  /// 每次新增的时候更新两套数据，查询只查询一次
  /// 过期失效提醒惰性删除
  static Set<String> noticeIdList = {};

  /// 按照事件分组的队列 key是事件ID,value是事件关联的提醒ID encode的值
  /// noticeIdList的分组版本
  static Map<String, List<String>> noticeIdMap = {};

  /// shared_preferences持久化的key
  static const String repositoryKey = SharedPreferencesKeys.eventNoticeList;

  /// 批量提醒
  Future<void> noticeByEventList(List<DeriveEvent> deriveList, [bool dealChildren = false]) async {
    // 先查询当前的提醒列表
    await findNoticeList();
    List<ScheduleNotificationArgs> argsList = [];
    for (DeriveEvent derive in deriveList) {
      argsList.addAll(await _noticeByEvent(derive, dealChildren));
    }
    if (argsList.isEmpty) return;
    await NotificationHelper.batchScheduleNotification(argsList);
  }

  /// 提醒
  Future<void> noticeByEvent(DeriveEvent derive, [bool dealChildren = false]) async {
    // 先查询当前的提醒列表
    await findNoticeList();
    List<ScheduleNotificationArgs> argsList = await _noticeByEvent(derive, dealChildren);
    if (argsList.isEmpty) return;
    await NotificationHelper.batchScheduleNotification(argsList);
  }

  /// 根据事件发送通知 权量发送
  /// 按照事件 惰性移除过期通知
  /// [dealChildren]决定是否处理子事件的通知
  Future<List<ScheduleNotificationArgs>> _noticeByEvent(DeriveEvent derive, [bool dealChildren = false]) async {
    _log("事件$derive发送通知");
    List<ScheduleNotificationArgs> argsList = [];
    // 当前事件的有效提醒列表
    List<String> activeNoticeIdList = [];
    // 基于时间处理提醒 会处理noticeId的入队信息
    argsList.addAll(await _noticeByTiming(derive, activeNoticeIdList));
    // 现有的已经入队的通知拷贝 包括以前的和新增加的
    List<String> currentNoticeIdList = [...noticeIdMap[derive.id.value] ?? []];
    // 都为空返回
    if (currentNoticeIdList.isEmpty && activeNoticeIdList.isEmpty) return argsList;
    // 下面操作是为了删除无用的提醒
    // 遍历本次新增通知，从全部通知中移除
    for (String newNoticeId in activeNoticeIdList) {
      currentNoticeIdList.remove(newNoticeId);
    }
    // 如果完全一致，不需要操作
    if (currentNoticeIdList.isEmpty) return argsList;
    // 剩下的说明不需要提醒，或者已经提醒过了，需要移除
    for (String outOfDateNoticeId in currentNoticeIdList) {
      EventNoticeId? eventNoticeId = EventNoticeId.decode(outOfDateNoticeId);
      if (null == eventNoticeId) continue;
      await NotificationHelper.cancelNotification(eventNoticeId.notificationId);
      noticeIdList.remove(outOfDateNoticeId);
      noticeIdMap[derive.id.value]?.remove(outOfDateNoticeId);
    }
    // 移除完毕之后，持久化保存
    await SharedPreferencesHelper.sharedPreferences.setStringList(repositoryKey, noticeIdList.toList());
    // 处理子事件
    if (!dealChildren || derive.children.isNull) return argsList;
    for (DeriveEvent child in derive.children.value) {
      argsList.addAll(await _noticeByEvent(child, true));
    }
    return argsList;
  }

  /// 基于时间的提醒
  Future<List<ScheduleNotificationArgs>> _noticeByTiming(DeriveEvent derive, List<String> activeNoticeIdList) async {
    SingleTiming? timing = derive.timing.value;
    // 没有时间不提醒
    if (null == timing || timing.isNull) return [];
    // 分组 开始和开始提醒，结束和结束提醒
    List<List<Attribute>> list = [
      [timing.start, timing.startNotice],
      [timing.end, timing.endNotice]
    ];
    List<ScheduleNotificationArgs> argsList = [];
    // 处理开始时间和结束时间
    for (List<Attribute> subList in list) {
      // 发生时间
      DateTime? base = subList[0].value;
      // 没有时间不提醒
      if (base == null) continue;
      // 提醒
      List<Notice> noticeList = subList[1].value;
      // 提醒为空不提醒
      if (noticeList.isEmpty) continue;
      // 遍历所有提醒
      for (Notice notice in noticeList) {
        // 获取提醒时间
        DateTime? noticeTime = notice.getNoticeTime(base);
        // 没有提醒时间不提醒
        if (null == noticeTime) continue;
        // 提醒ID
        EventNoticeId noticeId = EventNoticeId(derive.id.value, noticeTime);
        String noticeIdStr = noticeId.encode();
        // 可重复调用，但不重复提醒
        if (noticeIdList.contains(noticeIdStr)) {
          _log("$derive在$noticeTime的提醒已存在，不重复添加");
          activeNoticeIdList.add(noticeIdStr);
          continue;
        }
        // 标题
        String eventContent = derive.content.value.toString();
        argsList.add(ScheduleNotificationArgs(
          id: noticeId.notificationId,
          title: "事件${subList[1].title}",
          body: eventContent.isNotEmpty ? derive.toString() : "${derive.toString()}\n$eventContent",
          dateTime: noticeTime,
          payload: NotificationPayload(type: NotificationType.event, payload: derive.id.value),
        ));
        // 添加提醒
        noticeIdList.add(noticeIdStr);
        noticeIdMap.putIfAbsent(derive.id.value, () => []).add(noticeIdStr);
        // 添加成功，加入本次成功id
        activeNoticeIdList.add(noticeIdStr);
      }
    }
    if (argsList.isNotEmpty) {
      await SharedPreferencesHelper.sharedPreferences.setStringList(repositoryKey, noticeIdList.toList());
    }
    return argsList;
  }

  /// 删除这个事件的所有通知
  Future<void> removeNoticeByEvent(DeriveEvent event, [bool dealChildren = false]) async {
    _log("取消事件$event提醒");
    await findNoticeList();
    List<String> idList = noticeIdMap[event.id.value] ?? [];
    if (idList.isEmpty) return;
    for (String id in idList) {
      noticeIdList.remove(id);
      EventNoticeId? noticeId = EventNoticeId.decode(id);
      if (noticeId == null) {
        _log("$id无法解析，跳过");
        continue;
      }
      await NotificationHelper.removeNotification(noticeId.notificationId);
    }
    noticeIdMap.putIfAbsent(event.id.value, () => []).clear();
    await SharedPreferencesHelper.sharedPreferences.setStringList(repositoryKey, noticeIdList.toList());
    // 处理子事件
    if (!dealChildren || event.children.isNull) return;
    for (DeriveEvent child in event.children.value) {
      await removeNoticeByEvent(child, true);
    }
  }

  /// 通过ID删除事件通知
  Future<void> removeNoticeByEventId(String eventId) async {
    _log("删除id为$eventId的事件提醒");
    await findNoticeList();
    List<String> idList = noticeIdMap[eventId] ?? [];
    if (idList.isEmpty) return;
    for (String id in idList) {
      noticeIdList.remove(id);
      EventNoticeId? noticeId = EventNoticeId.decode(id);
      if (noticeId == null) {
        _log("$id无法解析，跳过");
        continue;
      }
      await NotificationHelper.removeNotification(noticeId.notificationId);
    }
    noticeIdMap.putIfAbsent(eventId, () => []).clear();
    await SharedPreferencesHelper.sharedPreferences.setStringList(repositoryKey, noticeIdList.toList());
  }

  /// 通过ID取消事件通知
  /// 清楚缓存的通知 配合[NotificationHelper.removeAllNotifications]使用
  Future<void> clearAll() async {
    noticeIdList.clear();
    noticeIdMap.clear();
    await SharedPreferencesHelper.sharedPreferences.setStringList(repositoryKey, noticeIdList.toList());
  }

  /// 查找本地的提醒数据
  /// 查找的时候会删除过期的，属于惰性清除
  Future<void> findNoticeList() async {
    _log("查询shared_preferences中的提醒列表");
    // 已经查过 不需要再查
    if (noticeIdList.isNotEmpty) return _log("静态列表不为空，无需查询");
    // 静态id列表中没有，去数据库查
    List<String>? dbNoticeIdList = SharedPreferencesHelper.sharedPreferences.getStringList(repositoryKey);
    // 清空静态维护列表 这一步应该没必要，留着也不影响
    noticeIdList.clear();
    noticeIdMap.clear();
    // 为空返回
    if (dbNoticeIdList == null) return _log("shared_preferences中提醒列表为空");
    // 拷贝一份列表用于删除过期的
    List<String> finalIdList = [...dbNoticeIdList];
    // 遍历所有提醒 判断是否过期 删除过期的提醒ID
    DateTime now = DateTime.now();
    _log("基于$now判断提醒是否过期");
    for (String noticeIdStr in dbNoticeIdList) {
      EventNoticeId? noticeId = EventNoticeId.decode(noticeIdStr);
      if (noticeId == null) {
        _log("无法解析$noticeIdStr的事件和时间,跳过并删除");
        finalIdList.remove(noticeIdStr);
        continue;
      }
      if (now.isAfter(noticeId.noticeTime)) {
        _log("$noticeIdStr的时间在$now之前,删除");
        finalIdList.remove(noticeIdStr);
      }
      // 分组
      String eventId = noticeId.eventId;
      noticeIdMap.putIfAbsent(eventId, () => []).add(noticeIdStr);
    }
    // 添加到静态列表中
    noticeIdList.addAll(finalIdList);
    // 如果有过期的，更新本地存储
    if (finalIdList.length != dbNoticeIdList.length) {
      _log("存在过期提醒，更新shared_preferences");
      await SharedPreferencesHelper.sharedPreferences.setStringList(repositoryKey, finalIdList);
    }
  }
}
