import 'dart:math';
import 'dart:ui';

/// 包裹后的图标非扩展属性
typedef IIcon = IIconBase;

/// 包裹后的图标属性
typedef IIconProps = IIconBase;

/// 包裹前的图标
typedef IconRender = String Function(ISvgIconProps props);

/// 包裹后的图标
typedef IIconWrapper = String Function(IIconProps props);

/// 默认配置
const IIconConfig defaultIconParkConfigs = IIconConfig(
  size: 1,
  strokeWidth: 4,
  strokeLinecap: StrokeLinecap.round,
  strokeLinejoin: StrokeLinejoin.round,
  prefix: "i",
  theme: IIconTheme.outline,
  colors: IIconColors(
    outline: OutlineColor(fill: "#333", background: "transparent"),
    filled: FilledColor(fill: "#333", background: "#FFF"),
    twoTone: TwoToneColor(fill: "#333", twoTone: "#2F88FF"),
    multiColor: MultiColor(
      outStrokeColor: "#333",
      outFillColor: '#2F88FF',
      innerStrokeColor: '#FFF',
      innerFillColor: '#43CCF8',
    ),
  ),
);

/// 图标配置
IIconConfig currentConfig = defaultIconParkConfigs;

void setIconParkConfig(IIconConfig config) => currentConfig = config;

IIconConfig getIconParkConfig() => currentConfig;

String _guid() {
  return "icon-${(((1 + Random().nextInt(1)) * 0x100000000) | 0).toRadixString(16).substring(1)}";
}

/// 属性转换函数
ISvgIconProps iconConverter({
  required String id,
  required IIconBase icon,
  required IIconConfig config,
}) {
  List<String> fill = icon.fill ?? [];
  List<String> colors = [];
  IIconTheme theme = icon.theme ?? config.theme;

  switch (theme) {
    case IIconTheme.outline:
      colors.add(fill.get(0, () => 'currentColor'));
      colors.add('none');
      colors.add(fill.get(0, () => 'currentColor'));
      colors.add('none');
      break;
    case IIconTheme.filled:
      colors.add(fill.get(0, () => 'currentColor'));
      colors.add(fill.get(0, () => 'currentColor'));
      colors.add('#FFF');
      colors.add('#FFF');
      break;
    case IIconTheme.twoTone:
      colors.add(fill.get(0, () => 'currentColor'));

      colors.add(fill.get(1, () => config.colors.twoTone.twoTone));
      colors.add(fill.get(0, () => 'currentColor'));
      colors.add(fill.get(1, () => config.colors.twoTone.twoTone));
      break;
    case IIconTheme.multiColor:
      colors.add(fill.get(0, () => 'currentColor'));
      colors.add(fill.get(1, () => config.colors.multiColor.outFillColor));
      colors.add(fill.get(2, () => config.colors.multiColor.innerStrokeColor));
      colors.add(fill.get(3, () => config.colors.multiColor.innerFillColor));
      break;
  }

  return ISvgIconProps(
    size: icon.size ?? config.size,
    strokeWidth: icon.strokeWidth ?? config.strokeWidth,
    strokeLinecap: icon.strokeLinecap ?? config.strokeLinecap,
    strokeLinejoin: icon.strokeLinejoin ?? config.strokeLinejoin,
    colors: colors,
    id: id,
  );
}

/// 图标Wrapper
IIconWrapper iconWrapper(String name, IconRender render) {
  return (IIconProps props) {
    IIconConfig config = getIconParkConfig();
    ISvgIconProps svgProps = iconConverter(id: _guid(), icon: props, config: config);
    return render(svgProps);
  };
}

extension _ListEx<E> on List<E> {
  /// 获取List中指定下标的元素
  /// 如果index超过length或者获取位置元素为null，将会调用[ifNull]方法，
  E get(int index, E Function() ifNull) {
    int length = this.length;
    if (index >= length) return ifNull();
    E? e = this[index];
    if (null == e) return ifNull();
    return e;
  }
}

extension IColor on Color {
  String get icolor => "#${value.toRadixString(16)}";
}

/// 包裹前的图标属性
class ISvgIconProps {
  /// 当前图标的唯一Id
  final String id;

  /// 图标尺寸大小，默认1
  final num size;

  /// 描边宽度
  final num strokeWidth;

  /// 描边端点类型
  final StrokeLinecap strokeLinecap;

  // 描边连接线类型
  final StrokeLinejoin strokeLinejoin;

  /// 换肤的颜色数组
  final List<String> colors;

  const ISvgIconProps({
    required this.id,
    required this.size,
    required this.strokeWidth,
    required this.strokeLinecap,
    required this.strokeLinejoin,
    required this.colors,
  });
}

/// 图标基础属性
class IIconBase {
  /// 图标尺寸大小
  final num? size;

  /// 描边宽度
  final num? strokeWidth;

  /// 描边端点类型
  final StrokeLinecap? strokeLinecap;

  /// 描边连接线类型
  final StrokeLinejoin? strokeLinejoin;

  /// 默认主题
  final IIconTheme? theme;

  /// 填充色
  final List<String>? fill;

  const IIconBase({
    this.size,
    this.strokeWidth,
    this.strokeLinecap,
    this.strokeLinejoin,
    this.theme,
    this.fill,
  });
}

/// 图标配置
class IIconConfig {
  /// 图标尺寸大小
  final num size;

  /// 描边宽度
  final num strokeWidth;

  /// 描边端点类型
  final StrokeLinecap strokeLinecap;

  /// 描边连接线类型
  final StrokeLinejoin strokeLinejoin;

  /// CSS前缀
  final String prefix;

  /// 默认主题
  final IIconTheme theme;

  /// 主题默认颜色
  final IIconColors colors;

  const IIconConfig({
    required this.size,
    required this.strokeWidth,
    required this.strokeLinecap,
    required this.strokeLinejoin,
    required this.prefix,
    required this.theme,
    required this.colors,
  });
}

/// 图标颜色
class IIconColors {
  final OutlineColor outline;
  final FilledColor filled;
  final TwoToneColor twoTone;
  final MultiColor multiColor;

  const IIconColors({required this.outline, required this.filled, required this.twoTone, required this.multiColor});
}

class OutlineColor {
  final String fill;
  final String background;

  const OutlineColor({required this.fill, required this.background});
}

class FilledColor {
  final String fill;
  final String background;

  const FilledColor({required this.fill, required this.background});
}

class TwoToneColor {
  final String fill;
  final String twoTone;

  const TwoToneColor({required this.fill, required this.twoTone});
}

class MultiColor {
  final String outStrokeColor;
  final String outFillColor;
  final String innerStrokeColor;
  final String innerFillColor;

  const MultiColor({required this.outStrokeColor, required this.outFillColor, required this.innerStrokeColor, required this.innerFillColor});
}

/// 描边端点类型
enum StrokeLinecap { butt, round, square }

extension StrokeLinecapEx on StrokeLinecap {
  String get value {
    switch (this) {
      case StrokeLinecap.butt:
        return "butt";
      case StrokeLinecap.round:
        return "round";
      case StrokeLinecap.square:
        return "square";
    }
  }
}

/// 描边连接类型
enum StrokeLinejoin { miter, round, bevel }

extension StrokeLinejoinEx on StrokeLinejoin {
  String get value {
    switch (this) {
      case StrokeLinejoin.miter:
        return "miter";
      case StrokeLinejoin.round:
        return "round";
      case StrokeLinejoin.bevel:
        return "bevel";
    }
  }
}

/// 图标主题枚举
enum IIconTheme { outline, filled, twoTone, multiColor }

extension IconThemeEx on IIconTheme {
  String get value {
    switch (this) {
      case IIconTheme.outline:
        return "outline";
      case IIconTheme.filled:
        return "filled";
      case IIconTheme.twoTone:
        return "two-tone";
      case IIconTheme.multiColor:
        return "multi-color";
    }
  }
}
