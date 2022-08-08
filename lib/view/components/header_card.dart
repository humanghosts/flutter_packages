import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hg_framework/hg_framework.dart';

class HeaderCardLogic extends ViewLogicOnly {
  /// 是否打开子组件
  final RxBool isOpen = true.obs;
}

class HeaderCard extends View<HeaderCardLogic> {
  HeaderCard({
    required String key,
    this.leading,
    this.title,
    this.subtitle,
    this.elevation,
    this.margin = EdgeInsets.zero,
    this.headerPadding,
    this.shapeBorder,
    this.color,
    this.boldTitle = true,
    this.child,
    this.canClose = true,
    this.trailing,
    this.height,
    this.width,
  }) : super(key: key, logic: HeaderCardLogic());

  final double? height;
  final double? width;
  final double? elevation;

  final bool canClose;

  final Widget? leading;

  final Widget? trailing;

  final Widget? title;

  final Widget? subtitle;

  final EdgeInsetsGeometry margin;

  final EdgeInsetsGeometry? headerPadding;

  final ShapeBorder? shapeBorder;

  final Color? color;

  final bool boldTitle;

  final Widget? child;

  @override
  Widget buildView(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    final Color cardColor = color ?? theme.cardColor;
    final Color headerColor = Color.alphaBlend(scheme.primary.withAlpha(20), cardColor);
    final bool useHeading = title != null || subtitle != null || leading != null;

    Widget? cardTitle = title;
    if (cardTitle != null && cardTitle is Text && boldTitle) {
      final Text textTitle = cardTitle;
      final TextStyle? cardTitleStyle = cardTitle.style;
      final String cardTitleText = textTitle.data ?? '';
      cardTitle = Text(
        cardTitleText,
        style: cardTitleStyle?.copyWith(fontWeight: FontWeight.bold) ?? const TextStyle(fontWeight: FontWeight.bold),
      );
    }

    return Obx(() {
      bool isOpen = logic.isOpen.value;
      return SizedBox(
        width: width == null ? null : width! + margin.horizontal,
        height: height == null ? null : (isOpen ? height! : kToolbarHeight) + margin.vertical,
        child: Card(
          margin: margin,
          color: cardColor,
          shape: shapeBorder ?? theme.cardTheme.shape,
          elevation: elevation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              if (useHeading)
                Material(
                  type: MaterialType.card,
                  color: headerColor,
                  child: SizedBox(
                    height: kToolbarHeight,
                    child: ListTile(
                      contentPadding: headerPadding,
                      leading: leading,
                      title: cardTitle,
                      subtitle: subtitle,
                      trailing: trailing ??
                          (!canClose
                              ? null
                              : Obx(() {
                                  return Clickable(
                                    onPressed: () => logic.isOpen.value = !logic.isOpen.value,
                                    tooltip: logic.isOpen.value ? "收起" : "展开",
                                    child: AnimatedSwitcher(
                                      duration: AppLogic.appConfig.animationConfig.middleAnimationDuration,
                                      child: Icon(
                                        logic.isOpen.value ? Icons.expand_less_outlined : Icons.expand_more_outlined,
                                        key: ValueKey(logic.isOpen.value),
                                        size: 32,
                                      ),
                                    ),
                                  );
                                })),
                      onTap: !canClose ? null : () => logic.isOpen.value = !logic.isOpen.value,
                    ),
                  ),
                ),
              Expanded(child: Obx(() {
                return AnimatedSwitcher(
                  duration: logic.fastAnimationDuration,
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return SizeTransition(
                      sizeFactor: animation,
                      child: child,
                    );
                  },
                  child: (logic.isOpen.value && child != null)
                      ? Container(
                          key: ValueKey(logic.isOpen.value),
                          child: child,
                        )
                      : SizedBox.shrink(key: ValueKey(logic.isOpen.value)),
                );
              })),
            ],
          ),
        ),
      );
    });
  }
}
