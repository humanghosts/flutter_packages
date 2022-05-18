import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/export.dart';

import 'attribute/attribute.dart';
import 'event/event.dart';
import 'focus/focus.dart';
import 'home_page.dart';
import 'log/log.dart';
import 'quickaccess/quickaccess.dart';
import 'schedule/schedule.dart';
import 'settings/settings.dart';

export '../view.dart';
export 'attribute/attribute.dart';
export 'event/action/auto_action.dart';
export 'event/action/quick_action.dart';
export 'event/event.dart';
export 'focus/focus.dart';
export 'home_page.dart';
export 'introduction/introduction.dart';
export 'quickaccess/quickaccess.dart';
export 'schedule/schedule.dart';
export 'settings/cloud/cloud.dart';

class HomePages {
  /// 值
  final String value;

  /// 标题
  final String title;

  /// 图标
  final IconData iconData;

  /// 构建方法
  final Widget Function({int? navigatorId}) build;

  /// 控制器
  final HomePageLogic? Function() getLogic;

  const HomePages._({
    required this.value,
    required this.title,
    required this.iconData,
    required this.build,
    required this.getLogic,
  });

  static const _quickaccessKey = "/quickaccess";
  static const _eventKey = '/event';
  static const _attributeKey = '/attribute';
  static const _scheduleKey = "/schedule";
  static const _focusKey = "/focus";
  static const _settingsKey = "/settings";
  static const _logKey = "/log";

  static List<HomePages> list = [
    quickaccess,
    event,
    attribute,
    schedule,
    focus,
    // log,
    settings,
  ];

  static Map<String, HomePages> map = {
    _quickaccessKey: quickaccess,
    _eventKey: event,
    _attributeKey: attribute,
    _scheduleKey: schedule,
    _focusKey: focus,
    _settingsKey: settings,
    // _logKey: log,
  };

  /// 用于数据库保存
  String toMap() => value;

  /// 数据库到枚举转换
  HomePages? fromMap(String value) => map[value];

  /// 是否显示引导
  bool get isTutorial => TutorialHelper.getIsTutorial(this);

  /// 桌面
  static final HomePages quickaccess = HomePages._(
    value: _quickaccessKey,
    title: "快速访问",
    iconData: Icons.home,
    build: ({int? navigatorId}) {
      int id = navigatorId ?? _quickaccessKey.hashCode;
      return QuickAccessHomePage(key: _quickaccessKey, args: HomePageArgs(navigatorId: id));
    },
    getLogic: () => Get.put<QuickAccessHomeLogic>(QuickAccessHomeLogic(), tag: _quickaccessKey),
  );

  /// 事件主页
  static final event = HomePages._(
    value: _eventKey,
    title: "事件",
    iconData: Icons.list_alt,
    build: ({int? navigatorId}) {
      int id = navigatorId ?? _eventKey.hashCode;
      return EventHomePage(key: _eventKey, args: HomePageArgs(navigatorId: id));
    },
    getLogic: () => Get.put<EventHomeLogic>(EventHomeLogic(), tag: _eventKey),
  );

  /// 事件属性主页
  static final attribute = HomePages._(
    value: _attributeKey,
    title: "事件属性",
    iconData: Icons.label_outline,
    build: ({int? navigatorId}) {
      int id = navigatorId ?? _attributeKey.hashCode;
      return AttributeHomePage(key: _attributeKey, args: HomePageArgs(navigatorId: id));
    },
    getLogic: () => Get.put<AttributeHomeLogic>(AttributeHomeLogic(), tag: _attributeKey),
  );

  static final schedule = HomePages._(
    value: _scheduleKey,
    title: "日程",
    iconData: Icons.event_outlined,
    build: ({int? navigatorId}) {
      int id = navigatorId ?? _scheduleKey.hashCode;
      return ScheduleHomePage(key: _scheduleKey, args: HomePageArgs(navigatorId: id));
    },
    getLogic: () => Get.put<ScheduleHomeLogic>(ScheduleHomeLogic(), tag: _scheduleKey),
  );

  static final focus = HomePages._(
    value: _focusKey,
    title: "专注",
    iconData: Icons.alarm_outlined,
    build: ({int? navigatorId}) {
      int id = navigatorId ?? _focusKey.hashCode;
      return FocusHomePage(key: _focusKey, args: HomePageArgs(navigatorId: id));
    },
    getLogic: () => Get.put<FocusHomeLogic>(FocusHomeLogic(), tag: _focusKey),
  );

  /// 设置
  static final settings = HomePages._(
    value: _settingsKey,
    title: "设置",
    iconData: Icons.settings,
    build: ({int? navigatorId}) {
      int id = navigatorId ?? _settingsKey.hashCode;
      return SettingsHomePage(key: _settingsKey, args: HomePageArgs(navigatorId: id));
    },
    getLogic: () => Get.put<SettingsHomeLogic>(SettingsHomeLogic(), tag: _settingsKey),
  );

  /// 日志 调试用
  static final log = HomePages._(
    value: _logKey,
    title: "日志",
    iconData: Icons.terminal,
    build: ({int? navigatorId}) {
      int id = navigatorId ?? _logKey.hashCode;
      return LogHome(key: _logKey, args: HomePageArgs(navigatorId: id));
    },
    getLogic: () => Get.put<LogHomeLogic>(LogHomeLogic(), tag: _logKey),
  );

  /// 获取导航id
  int get navigatorId => value.hashCode;
}
