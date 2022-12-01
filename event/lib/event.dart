import 'dart:async';

typedef EventsCallback<T extends Object?> = FutureOr<void> Function(T value);
typedef _NameMap<T extends Object?> = Map<String, EventsCallback<T>>;
typedef _PriorityMap<T extends Object?> = Map<int, _NameMap<T>>;

/// 事件分发助手
/// 使用方法
/// ```
/// /// 创建事件快捷助手
/// class EventsHelper{
///   static EventsHandler<int> badgesUpdate = EventsHandler();
/// }
/// /// 使用
/// EventsHelper.badgesUpdate.listen();
/// /// 或者可以使用一个map记录事件
/// ```
class EventsHandler<T extends Object?> {
  /// 优先级列表
  final _PriorityMap<T> _priorityMap = {};

  /// 名称和优先级的映射
  final Map<String, int> _namePriority = {};

  /// 监听
  /// [key] 监听器的key，和EventsHandler的key不是一个东西，防止一个地方重复注册监听
  /// [priority] 优先级，事件发生时，调用回调的优先级
  /// [callback] 回调方法
  void listen({required String key, int priority = 50, required EventsCallback<T> callback}) {
    // 名称列表
    _NameMap<T> nameMap = _priorityMap.putIfAbsent(priority, () => {});
    // 注册或替换
    nameMap[key] = callback;
    // 如果存在已经注册过的但优先级不一样的方法 移除
    if (_namePriority.containsKey(key)) {
      int oldPriority = _namePriority[key]!;
      _NameMap<T> oldNameMap = _priorityMap.putIfAbsent(oldPriority, () => {});
      oldNameMap.remove(key);
    }
    _namePriority[key] = priority;
  }

  /// 通知 按照优先级从高到低，同优先级按照name顺序(具体顺序是map to list时候的顺序)
  void notify(T args) async {
    if (_priorityMap.isEmpty) return;
    List<int> priorityList = _priorityMap.keys.toList();
    // 按照优先级从高到低排序
    priorityList.sort((a, b) => b - a);
    for (int priority in priorityList) {
      List<EventsCallback<T>>? callbackList = _priorityMap[priority]?.values.toList();
      if (callbackList == null || callbackList.isEmpty) continue;
      for (EventsCallback<T> callback in callbackList) {
        FutureOr<void> result = callback.call(args);
        if (result is Future) await result;
      }
    }
  }

  /// 移除监听
  void remove(String key) {
    if (_priorityMap.isEmpty) return;
    int? priority = _namePriority[key];
    if (null == priority) return;
    // 名称列表
    _NameMap<T>? nameMap = _priorityMap[priority];
    if (nameMap == null || nameMap.isEmpty) return;
    nameMap.remove(key);
    _namePriority.remove(key);
  }
}
