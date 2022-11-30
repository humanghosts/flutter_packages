/// 通知类型
class NotificationTypes {
  NotificationTypes._();

  static final Map<String, NotificationType> _map = {};

  static void put(NotificationType type) {
    _map[type.name] = type;
  }

  static NotificationType? get(String name) => _map[name];
}

/// 通知类型
abstract class NotificationType {
  String get name;

  /// 回调方法
  Future<void> callback(String? payload);
}
