import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResponsiveListView extends StatelessWidget {
  final int itemCount;
  final double width;
  final double mainAxisExtent;
  final IndexedWidgetBuilder itemBuilder;
  final EdgeInsetsGeometry? padding;

  const ResponsiveListView({
    Key? key,
    required this.itemCount,
    this.width = 400,
    this.mainAxisExtent = 64,
    required this.itemBuilder,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    int columnLength = math.max((width / this.width).floor(), 1);

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columnLength,
        mainAxisExtent: mainAxisExtent,
      ),
      padding: padding,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
