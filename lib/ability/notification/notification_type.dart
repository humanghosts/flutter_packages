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
  /// 名称
  final String name;

  /// 点击回调方法
  final Function(String? payload) callback;

  NotificationType._(this.name, this.callback);
}
