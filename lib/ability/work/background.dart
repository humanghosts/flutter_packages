// import 'package:background_fetch/background_fetch.dart';

// import '../log/log.dart';

/// 后台任务工具
class BackgroundWorkHelper {
  BackgroundWorkHelper._();

  /// 初始化
  static Future<void> init() async {
    // LogHelper.debug("开始初始化后台任务");
    // bool isInit = await BackgroundFetch.registerHeadlessTask(_headlessTaskCallback);
    // BackgroundFetchConfig config = BackgroundFetchConfig(
    //     minimumFetchInterval: 15,
    //     stopOnTerminate: false,
    //     enableHeadless: true,
    //     requiresBatteryNotLow: false,
    //     requiresCharging: false,
    //     requiresStorageNotLow: false,
    //     requiresDeviceIdle: false,
    //     requiredNetworkType: NetworkType.NONE);
    // int status = await BackgroundFetch.configure(config, _onFetch, _onTimeout);
    // LogHelper.debug("初始化后台任务完成,初始化结果$isInit $status");
  }

  // /// 后台任务回调 仅限android
  // static void _headlessTaskCallback(HeadlessTask task) async {
  //   String taskId = task.taskId;
  //   bool isTimeout = task.timeout;
  //   if (isTimeout) {
  //     // This task has exceeded its allowed running-time.
  //     // You must stop what you're doing and immediately .finish(taskId)
  //     LogHelper.debug("[BackgroundFetch] Headless task timed-out: $taskId");
  //     BackgroundFetch.finish(taskId);
  //     return;
  //   }
  //   LogHelper.debug('[BackgroundFetch] Headless event received.');
  //   // Do your work here...
  //   BackgroundFetch.finish(taskId);
  // }
  //
  // /// 请求数据回调
  // static Future<void> _onFetch(String taskId) async {
  //   LogHelper.debug("[BackgroundFetch] Event received $taskId");
  //   BackgroundFetch.finish(taskId);
  // }
  //
  // /// 超时回调
  // static Future<void> _onTimeout(String taskId) async {
  //   LogHelper.debug("[BackgroundFetch] TASK TIMEOUT taskId: $taskId");
  //   BackgroundFetch.finish(taskId);
  // }
}
