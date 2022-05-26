import 'package:flutter/material.dart';
import 'package:hg_framework/hg_framework.dart';
import 'shared/panel.dart';

/// 外部参数
@immutable
class CardArgs extends PanelArgs {
  const CardArgs({required super.onTemplateChange});
}

/// 外部数据
@immutable
class CardDataSource extends PanelDataSource {
  const CardDataSource(super.template);
}

/// 逻辑
class CardLogic extends PanelLogic<CardArgs, CardDataSource> {
  void setCardBorderRadius(double? d) {
    template.cardBorderRadius.value = d;
    args.onTemplateChange();
  }
}

/// 页面
class CardView extends PanelView<CardLogic> {
  CardView({
    required String key,
    required CardArgs args,
    required CardDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, logic: CardLogic());

  @override
  Widget buildView(BuildContext context) {
    double? cardBorderRadius = logic.template.cardBorderRadius.value;
    double? defaultRadius = logic.template.defaultRadius.value;

    final String cardRadiusDefaultLabel = cardBorderRadius == null && defaultRadius == null
        ? '默认 12'
        : cardBorderRadius == null && defaultRadius != null
            ? '全局 ${defaultRadius.toStringAsFixed(0)}'
            : '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          title: const Text('卡片边框圆角'),
          subtitle: Slider.adaptive(
            min: -1,
            max: 40,
            divisions: 41,
            label: cardBorderRadius == null || cardBorderRadius < 0 ? cardRadiusDefaultLabel : cardBorderRadius.toStringAsFixed(0),
            value: cardBorderRadius ?? -1,
            onChanged: (double value) {
              logic.setCardBorderRadius(value < 0 ? null : value);
            },
          ),
          trailing: Padding(
            padding: const EdgeInsetsDirectional.only(end: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  '圆角半径',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  cardBorderRadius == null || cardBorderRadius < 0 ? cardRadiusDefaultLabel : cardBorderRadius.toStringAsFixed(0),
                  style: Theme.of(context).textTheme.caption!.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(16),
          child: CardShowcase(),
        ),
      ],
    );
  }
}
