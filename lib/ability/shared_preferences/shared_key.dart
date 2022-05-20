/// 开始shared_preferences的key集合，防止key重复
class SharedPreferencesKeys1 {
  SharedPreferencesKeys1._();

  /// 应用初始化数据
  static const String isInitAppDatabaseData = "is_init_app_database_data";

  /// 通知缓存
  static const String notificationCache = "notification_cache";
  static const String oldNotificationCache = "notification_cache_old";

  /// 是否正在上传数据
  static const String isUploading = "is_uploading";

  /// 事件提醒列表
  static const String eventNoticeList = "event_notice_list";

  /// 是否显示介绍页
  static const String isShowIntro = "is_intro";

// 是否显示用户引导页引导 所有 is_${HomePage.value}_tutorial开头的
// 是否显示用户引导页引导 所有 is_${HomePage.value}_sub_page_list
  /// 是否强制关闭所有用户引导
  static const String isCloseAllTutorial = "is_close_all_tutorial";
}
