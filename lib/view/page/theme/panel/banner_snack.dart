import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hg_framework/hg_framework.dart';
import 'shared/panel.dart';

import 'shared/color_scheme_popup_menu.dart';

/// 外部参数
@immutable
class BannerSnackArgs extends PanelArgs {
  const BannerSnackArgs({required super.onTemplateChange});
}

/// 外部数据
@immutable
class BannerSnackDataSource extends PanelDataSource {
  const BannerSnackDataSource(super.template);
}

/// 逻辑
class BannerSnackLogic extends PanelLogic<BannerSnackArgs, BannerSnackDataSource> {
  void setSnackBarSchemeColor(SchemeColor? value) {
    template.snackBarSchemeColor.value.scheme = value;
    args.onTemplateChange();
  }

  void setBottomSheetBorderRadius(double? d) {
    template.bottomSheetBorderRadius.value = d;
    args.onTemplateChange();
  }
}

/// 页面
class BannerSnackView extends PanelView<BannerSnackLogic> {
  BannerSnackView({
    required String key,
    required BannerSnackArgs args,
    required BannerSnackDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, logic: BannerSnackLogic());

  @override
  Widget buildView(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    SchemeColor? snackBarSchemeColor = logic.template.snackBarSchemeColor.value.scheme;
    double? defaultRadius = logic.template.defaultRadius.value;
    double? bottomSheetBorderRadius = logic.template.bottomSheetBorderRadius.value;

    final String labelForDefaultSelectedItem = isDark ? '默认 (light primary, 93% opacity)' : '默认 (dark primary, 95% opacity)';
    final String sheetRadiusDefaultLabel = bottomSheetBorderRadius == null && defaultRadius == null
        ? '默认 16'
        : bottomSheetBorderRadius == null && defaultRadius != null
            ? '全局 ${defaultRadius.toStringAsFixed(0)}'
            : '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.all(16),
          child: MaterialAndBottomSheetShowcase(),
        ),
        ListTile(
          enabled: true && true,
          title: const Text('底部弹框圆角'),
          subtitle: Slider.adaptive(
            min: -1,
            max: 50,
            divisions: 51,
            label: bottomSheetBorderRadius == null || bottomSheetBorderRadius < 0 ? sheetRadiusDefaultLabel : bottomSheetBorderRadius.toStringAsFixed(0),
            value: bottomSheetBorderRadius ?? -1,
            onChanged: (double value) {
              logic.setBottomSheetBorderRadius(value < 0 ? null : value);
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
                  bottomSheetBorderRadius == null || bottomSheetBorderRadius < 0 ? sheetRadiusDefaultLabel : bottomSheetBorderRadius.toStringAsFixed(0),
                  style: Theme.of(context).textTheme.caption!.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        ColorSchemePopupMenu(
          title: const Text('底部横幅提示背景色'),
          labelForDefault: labelForDefaultSelectedItem,
          index: snackBarSchemeColor?.index ?? -1,
          onChanged: (int index) {
            if (index < 0 || index >= SchemeColor.values.length) {
              logic.setSnackBarSchemeColor(null);
            } else {
              logic.setSnackBarSchemeColor(SchemeColor.values[index]);
            }
          },
        ),
      ],
    );
  }
}
