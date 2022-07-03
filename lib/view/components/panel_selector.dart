import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PanelSelectorHeaderDelegate extends SliverPersistentHeaderDelegate {
  PanelSelectorHeaderDelegate({
    required this.extent,
    required this.builder,
    required this.vsync,
  });

  @override
  final TickerProvider vsync;
  final double extent;
  final Widget Function(BuildContext context, double shrinkOffset, bool overlapsContent) builder;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return builder(context, shrinkOffset, overlapsContent);
  }

  @override
  double get maxExtent => extent;

  @override
  double get minExtent => extent;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != minExtent;
  }

  @override
  FloatingHeaderSnapConfiguration? get snapConfiguration => FloatingHeaderSnapConfiguration();
}
