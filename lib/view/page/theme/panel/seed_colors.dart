import 'dart:math' as math;

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_framework/hg_framework.dart';

import 'shared/color_name_value.dart';
import 'shared/color_picker_inkwell.dart';
import 'shared/copy_color_to_clipboard.dart';
import 'shared/palette_color_box.dart';
import 'shared/panel.dart';

/// 色调枚举
enum FlexTonesType {
  material,
  soft,
  vivid,
  vividSurfaces,
  highContrast,
}

/// 色调枚举扩展
extension FlexTonesExtension on FlexTonesType {
  String get title {
    switch (this) {
      case FlexTonesType.material:
        return "默认";
      case FlexTonesType.soft:
        return "柔和";
      case FlexTonesType.vivid:
        return "艳丽";
      case FlexTonesType.vividSurfaces:
        return "混合艳丽";
      case FlexTonesType.highContrast:
        return "高对比度";
    }
  }

  String get describe {
    switch (this) {
      case FlexTonesType.material:
        return "默认色调图和色度设置";
      case FlexTonesType.soft:
        return "更柔和、更像大地的色调";
      case FlexTonesType.vivid:
        return "更鲜艳的配色";
      case FlexTonesType.vividSurfaces:
        return "类似于艳丽, 但有更多彩色容器，onColors和表面色调。创建没有“任何混合级别”的 Alpha 混合效果";
      case FlexTonesType.highContrast:
        return "高对比度版本，可能对可访问性有用";
    }
  }

  String get chromaDescribe {
    String getDescribe(int primary, int? secondary, int? tertiary, int neutral, int neutralVariant) {
      return '主要配色 - Chroma from key color, but min $primary\n'
          '次要配色 - ${secondary == null ? 'Chroma from key color' : 'Chroma set to $secondary'}\n'
          '辅助配色 - ${tertiary == null ? 'Chroma from key color' : 'Chroma set to $tertiary'}\n'
          'Neutral - Chroma set to $neutral\n'
          'Neutral variant - Chroma set to $neutralVariant\n';
    }

    switch (this) {
      case FlexTonesType.material:
        return getDescribe(48, 16, 24, 4, 8);
      case FlexTonesType.soft:
        return getDescribe(30, 14, 20, 4, 8);
      case FlexTonesType.vivid:
        return getDescribe(50, null, null, 4, 8);
      case FlexTonesType.vividSurfaces:
        return getDescribe(50, null, null, 8, 16);
      case FlexTonesType.highContrast:
        return getDescribe(65, 55, 55, 4, 8);
    }
  }

  FlexTones getFlexTone(Brightness brightness) {
    switch (this) {
      case FlexTonesType.material:
        return FlexTones.material(brightness);
      case FlexTonesType.soft:
        return FlexTones.soft(brightness);
      case FlexTonesType.vivid:
        return FlexTones.vivid(brightness);
      case FlexTonesType.vividSurfaces:
        return FlexTones.vividSurfaces(brightness);
      case FlexTonesType.highContrast:
        return FlexTones.highContrast(brightness);
    }
  }
}

/// 外部参数
@immutable
class SeededColorsArgs extends PanelArgs {
  const SeededColorsArgs({
    required super.onTemplateChange,
  });
}

/// 外部数据
@immutable
class SeededColorsDataSource extends PanelDataSource {
  const SeededColorsDataSource(super.template);
}

/// 逻辑
class SeededColorsLogic extends PanelLogic<SeededColorsArgs, SeededColorsDataSource> {
  /// 设置色调
  void setUsedFlexToneSetUp(int value) {
    template.usedFlexToneSetup.value = value;
    args.onTemplateChange();
  }

  /// 设置使用的种子颜色
  void setSeedColors(int index) {
    if (index == 0) {
      template.useKeyColors.value = !template.useKeyColors.value;
    }
    if (index == 1 && template.useKeyColors.value) {
      template.useSecondary.value = !template.useSecondary.value;
    }
    if (index == 2 && template.useKeyColors.value) {
      template.useTertiary.value = !template.useTertiary.value;
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

  /// 设置颜色
  void setBool({
    required bool? value,
    required bool isLight,
    required Attribute<bool> light,
    required Attribute<bool> dark,
  }) {
    if (null == value) return;
    if (isLight) {
      light.value = value;
    } else {
      dark.value = value;
    }
    args.onTemplateChange();
  }
}

class SeededColorsView extends PanelView<SeededColorsLogic> {
  SeededColorsView({
    required String key,
    required SeededColorsArgs args,
    required SeededColorsDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, logic: SeededColorsLogic());

  @override
  Widget buildView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ...buildUsedColors(),
        ...buildColors(context),
        ...buildFlexTones(context),
      ],
    );
  }

  /// 构建种子配色
  List<Widget> buildUsedColors() {
    String explainUsedColors() {
      if (!logic.template.useKeyColors.value) {
        return '配色方案生成关闭，使用全局设置中的配色';
      }
      if (!logic.template.useSecondary.value && !logic.template.useTertiary.value) {
        return '使用输入配色中的主要配色生成配色方案';
      }
      if (logic.template.useSecondary.value && !logic.template.useTertiary.value) {
        return '使用输入配色中的主要配色和次要配色生成配色方案';
      }
      if (!logic.template.useSecondary.value && logic.template.useTertiary.value) {
        return '使用输入配色中的主要配色和辅助配色生成配色方案';
      }
      return '使用输入配色中的所有配色生成配色方案';
    }

    List<bool> isSelected = [logic.template.useKeyColors.value];
    List<Widget> children = [
      const Tooltip(
        message: '使用输入的主要配色\n作为种子生成配色方案',
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('主要配色'),
        ),
      )
    ];
    if (logic.template.useKeyColors.value) {
      isSelected.add(logic.template.useSecondary.value && logic.template.useKeyColors.value);
      isSelected.add(logic.template.useTertiary.value && logic.template.useKeyColors.value);
      children.add(const Tooltip(
        message: '使用输入的次要配色\n作为种子生成配色方案',
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('次要配色'),
        ),
      ));
      children.add(const Tooltip(
        message: '使用输入的辅助配色\n作为种子生成配色方案',
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('辅助配色'),
        ),
      ));
    }

    return [
      ListTile(
        title: const Text('用于生成配色方案的种子配色'),
        subtitle: Text(explainUsedColors()),
        trailing: AnimatedSize(
          duration: AppLogic.appConfig.animationConfig.fastAnimationDuration,
          child: ToggleButtons(
            isSelected: isSelected,
            onPressed: logic.setSeedColors,
            children: children,
          ),
        ),
      ),
    ];
  }

  /// 构建生成的颜色
  List<Widget> buildColors(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Brightness brightness = theme.brightness;
    final bool isLight = brightness == Brightness.light;

    final bool swapLight = logic.template.swapLightColors.value;
    final bool swapDark = logic.template.swapDarkColors.value;

    const double boxWidth = 100;
    const double boxHeight = 120;

    int flexToneIndex = logic.template.useKeyColors.value ? logic.template.usedFlexToneSetup.value : -1;
    FlexTonesType tonesType = FlexTonesType.material;
    if (flexToneIndex > 0) {
      tonesType = FlexTonesType.values[flexToneIndex];
    }
    final FlexTones tones = tonesType.getFlexTone(brightness);

    final ColorScheme colorScheme = theme.colorScheme;
    final Color primary = colorScheme.primary;
    final Color primaryContainer = colorScheme.primaryContainer;
    final Color secondary = colorScheme.secondary;
    final Color secondaryContainer = colorScheme.secondaryContainer;
    final Color tertiary = colorScheme.tertiary;
    final Color tertiaryContainer = colorScheme.tertiaryContainer;

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
    void setPrimaryLight(color) => setPrimary(color, true);
    void setPrimaryDark(color) => setPrimary(color, false);
    void setPrimaryContainer(color, isLight) =>
        logic.setColor(color: color, isLight: isLight, light: logic.template.primaryContainerLight, dark: logic.template.primaryContainerDark);
    void setPrimaryContainerLight(color) => setPrimaryContainer(color, true);
    void setPrimaryContainerDark(color) => setPrimaryContainer(color, false);
    void setSecondary(color, isLight) =>
        logic.setColor(color: color, isLight: isLight, light: logic.template.secondaryLight, dark: logic.template.secondaryDark);
    void setSecondaryLight(color) => setSecondary(color, true);
    void setSecondaryDark(color) => setSecondary(color, false);
    void setSecondaryContainer(color, isLight) =>
        logic.setColor(color: color, isLight: isLight, light: logic.template.secondaryContainerLight, dark: logic.template.secondaryContainerDark);
    void setSecondaryContainerLight(color) => setSecondaryContainer(color, true);
    void setSecondaryContainerDark(color) => setSecondaryContainer(color, false);
    void setTertiary(color, isLight) => logic.setColor(color: color, isLight: isLight, light: logic.template.tertiaryLight, dark: logic.template.tertiaryDark);
    void setTertiaryLight(color) => setTertiary(color, true);
    void setTertiaryDark(color) => setTertiary(color, false);
    void setTertiaryContainer(color, isLight) =>
        logic.setColor(color: color, isLight: isLight, light: logic.template.tertiaryContainerLight, dark: logic.template.tertiaryContainerDark);
    void setTertiaryContainerLight(color) => setTertiaryContainer(color, true);
    void setTertiaryContainerDark(color) => setTertiaryContainer(color, false);

    void setKeepPrimary(bool? value, [bool isLight = true]) =>
        logic.setBool(value: value, isLight: isLight, light: logic.template.keepPrimary, dark: logic.template.keepDarkPrimary);
    void setKeepSecondary(bool? value, [bool isLight = true]) =>
        logic.setBool(value: value, isLight: isLight, light: logic.template.keepSecondary, dark: logic.template.keepDarkSecondary);
    void setKeepTertiary(bool? value, [bool isLight = true]) =>
        logic.setBool(value: value, isLight: isLight, light: logic.template.keepTertiary, dark: logic.template.keepDarkTertiary);
    void setKeepPrimaryContainer(bool? value, [bool isLight = true]) =>
        logic.setBool(value: value, isLight: isLight, light: logic.template.keepPrimaryContainer, dark: logic.template.keepDarkPrimaryContainer);
    void setKeepSecondaryContainer(bool? value, [bool isLight = true]) =>
        logic.setBool(value: value, isLight: isLight, light: logic.template.keepSecondaryContainer, dark: logic.template.keepDarkSecondaryContainer);
    void setKeepTertiaryContainer(bool? value, [bool isLight = true]) =>
        logic.setBool(value: value, isLight: isLight, light: logic.template.keepTertiaryContainer, dark: logic.template.keepDarkTertiaryContainer);
    void setKeepDarkPrimary(bool? value) => setKeepPrimary(value, false);
    void setKeepDarkSecondary(bool? value) => setKeepSecondary(value, false);
    void setKeepDarkTertiary(bool? value) => setKeepTertiary(value, false);
    void setKeepDarkPrimaryContainer(bool? value) => setKeepPrimaryContainer(value, false);
    void setKeepDarkSecondaryContainer(bool? value) => setKeepSecondaryContainer(value, false);
    void setKeepDarkTertiaryContainer(bool? value) => setKeepTertiaryContainer(value, false);

    // Return true if the color is light, meaning it needs dark text for contrast.
    bool _isLight(final Color color) => ThemeData.estimateBrightnessForColor(color) == Brightness.light;

    // On color used when a theme color property does not have a theme onColor.
    Color _onColor(final Color color) => _isLight(color) ? Colors.black : Colors.white;

    bool _locked(bool isLight, bool keepLight, bool keepDark) => logic.template.useKeyColors.value && ((isLight && keepLight) || (!isLight && keepDark));

    double maxWidth = Get.width;
    int columnLength = math.max(1, (maxWidth / (boxWidth * 4)).floor());
    double height = (7 / columnLength).ceil() * (boxHeight + 6);

    bool keepPrimary = logic.template.keepPrimary.value;
    bool keepSecondary = logic.template.keepSecondary.value;
    bool keepTertiary = logic.template.keepTertiary.value;
    bool keepPrimaryContainer = logic.template.keepPrimaryContainer.value;
    bool keepSecondaryContainer = logic.template.keepSecondaryContainer.value;
    bool keepTertiaryContainer = logic.template.keepTertiaryContainer.value;
    bool keepDarkPrimary = logic.template.keepDarkPrimary.value;
    bool keepDarkSecondary = logic.template.keepDarkSecondary.value;
    bool keepDarkTertiary = logic.template.keepDarkTertiary.value;
    bool keepDarkPrimaryContainer = logic.template.keepDarkPrimaryContainer.value;
    bool keepDarkSecondaryContainer = logic.template.keepDarkSecondaryContainer.value;
    bool keepDarkTertiaryContainer = logic.template.keepDarkTertiaryContainer.value;
    theme.colorScheme.onPrimary;
    bool useKeyColors = logic.template.useKeyColors.value;
    return [
      const ListTile(title: Text('有效的配色方案')),
      Container(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 4),
        height: height,
        child: GridView(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: math.min(7, columnLength),
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
                      swapLight ? setSecondaryLight(color) : setPrimaryLight(color);
                    } else {
                      swapDark ? setSecondaryDark(color) : setPrimaryDark(color);
                    }
                  },
                  recentColors: const [],
                  onRecentColorsChanged: (colors) => {},
                  wasCancelled: (bool cancelled) {
                    if (cancelled) {
                      if (isLight) {
                        swapLight ? setSecondaryLight(primary) : setPrimaryLight(primary);
                      } else {
                        swapDark ? setSecondaryDark(primary) : setPrimaryDark(primary);
                      }
                    }
                  },
                  enabled: true,
                  child: ColorNameValue(
                    color: primary,
                    textColor: colorScheme.onPrimary,
                    label: '主要',
                    tone: tones.primaryTone,
                    showTone: _locked(isLight, !keepPrimary, !keepDarkPrimary),
                    isLocked: _locked(isLight, keepPrimary, keepDarkPrimary),
                    onLocked: useKeyColors
                        ? isLight
                            ? setKeepPrimary
                            : setKeepDarkPrimary
                        : null,
                  ),
                ),
              ),
              Material(
                color: colorScheme.onPrimary,
                child: ColorNameValue(
                  color: colorScheme.onPrimary,
                  textColor: colorScheme.primary,
                  label: '主要文本图标',
                  showTone: _locked(isLight, !keepPrimary, !keepDarkPrimary),
                  tone: tones.onPrimaryTone,
                ),
              ),
              Material(
                color: primaryContainer,
                child: ColorPickerInkWell(
                  color: primaryContainer,
                  onChanged: (Color color) {
                    if (isLight) {
                      swapLight ? setSecondaryContainerLight(color) : setPrimaryContainerLight(color);
                    } else {
                      swapDark ? setSecondaryContainerDark(color) : setPrimaryContainerDark(color);
                    }
                  },
                  recentColors: const [],
                  onRecentColorsChanged: (colors) => {},
                  wasCancelled: (bool cancelled) {
                    if (cancelled) {
                      if (isLight) {
                        swapLight ? setSecondaryContainerLight(primaryContainer) : setPrimaryContainerLight(primaryContainer);
                      } else {
                        swapDark ? setSecondaryContainerDark(primaryContainer) : setPrimaryContainerDark(primaryContainer);
                      }
                    }
                  },
                  enabled: true,
                  child: ColorNameValue(
                    color: primaryContainer,
                    textColor: colorScheme.onPrimaryContainer,
                    label: '主要容器',
                    tone: tones.primaryContainerTone,
                    showTone: _locked(isLight, !keepPrimaryContainer, !keepDarkPrimaryContainer),
                    isLocked: _locked(isLight, keepPrimaryContainer, keepDarkPrimaryContainer),
                    onLocked: useKeyColors
                        ? isLight
                            ? setKeepPrimaryContainer
                            : setKeepDarkPrimaryContainer
                        : null,
                  ),
                ),
              ),
              Material(
                color: colorScheme.onPrimaryContainer,
                child: ColorNameValue(
                  color: colorScheme.onPrimaryContainer,
                  textColor: colorScheme.primaryContainer,
                  label: '主要容器文本图标',
                  tone: tones.onPrimaryContainerTone,
                  showTone: _locked(isLight, !keepPrimaryContainer, !keepDarkPrimaryContainer),
                ),
              ),
            ]),
            buildColorBox([
              MouseRegion(
                child: Material(
                  color: secondary,
                  child: ColorPickerInkWell(
                    color: secondary,
                    onChanged: (Color color) {
                      if (isLight) {
                        swapLight ? setPrimaryLight(color) : setSecondaryLight(color);
                      } else {
                        swapDark ? setPrimaryDark(color) : setSecondaryDark(color);
                      }
                    },
                    recentColors: const [],
                    onRecentColorsChanged: (colors) => {},
                    wasCancelled: (bool cancelled) {
                      if (cancelled) {
                        if (isLight) {
                          swapLight ? setPrimaryLight(secondary) : setSecondaryLight(secondary);
                        } else {
                          swapDark ? setPrimaryDark(secondary) : setSecondaryDark(secondary);
                        }
                      }
                    },
                    enabled: true,
                    child: ColorNameValue(
                      color: secondary,
                      textColor: colorScheme.onSecondary,
                      label: '次要',
                      tone: tones.secondaryTone,
                      showTone: _locked(isLight, !keepSecondary, !keepDarkSecondary),
                      isLocked: _locked(isLight, keepSecondary, keepDarkSecondary),
                      onLocked: useKeyColors
                          ? isLight
                              ? setKeepSecondary
                              : setKeepDarkSecondary
                          : null,
                    ),
                  ),
                ),
              ),
              MouseRegion(
                child: Material(
                  color: colorScheme.onSecondary,
                  child: ColorNameValue(
                    color: colorScheme.onSecondary,
                    textColor: colorScheme.secondary,
                    label: '次要文本图标',
                    tone: tones.onSecondaryTone,
                    showTone: _locked(isLight, !keepSecondary, !keepDarkSecondary),
                  ),
                ),
              ),
              MouseRegion(
                child: Material(
                  color: secondaryContainer,
                  child: ColorPickerInkWell(
                    color: secondaryContainer,
                    onChanged: (Color color) {
                      if (isLight) {
                        swapLight ? setPrimaryContainerLight(color) : setSecondaryContainerLight(color);
                      } else {
                        swapDark ? setPrimaryContainerDark(color) : setSecondaryContainerDark(color);
                      }
                    },
                    recentColors: const [],
                    onRecentColorsChanged: (colors) => {},
                    wasCancelled: (bool cancelled) {
                      if (cancelled) {
                        if (isLight) {
                          swapLight ? setPrimaryContainerLight(secondaryContainer) : setSecondaryContainerLight(secondaryContainer);
                        } else {
                          swapDark ? setPrimaryContainerDark(secondaryContainer) : setSecondaryContainerDark(secondaryContainer);
                        }
                      }
                    },
                    enabled: true,
                    child: ColorNameValue(
                      color: secondaryContainer,
                      textColor: colorScheme.onSecondaryContainer,
                      label: '次要容器',
                      tone: tones.secondaryContainerTone,
                      showTone: _locked(isLight, !keepSecondaryContainer, !keepDarkSecondaryContainer),
                      isLocked: _locked(isLight, keepSecondaryContainer, keepDarkSecondaryContainer),
                      onLocked: useKeyColors
                          ? isLight
                              ? setKeepSecondaryContainer
                              : setKeepDarkSecondaryContainer
                          : null,
                    ),
                  ),
                ),
              ),
              MouseRegion(
                child: Material(
                  color: colorScheme.onSecondaryContainer,
                  child: ColorNameValue(
                    color: colorScheme.onSecondaryContainer,
                    textColor: secondaryContainer,
                    label: '次要容器文本图标',
                    tone: tones.onSecondaryContainerTone,
                    showTone: _locked(isLight, !keepSecondaryContainer, !keepDarkSecondaryContainer),
                  ),
                ),
              ),
            ]),
            buildColorBox([
              MouseRegion(
                child: Material(
                  color: tertiary,
                  child: ColorPickerInkWell(
                    color: tertiary,
                    onChanged: (Color color) {
                      if (isLight) {
                        setTertiaryLight(color);
                      } else {
                        setTertiaryDark(color);
                      }
                    },
                    recentColors: const [],
                    onRecentColorsChanged: (colors) => {},
                    wasCancelled: (bool cancelled) {
                      if (cancelled) {
                        if (isLight) {
                          setTertiaryLight(tertiary);
                        } else {
                          setTertiaryDark(tertiary);
                        }
                      }
                    },
                    enabled: true,
                    child: ColorNameValue(
                      color: tertiary,
                      textColor: colorScheme.onTertiary,
                      label: '辅助',
                      tone: tones.tertiaryTone,
                      showTone: _locked(isLight, !keepTertiary, !keepDarkTertiary),
                      isLocked: _locked(isLight, keepTertiary, keepDarkTertiary),
                      onLocked: useKeyColors
                          ? isLight
                              ? setKeepTertiary
                              : setKeepDarkTertiary
                          : null,
                    ),
                  ),
                ),
              ),
              MouseRegion(
                child: Material(
                  color: colorScheme.onTertiary,
                  child: ColorNameValue(
                    color: colorScheme.onTertiary,
                    textColor: tertiary,
                    label: '辅助文本图标',
                    tone: tones.onTertiaryTone,
                    showTone: _locked(isLight, !keepTertiary, !keepDarkTertiary),
                  ),
                ),
              ),
              MouseRegion(
                child: Material(
                  color: tertiaryContainer,
                  child: ColorPickerInkWell(
                    color: tertiaryContainer,
                    onChanged: (Color color) {
                      if (isLight) {
                        setTertiaryContainerLight(color);
                      } else {
                        setTertiaryContainerDark(color);
                      }
                    },
                    recentColors: const [],
                    onRecentColorsChanged: (colors) => {},
                    wasCancelled: (bool cancelled) {
                      if (cancelled) {
                        if (isLight) {
                          setTertiaryContainerLight(tertiaryContainer);
                        } else {
                          setTertiaryContainerDark(tertiaryContainer);
                        }
                      }
                    },
                    enabled: true,
                    child: ColorNameValue(
                      color: tertiaryContainer,
                      textColor: colorScheme.onTertiaryContainer,
                      label: '辅助容器',
                      tone: tones.tertiaryContainerTone,
                      showTone: _locked(isLight, !keepTertiaryContainer, !keepDarkTertiaryContainer),
                      isLocked: _locked(isLight, keepTertiaryContainer, keepDarkTertiaryContainer),
                      onLocked: useKeyColors
                          ? isLight
                              ? setKeepTertiaryContainer
                              : setKeepDarkTertiaryContainer
                          : null,
                    ),
                  ),
                ),
              ),
              MouseRegion(
                child: Material(
                  color: colorScheme.onTertiaryContainer,
                  child: ColorNameValue(
                    color: colorScheme.onTertiaryContainer,
                    textColor: tertiaryContainer,
                    label: '辅助容器文本图标',
                    tone: tones.onTertiaryContainerTone,
                    showTone: _locked(isLight, !keepTertiaryContainer, !keepDarkTertiaryContainer),
                  ),
                ),
              ),
            ]),
            buildColorBox([
              MouseRegion(
                child: Material(
                  color: colorScheme.error,
                  child: ColorNameValue(
                    color: colorScheme.error,
                    textColor: colorScheme.onError,
                    label: '错误',
                    tone: tones.errorTone,
                    showTone: useKeyColors,
                  ),
                ),
              ),
              MouseRegion(
                child: Material(
                  color: colorScheme.onError,
                  child: ColorNameValue(
                    color: colorScheme.onError,
                    textColor: colorScheme.error,
                    label: '错误文本图标',
                    tone: tones.onErrorTone,
                    showTone: useKeyColors,
                  ),
                ),
              ),
              MouseRegion(
                child: Material(
                  color: colorScheme.errorContainer,
                  child: ColorNameValue(
                    color: colorScheme.errorContainer,
                    textColor: colorScheme.onErrorContainer,
                    label: '错误容器',
                    tone: tones.errorContainerTone,
                    showTone: useKeyColors,
                  ),
                ),
              ),
              MouseRegion(
                child: Material(
                  color: colorScheme.onErrorContainer,
                  child: ColorNameValue(
                    color: colorScheme.onErrorContainer,
                    textColor: colorScheme.errorContainer,
                    label: '错误容器文本图标',
                    tone: tones.onErrorContainerTone,
                    showTone: useKeyColors,
                  ),
                ),
              ),
            ]),
            buildColorBox([
              MouseRegion(
                child: Material(
                  color: colorScheme.background,
                  child: ColorNameValue(
                    color: colorScheme.background,
                    textColor: colorScheme.onBackground,
                    label: '背景配色',
                    tone: tones.backgroundTone,
                    showTone: useKeyColors,
                  ),
                ),
              ),
              MouseRegion(
                child: Material(
                  color: colorScheme.onBackground,
                  child: ColorNameValue(
                    color: colorScheme.onBackground,
                    textColor: colorScheme.background,
                    label: '在背景配色之上',
                    tone: tones.onBackgroundTone,
                    showTone: useKeyColors,
                  ),
                ),
              ),
              MouseRegion(
                child: Material(
                  color: colorScheme.outline,
                  child: ColorNameValue(
                    color: colorScheme.outline,
                    textColor: _onColor(colorScheme.outline),
                    label: '轮廓配色',
                    tone: tones.outlineTone,
                    showTone: useKeyColors,
                  ),
                ),
              ),
              MouseRegion(
                child: Material(
                  color: colorScheme.shadow,
                  child: ColorNameValue(
                    color: colorScheme.shadow,
                    textColor: _onColor(colorScheme.shadow),
                    label: '阴影配色',
                    tone: tones.shadowTone,
                    showTone: useKeyColors,
                  ),
                ),
              ),
            ]),
            buildColorBox([
              MouseRegion(
                child: Material(
                  color: colorScheme.surface,
                  child: ColorNameValue(
                    color: colorScheme.surface,
                    textColor: colorScheme.onSurface,
                    label: '表面配色',
                    tone: tones.surfaceTone,
                    showTone: useKeyColors,
                  ),
                ),
              ),
              MouseRegion(
                child: Material(
                  color: colorScheme.onSurface,
                  child: ColorNameValue(
                    color: colorScheme.onSurface,
                    textColor: colorScheme.surface,
                    label: '在表面配色之上',
                    tone: tones.onSurfaceTone,
                    showTone: useKeyColors,
                  ),
                ),
              ),
              MouseRegion(
                child: Material(
                  color: colorScheme.surfaceVariant,
                  child: ColorNameValue(
                    color: colorScheme.surfaceVariant,
                    textColor: colorScheme.onSurfaceVariant,
                    label: '表面变体配色',
                    tone: tones.surfaceVariantTone,
                    showTone: useKeyColors,
                  ),
                ),
              ),
              MouseRegion(
                child: Material(
                  color: colorScheme.onSurfaceVariant,
                  child: ColorNameValue(
                    color: colorScheme.onSurfaceVariant,
                    textColor: colorScheme.surfaceVariant,
                    label: '在表面变体之上',
                    tone: tones.onSurfaceVariantTone,
                    showTone: useKeyColors,
                  ),
                ),
              ),
            ]),
            buildColorBox([
              MouseRegion(
                child: Material(
                  color: colorScheme.inverseSurface,
                  child: ColorNameValue(
                    color: colorScheme.inverseSurface,
                    textColor: colorScheme.onInverseSurface,
                    label: '表面反色',
                    tone: tones.inverseSurfaceTone,
                    showTone: useKeyColors,
                  ),
                ),
              ),
              MouseRegion(
                child: Material(
                  color: colorScheme.onInverseSurface,
                  child: ColorNameValue(
                    color: colorScheme.onInverseSurface,
                    textColor: colorScheme.inverseSurface,
                    label: '在表面反色之上',
                    tone: tones.onInverseSurfaceTone,
                    showTone: useKeyColors,
                  ),
                ),
              ),
              MouseRegion(
                child: Material(
                  color: colorScheme.inversePrimary,
                  child: ColorNameValue(
                    color: colorScheme.inversePrimary,
                    textColor: primary,
                    label: '主要配色反色',
                    tone: tones.inversePrimaryTone,
                    showTone: useKeyColors,
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    ];
  }

  /// 构建色调选项
  List<Widget> buildFlexTones(BuildContext context) {
    int flexToneIndex = logic.template.useKeyColors.value ? logic.template.usedFlexToneSetup.value : -1;
    FlexTonesType? tonesTypeNullable;
    if (flexToneIndex >= 0) {
      tonesTypeNullable = FlexTonesType.values[flexToneIndex];
    }

    final Brightness brightness = Theme.of(context).brightness;
    final bool isLight = brightness == Brightness.light;
    // Effective FlexSchemeColor depends on usedColors and swap.
    final FlexSchemeColor colors = FlexSchemeColor.effective(
      logic.template.toFlexSchemeColor(brightness: brightness),
      logic.template.usedColors.value,
      swapColors: (isLight && logic.template.swapLightColors.value) || (!isLight && logic.template.swapDarkColors.value),
      brightness: brightness,
    );
    // Get the FlexTones setup
    FlexTonesType tonesType = FlexTonesType.material;
    if (flexToneIndex > 0) {
      tonesType = FlexTonesType.values[flexToneIndex];
    }
    final FlexTones tones = tonesType.getFlexTone(brightness);

    // Compute all the core Tonal Palettes.
    final FlexCorePalette palettes = FlexCorePalette.fromSeeds(
      primary: colors.primary.value,
      // Pass in null if set to not secondary or tertiary colors seed keys.
      secondary: logic.template.useSecondary.value ? colors.secondary.value : null,
      tertiary: logic.template.useTertiary.value ? colors.tertiary.value : null,
      // Tone config details we get from active FlexTones.
      primaryChroma: logic.template.useKeyColors.value ? tones.primaryChroma : 0,
      primaryMinChroma: logic.template.useKeyColors.value ? tones.primaryMinChroma : 0,
      secondaryChroma: logic.template.useKeyColors.value ? tones.secondaryChroma : 0,
      secondaryMinChroma: logic.template.useKeyColors.value ? tones.secondaryMinChroma : 0,
      tertiaryChroma: logic.template.useKeyColors.value ? tones.tertiaryChroma : 0,
      tertiaryMinChroma: logic.template.useKeyColors.value ? tones.tertiaryMinChroma : 0,
      neutralChroma: logic.template.useKeyColors.value ? tones.neutralChroma : 0,
      neutralVariantChroma: logic.template.useKeyColors.value ? tones.neutralVariantChroma : 0,
    );

    TextStyle style = TextStyle(color: tonesTypeNullable == null ? Theme.of(context).disabledColor : null);

    return [
      // 色调面板
      const ListTile(title: Text('生成的色调板')),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            TonalPaletteColors(tonalPalette: palettes.primary.asList),
            TonalPaletteColors(tonalPalette: palettes.secondary.asList),
            TonalPaletteColors(tonalPalette: palettes.tertiary.asList),
            TonalPaletteColors(tonalPalette: palettes.error.asList),
            TonalPaletteColors(tonalPalette: palettes.neutral.asList),
            TonalPaletteColors(tonalPalette: palettes.neutralVariant.asList),
          ],
        ),
      ),
      const ListTile(
        subtitle: Text(
          '使用 FlexTones，您可以配置从'
          '生成的调色板中生成的调色板中每种颜色在 ColorScheme 中使用的色调。 '
          '设置使用的 CAM16 色度值的限制 为用作主要、次要和三次 TonalPalettes 的键的三种颜色.',
        ),
      ),
      // 色调设置
      ListTile(
        title: Text('弹性色调设置: ${tonesTypeNullable == null ? "禁用" : tonesTypeNullable.title}', style: style),
        subtitle: Text(tonesTypeNullable == null ? "禁用" : tonesTypeNullable.describe, style: style),
        trailing: ToggleButtons(
          isSelected: [
            logic.template.usedFlexToneSetup.value == 0,
            logic.template.usedFlexToneSetup.value == 1,
            logic.template.usedFlexToneSetup.value == 2,
            logic.template.usedFlexToneSetup.value == 3,
            logic.template.usedFlexToneSetup.value == 4,
          ],
          onPressed: logic.template.useKeyColors.value ? logic.setUsedFlexToneSetUp : null,
          children: FlexTonesType.values
              .map(
                (e) => Tooltip(
                  message: e.title,
                  child: Center(child: Text('${e.index}')),
                ),
              )
              .toList(),
        ),
      ),
      // 色调的色度说明
      ListTile(
        title: Text('${tonesTypeNullable == null ? "禁用" : tonesTypeNullable.title}色调设置拥有的 CAM16 色度:', style: style),
        subtitle: Text(tonesTypeNullable == null ? "禁用" : tonesTypeNullable.chromaDescribe, style: style),
      ),
    ];
  }
}

/// TonalPaletteColors widget.
class TonalPaletteColors extends StatelessWidget {
  /// Default const constructor.
  const TonalPaletteColors({
    Key? key,
    required this.tonalPalette,
    this.selectedColor,
    this.height = 34,
  }) : super(key: key);

  /// The tonal palette to draw.
  final List<int> tonalPalette;

  /// The selected color.
  final Color? selectedColor;

  /// Height of the color pick item.
  final double height;

  /// Commonly-used tone values.
  static const List<int> commonTones = <int>[
    0,
    10,
    20,
    30,
    40,
    50,
    60,
    70,
    80,
    90,
    95,
    99,
    100,
  ];

  static String _toneLabel(int index) {
    return TonalPaletteColors.commonTones[index].toString();
  }

  static Color _onColor(Color color) {
    return ThemeData.estimateBrightnessForColor(color) == Brightness.light ? Colors.black : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        for (int i = 0; i < tonalPalette.length; i++)
          Expanded(
            child: PaletteColorBox(
              color: Color(tonalPalette[i]),
              height: height,
              onTap: () {
                copyColorToClipboard(context, Color(tonalPalette[i]));
              },
              child: Center(
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Text(
                        _toneLabel(i),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: _onColor(Color(tonalPalette[i])),
                        ),
                      ),
                    ),
                    if (selectedColor == Color(tonalPalette[i]))
                      Center(
                        child: Icon(
                          Icons.circle,
                          size: 34,
                          color: _onColor(
                            Color(tonalPalette[i]),
                          ).withAlpha(0x33),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
