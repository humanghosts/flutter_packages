import 'package:flutter/cupertino.dart';
import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/config.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_orm/hg_orm.dart';
import 'package:scheduled_timer/scheduled_timer.dart';

import '../../services.dart';

/// 主页标签设置服务
class CloudConfigService extends SimpleModelService<CloudConfig> {
  CloudConfigService._();

  static CloudConfigService? _instance;

  static CloudConfigService get instance => _instance ??= CloudConfigService._();

  static const String timerKey = "auto_upload_data";

  /// 云服务是否可用
  Future<bool> isCloudAvailable() async {
    return true;
  }

  /// 是否正在自动备份
  bool isAutoUploading() {
    return SharedPreferencesHelper.sharedPreferences.getBool(SharedPreferencesKeys.isUploading) ?? false;
  }

  /// 自动备份
  void autoUpload({ValueChanged<Object>? onData, ValueChanged<CloudConfig>? onDone, ValueChanged<Object>? onError}) async {
    // 查询最新配置
    CloudConfig cloudConfig = await find();
    // 是否自动备份
    bool isAutoUpload = cloudConfig.isAutoUpload.value;
    // 不自动不处理 没有备份时间不处理
    if (!isAutoUpload || cloudConfig.nextUploadTime.isNull) {
      cancelAutoUpload();
      return;
    }
    // 自动备份时间
    DateTime uploadTime = cloudConfig.nextUploadTime.value!;
    // 定时执行器
    late ScheduledTimer timer;
    timer = ScheduledTimer(
      id: "auto_upload_data",
      onExecute: () async {
        DateTime now = DateTime.now();
        if (now.isBefore(uploadTime)) {
          if (timer.scheduledTime?.millisecondsSinceEpoch != uploadTime.millisecondsSinceEpoch) {
            timer.schedule(uploadTime);
          }
          return;
        }
        await SharedPreferencesHelper.sharedPreferences.setBool(SharedPreferencesKeys.isUploading, true);
        // 备份
        CloudHelper.cloud.upload(
          CloudFile(AppConfig.dbConfig.dbFileName),
          onData: onData,
          onDone: () async {
            // 当前时间
            DateTime now = DateTime.now();
            // 预计下次执行时间
            DateTime nextUploadTime = DateTime(uploadTime.year, uploadTime.month, uploadTime.day + 1, uploadTime.hour, uploadTime.minute);
            // 如果下次执行时间还是小于今天，直接变成明天更新，防止用户很久没有打开应用，在这里一直重复备份
            if (now.isAfter(nextUploadTime)) {
              nextUploadTime = DateTime(now.year, now.month, now.day + 1, uploadTime.hour, uploadTime.minute);
            }
            // 备份成功，更新数据库下次备份时间
            cloudConfig.nextUploadTime.value = nextUploadTime;
            await save(cloudConfig);
            // 更新计时器
            timer.schedule(cloudConfig.nextUploadTime.value!);
            await SharedPreferencesHelper.sharedPreferences.setBool(SharedPreferencesKeys.isUploading, false);
            onDone?.call(cloudConfig);
          },
          onError: (value) async {
            await SharedPreferencesHelper.sharedPreferences.setBool(SharedPreferencesKeys.isUploading, true);
            onError?.call(value);
          },
        );
      },
      defaultScheduledTime: uploadTime,
      onMissedSchedule: () {
        timer.execute();
      },
    );
  }

  /// 取消自动备份
  void cancelAutoUpload() {
    late ScheduledTimer timer;
    timer = ScheduledTimer(
      id: timerKey,
      onExecute: () {
        timer.clearSchedule();
      },
      onMissedSchedule: () {
        timer.clearSchedule(); // Execute onExecute() immediately
      },
    );
    timer.clearSchedule();
  }

  /// 下载之后回调
  Future<void> afterDownload() async {
    await DatabaseHelper.refresh(path: AppConfig.dbConfig.dbFileName, databaseType: DatabaseType.sembast);
    await DeriveEventService.instance.updateBadges();
    // 刷新应用
    await MainLogic.instance.rebuild();
    // 取消所有提醒
    await NotificationHelper.removeAllNotifications();
    await EventNoticeService.instance.clearAll();
    // 日程提醒处理
    ScheduleConfig config = await ScheduleConfigService.instance.find();
    await ScheduleConfigService.instance.sendNotice(config);
    // 事件提醒处理
    List<DeriveEvent> eventList = await DeriveEventService.instance.findTree();
    await EventNoticeService.instance.noticeByEventList(eventList, true);
  }
}
