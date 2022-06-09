import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hg_framework/hg_framework.dart';

import 'shared/panel.dart';

/// 外部参数
@immutable
class SurfaceBlendsArgs extends PanelArgs {
  const SurfaceBlendsArgs({required super.onTemplateChange});
}

/// 外部数据
@immutable
class SurfaceBlendsDataSource extends PanelDataSource {
  const SurfaceBlendsDataSource(super.template);
}

/// 逻辑
class SurfaceBlendsLogic extends PanelLogic<SurfaceBlendsArgs, SurfaceBlendsDataSource> {
  void setSurfaceMode(FlexSurfaceMode mode, bool isLight) {
    if (isLight) {
      template.surfaceModeLight.value.mode = mode;
    } else {
      template.surfaceModeDark.value.mode = mode;
    }
    args.onTemplateChange();
  }

  void setBlendLevel(double value, bool isLight) {
    if (isLight) {
      template.blendLevel.value = value.toInt();
    } else {
      template.blendLevelDark.value = value.toInt();
    }

    args.onTemplateChange();
  }

  void setBlendOnLevel(double value, bool isLight) {
    if (isLight) {
      template.blendOnLevel.value = value.toInt();
    } else {
      template.blendOnLevelDark.value = value.toInt();
    }
    args.onTemplateChange();
  }

  void setBlendLightOnColors(bool value, bool isLight) {
    if (isLight) {
      template.blendLightOnColors.value = value;
    } else {
      template.blendDarkOnColors.value = value;
    }
    args.onTemplateChange();
  }

  void setPureColor(bool value, bool isLight) {
    if (isLight) {
      template.lightIsWhite.value = value;
    } else {
      template.darkIsTrueBlack.value = value;
    }

    args.onTemplateChange();
  }
}

/// 页面
class SurfaceBlendsView extends PanelView<SurfaceBlendsLogic> {
  SurfaceBlendsView({
    required String key,
    required SurfaceBlendsArgs args,
    required SurfaceBlendsDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, logic: SurfaceBlendsLogic());

  @override
  Widget buildView(BuildContext context) {
    bool isLight = logic.isLight(context);
    ThemeData theme = logic.contextTheme(context);

    FlexSurfaceMode flexSurfaceMode = isLight ? logic.template.surfaceModeLight.value.mode : logic.template.surfaceModeDark.value.mode;
    int blendLevel = isLight ? logic.template.blendLevel.value : logic.template.blendLevelDark.value;
    int blendOnLevel = isLight ? logic.template.blendOnLevel.value : logic.template.blendOnLevelDark.value;
    bool blendLightOnColors = isLight ? logic.template.blendLightOnColors.value : logic.template.blendDarkOnColors.value;
    bool pureColor = isLight ? logic.template.lightIsWhite.value : logic.template.darkIsTrueBlack.value;
    return Column(
      children: <Widget>[
        ListTile(title: const Text('混合模式'), subtitle: Text(explainMode(flexSurfaceMode))),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SurfaceModeButtons(
              mode: flexSurfaceMode,
              onChanged: (mode) => logic.setSurfaceMode(mode, isLight),
            ),
          ],
        ),
        const ListTile(
          title: Text('混合程度'),
          subtitle: Text('调整前景、背景与对话框的混合程度'),
        ),
        ListTile(
          title: Slider.adaptive(
            min: 0,
            max: 40,
            divisions: 40,
            label: blendLevel.toString(),
            value: blendLevel.toDouble(),
            onChanged: (value) => logic.setBlendLevel(value, isLight),
          ),
          trailing: Padding(
            padding: const EdgeInsetsDirectional.only(end: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('程度', style: theme.textTheme.bodySmall),
                Text(
                  '$blendLevel',
                  style: theme.textTheme.caption!.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        const ListTile(
          title: Text('文本图标混合程度'),
          subtitle: Text('调整容器、前景色、背景色上的文本图标的混合程度。此设置在配色生成禁用情况下生效。'),
        ),
        ListTile(
          title: Slider.adaptive(
            min: 0,
            max: 40,
            divisions: 40,
            label: blendOnLevel.toString(),
            value: blendOnLevel.toDouble(),
            onChanged: (value) => logic.setBlendOnLevel(value, isLight),
          ),
          trailing: Padding(
            padding: const EdgeInsetsDirectional.only(end: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('程度', style: theme.textTheme.bodySmall),
                Text(
                  blendOnLevel.toString(),
                  style: theme.textTheme.caption!.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        SwitchListTileAdaptive(
          title: const Text('混合主要配色'),
          subtitle: const Text('默认只有容器色上的文本图标会使用混合. 主要的颜色使用白色或黑色。'
              '打开设置，主色、次色、辅色与错误色也会混合。此设置在配色生成禁用情况下生效。'),
          value: blendLightOnColors,
          onChanged: (value) => logic.setBlendLightOnColors(value, isLight),
        ),
        SwitchListTileAdaptive(
          title: Text(isLight ? '纯白' : '纯黑'),
          subtitle: Text(isLight ? '使用白色作为底色' : "使用黑色作为底色"),
          value: pureColor,
          onChanged: (value) => logic.setPureColor(value, isLight),
        ),
      ],
    );
  }

  String explainMode(final FlexSurfaceMode mode) {
    switch (mode) {
      case FlexSurfaceMode.level:
        return 'Flat blend\nAll surfaces at blend level 1x\n';
      case FlexSurfaceMode.highBackgroundLowScaffold:
        return 'High background, low scaffold\n'
            'Background 3/2x  Surface 1x  Scaffold 1/2x\n';
      case FlexSurfaceMode.highSurfaceLowScaffold:
        return 'High surface, low scaffold\n'
            'Surface 3/2x  Background 1x  Scaffold 1/2x\n';
      case FlexSurfaceMode.highScaffoldLowSurface:
        return 'High scaffold, low surface\n'
            'Scaffold 3x  Background 1x  Surface 1/2x\n';
      case FlexSurfaceMode.highScaffoldLevelSurface:
        return 'High scaffold, level surface\n'
            'Scaffold 3x  Background 2x  Surface 1x\n';
      case FlexSurfaceMode.levelSurfacesLowScaffold:
        return 'Level surfaces, low scaffold\n'
            'Surface & Background 1x  Scaffold 1/2x\n';
      case FlexSurfaceMode.highScaffoldLowSurfaces:
        return 'High scaffold, low surfaces (default)\n'
            'Scaffold 3x  Surface and Background 1/2x\n';
      case FlexSurfaceMode.levelSurfacesLowScaffoldVariantDialog:
        return 'Tertiary container dialog, low scaffold\n'
            'Surface & Background 1x  Scaffold 1/2x\n'
            'Dialog 1x blend of tertiary container color';
      case FlexSurfaceMode.highScaffoldLowSurfacesVariantDialog:
        return 'High scaffold, tertiary container dialog\n'
            'Scaffold 3x  Surface and Background 1/2x\n'
            'Dialog 1/2x blend of tertiary container color';
      case FlexSurfaceMode.custom:
        return '';
    }
  }
}

class SurfaceModeButtons extends StatelessWidget {
  const SurfaceModeButtons({
    Key? key,
    required this.mode,
    required this.onChanged,
    this.showAllModes = true,
  }) : super(key: key);
  final FlexSurfaceMode mode;
  final ValueChanged<FlexSurfaceMode> onChanged;
  final bool showAllModes;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final List<bool> isSelected = <bool>[
      mode == FlexSurfaceMode.level,
      mode == FlexSurfaceMode.highBackgroundLowScaffold,
      mode == FlexSurfaceMode.highSurfaceLowScaffold,
      mode == FlexSurfaceMode.highScaffoldLowSurface,
      // Only show this blend option if show all set, not enough room.
      if (showAllModes) mode == FlexSurfaceMode.highScaffoldLevelSurface,
      mode == FlexSurfaceMode.levelSurfacesLowScaffold,
      mode == FlexSurfaceMode.highScaffoldLowSurfaces,
      // Only have these blend options if show all set, not enough room.
      if (showAllModes) mode == FlexSurfaceMode.levelSurfacesLowScaffoldVariantDialog,
      if (showAllModes) mode == FlexSurfaceMode.highScaffoldLowSurfacesVariantDialog,
    ];
    final List<FlexSurfaceMode> option = <FlexSurfaceMode>[
      FlexSurfaceMode.level,
      FlexSurfaceMode.highBackgroundLowScaffold,
      FlexSurfaceMode.highSurfaceLowScaffold,
      FlexSurfaceMode.highScaffoldLowSurface,
      // Only have this blend option if show all set, not enough room.
      if (showAllModes) FlexSurfaceMode.highScaffoldLevelSurface,
      FlexSurfaceMode.levelSurfacesLowScaffold,
      FlexSurfaceMode.highScaffoldLowSurfaces,
      // Only have these blend options if show all set, not enough room.
      if (showAllModes) FlexSurfaceMode.levelSurfacesLowScaffoldVariantDialog,
      if (showAllModes) FlexSurfaceMode.highScaffoldLowSurfacesVariantDialog,
    ];
    return ToggleButtons(
      isSelected: isSelected,
      onPressed: (int newIndex) {
        onChanged(option[newIndex]);
      },
      children: <Widget>[
        const Tooltip(
          message: 'Flat\nall at same level',
          child: Icon(Icons.check_box_outline_blank),
        ),
        const Tooltip(
          message: 'High background\nlow scaffold',
          child: Icon(Icons.layers_outlined),
        ),
        const Tooltip(
          message: 'High surface\nlow scaffold',
          child: Icon(Icons.layers),
        ),
        Tooltip(
          message: 'High scaffold\nlow surface',
          child: Stack(
            alignment: Alignment.center,
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Icon(Icons.layers_outlined),
              ),
              Icon(Icons.layers),
            ],
          ),
        ),
        if (showAllModes)
          const Tooltip(
            message: 'High scaffold\nlevel surface',
            child: Icon(Icons.dynamic_feed_rounded),
          ),
        const Tooltip(
          message: 'Level surfaces\nlow scaffold',
          child: RotatedBox(quarterTurns: 2, child: Icon(Icons.horizontal_split)),
        ),
        const Tooltip(
          message: 'High scaffold\nlow surfaces (default)',
          child: Icon(Icons.horizontal_split),
        ),
        if (showAllModes)
          Tooltip(
            message: 'Tertiary container dialog\nlow scaffold',
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                const RotatedBox(quarterTurns: 2, child: Icon(Icons.horizontal_split)),
                Icon(Icons.stop, color: scheme.tertiary, size: 18),
              ],
            ),
          ),
        if (showAllModes)
          Tooltip(
            message: 'High scaffold\ntertiary container dialog',
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                const Icon(Icons.horizontal_split),
                Icon(Icons.stop, color: scheme.tertiary, size: 18),
              ],
            ),
          ),
      ],
    );
  }
}
