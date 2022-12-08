import 'dart:typed_data';

import 'package:hgs_entity/entity.dart';

/// 图片数据存储
class ImageValue extends CustomValue {
  /// 二进制数据
  Uint8List? data;

  ImageValue({this.data});

  @override
  ImageValue clone() {
    if (null == data) return ImageValue();
    Uint8List dataClone = Uint8List.fromList(data!);
    return ImageValue(data: dataClone);
  }

  @override
  Future<ImageValue> fromMap(Object? value, {Map<String, Object?>? args}) async {
    if (value is! List) return this;
    data = Uint8List.fromList(value.map((e) => e as int).toList());
    return this;
  }

  @override
  bool get isNull => data == null;

  @override
  ImageValue merge(CustomValue value) {
    if (value is! ImageValue) return this;
    Uint8List? mergeData = value.data;
    if (null == mergeData) {
      data = null;
      return this;
    }
    data = Uint8List.fromList(mergeData);
    return this;
  }

  @override
  Future<Object?> toMap({Map<String, Object?>? args}) async {
    return data?.toList();
  }

  @override
  String toString() => "${data?.hashCode}";
}
