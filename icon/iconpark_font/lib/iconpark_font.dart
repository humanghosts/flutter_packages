import 'package:hgs_icon/icon.dart';

export 'iconparks.dart';

/// 字节跳动IconPark图标 svg类型，官网：https://iconpark.oceanengine.com/official
class IconPark extends FontIcon {
  /// id
  final int id;

  /// 名称
  final String name;

  /// 中文名称
  final String title;

  /// 类别，对应Source下的文件夹
  final String category;

  /// 类别中文名称
  final String categoryCN;

  /// 图标作者
  final String author;

  /// 图标标签
  final List<String> tag;

  final bool rtl;

  const IconPark({
    required this.id,
    required this.name,
    required this.title,
    required this.category,
    required this.categoryCN,
    required this.author,
    required this.tag,
    required this.rtl,
    super.fontFamily,
    super.fontPackage,
    super.matchTextDirection = false,
    required int codePoint,
  }) : super(codePoint);
}
