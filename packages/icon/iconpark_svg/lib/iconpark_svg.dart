import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icon/icon.dart';

import 'runtime.dart';

export 'iconparks.dart';
export 'runtime.dart';

/// 字节跳动IconPark图标 svg类型，官网：https://iconpark.oceanengine.com/official
/// 因为支持动态修改的原因，无法做成const类型。
/// 因为超类的[svg]属性是final类型，所以无法修改。
/// 可以使用[copyWithProps]拷贝新的图标修改。
/// 或者通过[setIconParkConfig]修改全局设置。
class IconPark extends SvgIcon {
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

  /// 图标包裹
  final IIconWrapper iconWrapper;

  /// 图标属性
  final IIconProps props;

  IconPark({
    required this.id,
    required this.name,
    required this.title,
    required this.category,
    required this.categoryCN,
    required this.author,
    required this.tag,
    required this.rtl,
    required this.iconWrapper,
    this.props = const IIconProps(),
  }) : super(svg: iconWrapper(props));

  /// 通过修改配置 拷贝出一个新的图标 可用于存储
  IconPark copyWithProps(IIconProps props) {
    return IconPark(
      id: id,
      name: name,
      title: title,
      category: category,
      categoryCN: categoryCN,
      author: author,
      tag: tag,
      rtl: rtl,
      iconWrapper: iconWrapper,
      props: props,
    );
  }

  /// 使用指定属性构建，不会影响图标本身的属性
  Widget buildWithProps({IIconProps? props}) {
    if (null == props) return build();
    return SvgPicture.string(
      iconWrapper(props),
      height: props.size?.toDouble(),
      width: props.size?.toDouble(),
    );
  }
}
