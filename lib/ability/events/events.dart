import 'dart:async';

typedef EventsCallback<T extends Object?> = FutureOr<void> Function(T value);
typedef _NameMap<T extends Object?> = Map<String, EventsCallback<T>>;
typedef _PriorityMap<T extends Object?> = Map<int, _NameMap<T>>;

/// 事件分发助手
class EventsHelper<T extends Object?> {
  String key;

  EventsHelper._({required this.key});

  /// 优先级列表
  final _PriorityMap<T> _priorityMap = {};

  /// 名称和优先级的映射
  final Map<String, int> _namePriority = {};

  /// 监听
  void listen({required String key, int priority = 50, required EventsCallback<T> callback}) {
    // 名称列表
    _NameMap<T> _nameMap = _priorityMap.putIfAbsent(priority, () => {});
    // 注册或替换
    _nameMap[key] = callback;
    // 如果存在已经注册过的但优先级不一样的方法 移除
    if (_namePriority.containsKey(key)) {
      int oldPriority = _namePriority[key]!;
      _NameMap<T> _oldNameMap = _priorityMap.putIfAbsent(oldPriority, () => {});
      _oldNameMap.remove(key);
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

  /// 角标更新事件
  static EventsHelper<int> badgesUpdate = EventsHelper._(key: "badgesUpdate");
}
