import 'dart:convert';

import 'package:hg_entity/hg_entity.dart';
import 'package:zefyr/zefyr.dart';

/// 富文本的抽象类
class Content extends CustomValue {
  /// 文本内容
  NotusDocument? document;

  /// 构造
  Content({this.document});

  /// 是否为空
  @override
  bool get isNull {
    int length = document?.length ?? 0;
    return length <= 1;
  }

  /// 转换为map
  @override
  Future<String?> toMap({Map<String, Object?>? args}) async {
    if (isNull) return null;
    return json.encode(document?.toDelta().toJson());
  }

  /// 从map转换
  @override
  Future<Content> fromMap(Object? value, {Map<String, Object?>? args}) async {
    if (value is! String) return this;
    document = NotusDocument.fromJson(json.decode(value));
    return this;
  }

  /// 复制
  @override
  Content clone() {
    NotusDocument? document;
    if (null != this.document) {
      String value = json.encode(this.document?.toDelta().toJson());
      document = NotusDocument.fromJson(json.decode(value));
    }
    Content content = Content(document: document);
    return content;
  }

  /// 合并
  @override
  Content merge(Object value) {
    if (value is! Content) return this;
    document = value.document;
    return this;
  }

  /// 转换为字符串
  @override
  String toString() {
    if (null == document) return "";
    return document!.toPlainText().replaceAll("\n", " ");
  }
}
