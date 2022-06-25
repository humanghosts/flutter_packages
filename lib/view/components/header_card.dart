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
    this.margin = EdgeInsets.zero,
    this.headerPadding,
    this.elevation = 0,
    this.color,
    this.boldTitle = true,
    this.child,
  }) : super(key: key, logic: HeaderCardLogic());

  final Widget? leading;

  final Widget? title;

  final Widget? subtitle;

  final EdgeInsetsGeometry margin;

  final EdgeInsetsGeometry? headerPadding;

  final double elevation;

  final Color? color;

  final bool boldTitle;

  final Widget? child;

  @override
  Widget buildView(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    final Color cardColor = color ?? theme.cardColor;
    final Color headerColor = Color.alphaBlend(scheme.primary.withAlpha(20), cardColor);
    ShapeBorder? shapeBorder = theme.cardTheme.shape;
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

    return Card(
      margin: margin,
      color: cardColor,
      shape: shapeBorder,
      elevation: elevation,
      child: Column(
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
                  trailing: Obx(() {
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
                  }),
                  onTap: () => logic.isOpen.value = !logic.isOpen.value,
                ),
              ),
            ),
          Obx(() {
            return AnimatedSwitcher(
              duration: AppLogic.appConfig.animationConfig.middleAnimationDuration,
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
          }),
        ],
      ),
    );
  }
}