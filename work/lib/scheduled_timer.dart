import 'dart:async';
import 'dart:ui';

import 'package:hgs_prefs/prefs.dart';

/// 定时执行工具
/// TODO 修改，更简单易用
/// 代码来自https://github.com/magnuswikhog/scheduled_timer
/// 已fork修改，由于要改动这个功能，暂时放到framework里面，防止已有的报错。
class ScheduledTimer {
  /// 定时器ID
  String? _id;

  /// 定时器执行回调
  late VoidCallback _onExecute;

  /// 错过时间回调
  VoidCallback? _onMissedSchedule;

  /// 下次执行时间
  DateTime? _nextRun;

  /// 定时器
  Timer? _timer;

  /// 定时器缓存
  static final Map<String, ScheduledTimer> _cache = <String, ScheduledTimer>{};

  /// 创建一个定时器
  ScheduledTimer({required String id, required VoidCallback onExecute, DateTime? defaultScheduledTime, VoidCallback? onMissedSchedule}) {
    _id = id;
    _onExecute = onExecute;
    _onMissedSchedule = onMissedSchedule;

    _loadStoredNextRun().then((_) {
      if (_nextRun == null) {
        if (defaultScheduledTime != null) {
          schedule(defaultScheduledTime);
        }
      } else {
        start();
      }
    });
  }

  ScheduledTimer._({required String id, required VoidCallback onExecute, VoidCallback? onMissedSchedule}) {
    _id = id;
    _onExecute = onExecute;
    _onMissedSchedule = onMissedSchedule;
  }

  /// 创建一个定时执行器，但是不执行
  /// 创建之后必须手动调用[scheduled]
  /// 可以使用[exists]判断定时执行器存不存在，防止同时创建多个执行器
  factory ScheduledTimer.fromId({required String id, required VoidCallback onExecute, VoidCallback? onMissedSchedule}) {
    return _cache.putIfAbsent(id, () => ScheduledTimer._(id: id, onExecute: onExecute, onMissedSchedule: onMissedSchedule));
  }

  /// 获取定时器执行时间
  DateTime? get scheduledTime => _nextRun;

  /// 获取定时器ID
  String? get id => _id;

  /// 停止定时任务
  void stop() {
    _timer?.cancel();
  }

  /// 设置下一次执行的时间
  Future<void> schedule(DateTime scheduledTime) async {
    stop();
    await _setNextRun(scheduledTime);
    start();
  }

  /// 停止定时任务并清空下次执行时间
  Future<void> clearSchedule() async {
    stop();
    await _clearNextRun();
  }

  /// 启动计时器
  void start() async {
    _timer?.cancel();

    if (_nextRun != null) {
      Duration diff = _nextRun!.difference(DateTime.now());

      if (!diff.isNegative) {
        _timer = Timer(diff, () async {
          _onExecute();
          await _clearNextRun();
        });
      } else {
        if (_onMissedSchedule != null) {
          _onMissedSchedule!();
        }
      }
    }
  }

  /// 手动执行
  void execute() {
    _onExecute();
  }

  Future<void> _setNextRun(DateTime nextRun) async {
    _nextRun = nextRun;
    await PrefsHelper().prefs.setInt('_scheduledtimer_nextrun_$_id', _nextRun!.millisecondsSinceEpoch);
  }

  Future<void> _clearNextRun() async {
    _nextRun = null;
    await PrefsHelper().prefs.remove('_scheduledtimer_nextrun_$_id');
  }

  Future<void> _loadStoredNextRun() async {
    int? ts = PrefsHelper().prefs.getInt('_scheduledtimer_nextrun_$_id');
    if (ts != null) _nextRun = DateTime.fromMillisecondsSinceEpoch(ts);
  }

  Future<void> load() async {
    int? ts = PrefsHelper().prefs.getInt('_scheduledtimer_nextrun_$_id');
    if (ts != null) _nextRun = DateTime.fromMillisecondsSinceEpoch(ts);
  }
}
