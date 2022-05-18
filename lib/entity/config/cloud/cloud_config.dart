import 'package:hg_entity/hg_entity.dart';

class CloudConfig extends SimpleModel {
  late final Attribute<bool> isAutoUpload;
  late final Attribute<DateTime?> nextUploadTime;

  CloudConfig() {
    isAutoUpload = attributes.boolean(name: "is_auto_upload", title: "是否自动备份", dvalue: false);
    nextUploadTime = attributes.datetimeNullable(name: "next_upload_time", title: "下次备份时间");
  }
}
