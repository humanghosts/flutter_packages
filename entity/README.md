# entity

实体支持，拒绝代码生成。
支持和GetX一起使用，简化代码。

# 开始使用

## 创建实体
```dart
class NewDataModel extends Model {
  /// ID
  late final Attribute<String> id;
  static const idKey = "id";

  /// 创建时间
  late final Attribute<DateTime?> createTime;
  static const createTimeKey = "create_time";

  /// 是否删除
  late final Attribute<bool> isDelete;
  static const isDeleteKey = "is_delete";

  /// 删除时间
  late final Attribute<DateTime?> deleteTime;
  static const deleteTimeKey = "delete_time";

  /// 时间戳
  late final Attribute<DateTime> timestamp;
  static const timestampKey = "timestamp";

  /// 版本
  late final Attribute<String?> version;
  static const versionKey = "version";

  DataModel({
    String? id,
    DateTime? createTime,
    bool? isDelete,
    DateTime? deleteTime,
    DateTime? timestamp,
    String? version,
  }) {
    this.id = attributes.string(name: idKey, title: "ID", dvalue: idGenerator.id, value: id);
    this.createTime = attributes.datetimeNullable(name: createTimeKey, title: "创建时间", value: createTime);
    this.isDelete = attributes.boolean(name: isDeleteKey, title: "是否删除", dvalue: false, value: isDelete);
    this.deleteTime = attributes.datetimeNullable(name: deleteTimeKey, title: "删除时间", dvalue: deleteTime);
    this.timestamp = attributes.datetime(name: timestampKey, title: "时间戳", dvalue: DateTime.now(), value: timestamp);
    this.version = attributes.stringNullable(name: versionKey, title: "版本", value: version);
  }
}
```

## 使用实体
```dart

NewDataModel nm = NewDataModel();
String id = nm.id.value;
```

## 和Get一起使用
```dart
Widget widget = Obx(()=>Text(nm.id.value));
```
