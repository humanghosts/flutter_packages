import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hgs_notification/notification.dart';

/// 通知的负载
@immutable
class NotificationPayload {
  /// 通知类型，用户触发回调等操作
  final NotificationType type;
  static const String _typeKey = "type";

  /// 通知实质上携带的负载
  final String? payload;
  static const String _payloadKey = "payload";

  const NotificationPayload({required this.type, this.payload});

  /// 通知负载解码
  static NotificationPayload? decode(String? notificationPayload) {
    if (null == notificationPayload || notificationPayload.isEmpty) return null;
    Map<String, dynamic> payloadMap = json.decode(notificationPayload);
    NotificationType? callbackType = NotificationTypes.get(payloadMap[_typeKey]);
    if (null == callbackType) return null;
    return NotificationPayload(type: callbackType, payload: payloadMap[_payloadKey]);
  }

  /// 通知负载编码
  String? encode() {
    return json.encode({_typeKey: type.name, _payloadKey: payload});
  }
}
