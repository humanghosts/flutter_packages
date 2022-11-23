import 'package:icon/icon.dart';

/// 字节跳动IconPark图标 svg类型，官网：https://iconpark.oceanengine.com/official
class IconPark extends SvgIconEnum<SvgIcon> {
  /// id
  final int id;

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

  const IconPark._({
    required this.id,
    required super.name,
    required this.title,
    required this.category,
    required this.categoryCN,
    required this.author,
    required this.tag,
    required this.rtl,
  });

  /// 资源文件路径
  @override
  String get path => "lib/source/$category/$name";
}
