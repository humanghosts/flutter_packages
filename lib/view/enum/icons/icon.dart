import 'package:flutter/material.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/view/component/export.dart';

/// 图标枚举
/// 新增图标枚举做法
/// 1.新增类继承[IconEnum] 添加图标，添加map支持搜索功能
/// 2.如果是新的类型，修改[IconType]和[IconValue]的构造和fromMap方法以及[Logo]的buildIcon方法
/// 3.[HgNeumorphicIcon]构建修改
abstract class IconEnum<T extends IconType> {
  final String name;

  /// 获取图标类型
  Type get iconType => T;

  IconEnum({required this.name});
}

abstract class FontIconEnum<T extends FontIcon> extends IconEnum<T> {
  final IconData iconData;

  FontIconEnum({required String name, required this.iconData}) : super(name: name);

  String? get fontFamily => iconData.fontFamily;

  int get codePoint => iconData.codePoint;

  String? get fontPackage => iconData.fontPackage;

  bool get matchTextDirection => iconData.matchTextDirection;
}

abstract class SvgIconEnum<T extends SvgIcon> extends IconEnum<T> {
  SvgIconEnum({required String name}) : super(name: name);

  /// 获取文件夹路径
  String get directory;

  /// 获取文件路径
  String get path;

  /// 获取图标数据
  IconValue get iconValue => IconValue.svg(path: path);
}
