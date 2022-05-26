import 'dart:math' as math;

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_framework/ability/export.dart';
import 'package:hg_framework/hg_framework.dart';

import 'shared/color_name_value.dart';
import 'shared/color_picker_inkwell.dart';
import 'shared/panel.dart';

/// 外部参数
@immutable
class GlobalSettingsArgs extends PanelArgs {
  const GlobalSettingsArgs({required super.onTemplateChange});
}

/// 外部数据
@immutable
class GlobalSettingsDataSource extends PanelDataSource {
  const GlobalSettingsDataSource(super.template);
}

/// 逻辑
class GlobalSettingsLogic extends PanelLogic<GlobalSettingsArgs, GlobalSettingsDataSource> {
  bool get swapColors {
    ThemeMode themeMode = template.themeMode.value.mode;
    switch (themeMode) {
      case ThemeMode.system:
        return AppLogic.instance.isDarkMode ? template.swapDarkColors.value : template.swapLightColors.value;
      case ThemeMode.light:
        return template.swapLightColors.value;
      case ThemeMode.dark:
        return template.swapDarkColors.value;
    }
  }

  /// 设置主题使用的颜色数量
  void setUsedColors(int value) {
    template.usedColors.value = value;
    args.onTemplateChange();
  }

  /// 设置是否交换主次要色彩
  void setSwapColors(bool value) {
    ThemeMode themeMode = template.themeMode.value.mode;
    switch (themeMode) {
      case ThemeMode.system:
        AppLogic.instance.isDarkMode ? template.swapDarkColors.value = value : template.swapLightColors.value = value;
        break;
      case ThemeMode.light:
        template.swapLightColors.value = value;
        break;
      case ThemeMode.dark:
        template.swapDarkColors.value = value;
        break;
    }
    args.onTemplateChange();
  }

  /// 设置颜色
  void setColor({
    required Color color,
    required bool isLight,
    required Attribute<ColorValue> light,
    required Attribute<ColorValue> dark,
  }) {
    if (isLight) {
      light.value.color = color;
    } else {
      dark.value.color = color;
    }
    args.onTemplateChange();
  }

  /// 设置默认圆角
  void setDefaultRadius(double? value) {
    template.defaultRadius.value = value;
    args.onTemplateChange();
  }
}

/// 页面
class GlobalSettingsView extends PanelView<GlobalSettingsLogic> {
  GlobalSettingsView({
    required String key,
    required GlobalSettingsArgs args,
    required GlobalSettingsDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, logic: GlobalSettingsLogic());

  @override
  Widget buildView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
        ...buildInputColors(context),
        buildUsedColors(context),
        buildSwapColors(context),
        // const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
        ...buildDefaultRadius(context),
      ],
    );
  }

  /// 使用的色彩数量
  Widget buildUsedColors(BuildContext context) {
    String _describeUsedColors(int colors) {
      if (colors == 1) return '输入主要，计算其他';
      if (colors == 2) return '输入主要和次要，计算其他';
      if (colors == 3) return '输入主要、次要和主要容器，计算其他';
      if (colors == 4) return '输入主要和次要及其容器，计算其他';
      if (colors == 5) return '输入主要和次要及其容器与辅助，计算辅助容器';
      return '输入全部，不进行计算';
    }

    int index = logic.template.usedColors.value;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      title: const Text('配色计算模式'),
      subtitle: Text(_describeUsedColors(index)),
      trailing: ElevatedButton(onPressed: () => showUsedColorsSelector(context), child: Text('$index')),
      onTap: () => showUsedColorsSelector(context),
    );
  }

  /// 选择使用的色彩数量
  void showUsedColorsSelector(BuildContext context) async {
    String _selectColors(int colors) {
      if (colors == 1) return '主要';
      if (colors == 2) return '主要和次要';
      if (colors == 3) return '主要、次要和主要容器';
      if (colors == 4) return '主要和次要及其容器';
      if (colors == 5) return '主要和次要及其容器与辅助';
      return '全部';
    }

    int? value = await ToastHelper.showRequest<int>(
      context,
      valueList: [1, 2, 3, 4, 5, 6],
      childBuilder: (value) {
        return Row(
          children: [
            CircleAvatar(child: Text('$value')),
            const Padding(padding: EdgeInsets.only(left: 4)),
            Text(_selectColors(value)),
          ],
        );
      },
    );
    if (null == value) return;
    logic.setUsedColors(value);
  }

  /// 构建可输入的色彩
  List<Widget> buildInputColors(BuildContext context) {
    // 是否交换颜色
    final bool swapLight = logic.template.swapLightColors.value;
    final bool swapDark = logic.template.swapDarkColors.value;
    // 颜色盒子大小
    const double boxWidth = 100;
    const double boxHeight = 100;

    // 颜色
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final bool isLight = theme.brightness == Brightness.light;
    final Color primary = colorScheme.primary;
    final Color primaryContainer = colorScheme.primaryContainer;
    final Color secondary = colorScheme.secondary;
    final Color secondaryContainer = colorScheme.secondaryContainer;
    final Color tertiary = colorScheme.tertiary;
    final Color tertiaryContainer = colorScheme.tertiaryContainer;

    // 输入色彩
    final FlexSchemeColor inputColor = isLight ? logic.template.toFlexSchemeColorLight() : logic.template.toFlexSchemeColorDark();

    // But error input dark mode colors also when we use toDark
    final FlexSchemeColor inputErrColor = isLight ? logic.template.toFlexSchemeColorLight() : logic.template.toFlexSchemeColorDark();
    // 如果颜色很浅，则返回 true，这意味着它需要深色文本进行对比。
    bool _isLight(final Color color) => FlexSchemeOnColors.estimateErrorBrightness(color) == Brightness.light;
    // 当主题颜色属性没有主题 onColor 时使用的颜色。
    Color _onColor(final Color color) => _isLight(color) ? Colors.black : Colors.white;

    // 错误色彩
    final Color inputErrorColor = inputErrColor.error ?? (isLight ? FlexColor.materialLightError : FlexColor.materialDarkError);
    final Color inputOnErrorColor = _onColor(inputErrorColor);
    final Color inputErrorContainerColor =
        inputErrColor.errorContainer ?? (isLight ? FlexColor.lightErrorContainer(inputErrorColor) : FlexColor.darkErrorContainer(inputErrorColor));
    final Color inputOnErrorContainerColor = _onColor(inputErrorContainerColor);

    Widget buildColorBox(List<Widget> children) {
      List<Widget> rowChildren = children.map((e) => Expanded(child: e)).toList();
      return SizedBox.expand(
        child: Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            side: const BorderSide(),
            borderRadius: BorderRadius.circular(logic.template.elevatedButtonBorderRadius.value ?? logic.template.defaultRadius.value ?? 12),
          ),
          child: Row(children: rowChildren),
        ),
      );
    }

    void setPrimary(color, isLight) => logic.setColor(color: color, isLight: isLight, light: logic.template.primaryLight, dark: logic.template.primaryDark);
    void setPrimaryContainer(color, isLight) =>
        logic.setColor(color: color, isLight: isLight, light: logic.template.primaryContainerLight, dark: logic.template.primaryContainerDark);
    void setSecondary(color, isLight) =>
        logic.setColor(color: color, isLight: isLight, light: logic.template.secondaryLight, dark: logic.template.secondaryDark);
    void setSecondaryContainer(color, isLight) =>
        logic.setColor(color: color, isLight: isLight, light: logic.template.secondaryContainerLight, dark: logic.template.secondaryContainerDark);
    void setTertiary(color, isLight) => logic.setColor(color: color, isLight: isLight, light: logic.template.tertiaryLight, dark: logic.template.tertiaryDark);
    void setTertiaryContainer(color, isLight) =>
        logic.setColor(color: color, isLight: isLight, light: logic.template.tertiaryContainerLight, dark: logic.template.tertiaryContainerDark);

    double maxWidth = Get.width;
    int columnLength = math.max(1, (maxWidth / (boxWidth * 2)).floor());
    double height = (4 / columnLength).ceil() * (boxHeight + 6);

    int usedColorsIndex = logic.template.usedColors.value;
    return [
      const ListTile(title: Text("配色输入"), visualDensity: VisualDensity.compact),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: height,
        child: GridView(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: math.min(4, columnLength),
            mainAxisExtent: boxHeight,
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
          ),
          padding: EdgeInsets.zero,
          children: <Widget>[
            buildColorBox([
              Material(
                color: primary,
                child: ColorPickerInkWell(
                  color: primary,
                  onChanged: (Color color) {
                    if (isLight) {
                      swapLight ? setSecondary(color, true) : setPrimary(color, true);
                    } else {
                      swapDark ? setSecondary(color, false) : setPrimary(color, false);
                    }
                  },
                  enabled: true,
                  recentColors: const [],
                  onRecentColorsChanged: (colors) => {},
                  wasCancelled: (bool cancelled) {
                    if (cancelled) {
                      if (isLight) {
                        swapLight ? setSecondary(primary, true) : setPrimary(primary, true);
                      } else {
                        swapDark ? setSecondary(primary, false) : setPrimary(primary, false);
                      }
                    }
                  },
                  child: ColorNameValue(
                    color: primary,
                    textColor: colorScheme.onPrimary,
                    label: '主要',
                    inputTextColor: _onColor(inputColor.primary),
                    showMaterialName: true,
                  ),
                ),
              ),
              Material(
                color: primaryContainer,
                child: ColorPickerInkWell(
                  color: primaryContainer,
                  onChanged: (Color color) {
                    if (isLight) {
                      swapLight ? setSecondaryContainer(color, true) : setPrimaryContainer(color, true);
                    } else {
                      swapDark ? setSecondaryContainer(color, false) : setPrimaryContainer(color, false);
                    }
                  },
                  enabled: usedColorsIndex > 2,
                  recentColors: const [],
                  onRecentColorsChanged: (colors) => {},
                  wasCancelled: (bool cancelled) {
                    if (cancelled) {
                      if (isLight) {
                        swapLight ? setSecondaryContainer(primaryContainer, true) : setPrimaryContainer(primaryContainer, true);
                      } else {
                        swapDark ? setSecondaryContainer(primaryContainer, false) : setPrimaryContainer(primaryContainer, false);
                      }
                    }
                  },
                  child: ColorNameValue(
                    color: primaryContainer,
                    textColor: colorScheme.onPrimaryContainer,
                    label: '主要容器${usedColorsIndex > 2 ? "" : "(计算)"}',
                    inputTextColor: _onColor(inputColor.primaryContainer),
                    showMaterialName: true,
                  ),
                ),
              ),
            ]),
            buildColorBox([
              Material(
                color: secondary,
                child: ColorPickerInkWell(
                  color: secondary,
                  onChanged: (Color color) {
                    if (isLight) {
                      swapLight ? setPrimary(color, true) : setSecondary(color, true);
                    } else {
                      swapDark ? setPrimary(color, false) : setSecondary(color, false);
                    }
                  },
                  enabled: usedColorsIndex > 1,
                  recentColors: const [],
                  onRecentColorsChanged: (colors) => {},
                  wasCancelled: (bool cancelled) {
                    if (cancelled) {
                      if (isLight) {
                        swapLight ? setPrimary(secondary, true) : setSecondary(secondary, true);
                      } else {
                        swapDark ? setPrimary(secondary, false) : setSecondary(secondary, false);
                      }
                    }
                  },
                  child: ColorNameValue(
                    color: secondary,
                    textColor: colorScheme.onSecondary,
                    label: '次要${usedColorsIndex > 1 ? "" : "(计算)"}',
                    inputTextColor: _onColor(inputColor.secondary),
                    showMaterialName: true,
                  ),
                ),
              ),
              Material(
                color: secondaryContainer,
                child: ColorPickerInkWell(
                  color: secondaryContainer,
                  onChanged: (Color color) {
                    if (isLight) {
                      swapLight ? setPrimaryContainer(color, true) : setSecondaryContainer(color, true);
                    } else {
                      swapDark ? setPrimaryContainer(color, false) : setSecondaryContainer(color, false);
                    }
                  },
                  enabled: usedColorsIndex > 3,
                  recentColors: const [],
                  onRecentColorsChanged: (colors) => {},
                  wasCancelled: (bool cancelled) {
                    if (cancelled) {
                      if (isLight) {
                        swapLight ? setPrimaryContainer(secondaryContainer, true) : setSecondaryContainer(secondaryContainer, true);
                      } else {
                        swapDark ? setPrimaryContainer(secondaryContainer, false) : setSecondaryContainer(secondaryContainer, false);
                      }
                    }
                  },
                  child: ColorNameValue(
                    color: secondaryContainer,
                    textColor: colorScheme.onSecondaryContainer,
                    label: '次要容器${usedColorsIndex > 3 ? "" : "(计算)"}',
                    inputTextColor: _onColor(inputColor.secondaryContainer),
                    showMaterialName: true,
                  ),
                ),
              ),
            ]),
            buildColorBox([
              Material(
                color: tertiary,
                child: ColorPickerInkWell(
                  color: tertiary,
                  onChanged: (Color color) {
                    if (isLight) {
                      setTertiary(color, true);
                    } else {
                      setTertiary(color, false);
                    }
                  },
                  enabled: usedColorsIndex > 4,
                  recentColors: const [],
                  onRecentColorsChanged: (colors) => {},
                  wasCancelled: (bool cancelled) {
                    if (cancelled) {
                      if (isLight) {
                        setTertiary(tertiary, true);
                      } else {
                        setTertiary(tertiary, false);
                      }
                    }
                  },
                  child: ColorNameValue(
                    color: tertiary,
                    textColor: colorScheme.onTertiary,
                    label: '辅助${usedColorsIndex > 4 ? "" : "(计算)"}',
                    inputTextColor: _onColor(inputColor.tertiary),
                    showMaterialName: true,
                  ),
                ),
              ),
              Material(
                color: tertiaryContainer,
                child: ColorPickerInkWell(
                  color: tertiaryContainer,
                  onChanged: (Color color) {
                    if (isLight) {
                      setTertiaryContainer(color, true);
                    } else {
                      setTertiaryContainer(color, false);
                    }
                  },
                  enabled: usedColorsIndex > 5,
                  recentColors: const [],
                  onRecentColorsChanged: (colors) => {},
                  wasCancelled: (bool cancelled) {
                    if (cancelled) {
                      if (isLight) {
                        setTertiaryContainer(tertiaryContainer, true);
                      } else {
                        setTertiaryContainer(tertiaryContainer, false);
                      }
                    }
                  },
                  child: ColorNameValue(
                    color: tertiaryContainer,
                    textColor: colorScheme.onTertiaryContainer,
                    label: '辅助容器${usedColorsIndex > 5 ? "" : "(计算)"}',
                    inputTextColor: _onColor(inputColor.tertiaryContainer),
                    showMaterialName: true,
                  ),
                ),
              ),
            ]),
            buildColorBox([
              Material(
                color: colorScheme.error,
                child: ColorNameValue(
                  color: colorScheme.error,
                  textColor: colorScheme.onError,
                  label: '错误',
                  inputTextColor: inputOnErrorColor,
                  showMaterialName: true,
                ),
              ),
              Material(
                color: colorScheme.errorContainer,
                child: ColorNameValue(
                  color: colorScheme.errorContainer,
                  textColor: colorScheme.onErrorContainer,
                  label: '错误容器',
                  inputTextColor: inputOnErrorContainerColor,
                  showMaterialName: true,
                ),
              ),
            ]),
          ],
        ),
      ),
    ];
  }

  /// 是否交换主次色彩
  Widget buildSwapColors(BuildContext context) {
    final bool isLight = AppLogic.instance.isLightMode;
    return SwitchListTileAdaptive(
      title: const Text('交换主要次要及其容器的配色'),
      subtitle: Text(
        '交换${isLight ? ThemeMode.light.title : ThemeMode.dark.title}下主要和次要、主要容器和次要容器的配色',
      ),
      value: logic.swapColors,
      onChanged: logic.setSwapColors,
    );
  }

  /// 默认圆角
  List<Widget> buildDefaultRadius(BuildContext context) {
    double? defaultRadius = logic.template.defaultRadius.value;
    return [
      ListTile(
        title: const Text('全局边框圆角设置'),
        subtitle: Slider.adaptive(
          min: -1,
          max: 40,
          divisions: 41,
          label: defaultRadius == null || defaultRadius < 0 ? '默认' : (defaultRadius.toStringAsFixed(0)),
          value: defaultRadius ?? -1,
          onChanged: (value) => logic.setDefaultRadius(value < 0 ? null : value),
        ),
        trailing: Padding(
          padding: const EdgeInsetsDirectional.only(end: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('圆角', style: Theme.of(context).textTheme.bodySmall),
              Text(
                defaultRadius == null || defaultRadius < 0 ? '默认值' : (defaultRadius.toStringAsFixed(0)),
                style: Theme.of(context).textTheme.caption!.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    ];
  }
}
