import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/view/export.dart';

@immutable
class ColorPickerArgs extends ViewArgs {
  /// 默认的颜色
  final Color initColor;

  /// 颜色变化的回调
  final ValueChanged<Color>? onColorChanged;

  /// 子导航id
  final int navigatorId;

  /// 是否显示预览颜色
  final bool showPreview;

  const ColorPickerArgs({
    this.initColor = const Color.fromRGBO(0, 0, 0, 1),
    this.onColorChanged,
    required this.navigatorId,
    this.showPreview = false,
  });
}

enum _ColorType { r, g, b, o }

class ColorPickerLogic extends ViewLogicOnlyArgs<ColorPickerArgs> {
  Rx<int> r = 0.obs;
  Rx<int> g = 0.obs;
  Rx<int> b = 0.obs;
  Rx<double> o = 0.0.obs;
  Rx<int> color = 0.obs;

  TextEditingController? redCtrl;
  TextEditingController? greenCtrl;
  TextEditingController? blueCtrl;
  TextEditingController? opacityCtrl;

  @override
  void afterArgsUpdate() {
    r = args.initColor.red.obs;
    g = args.initColor.green.obs;
    b = args.initColor.blue.obs;
    o = args.initColor.opacity.obs;
    color.value = Color.fromRGBO(r.value, g.value, b.value, o.value).value;
    redCtrl ??= TextEditingController(text: r.toString());
    greenCtrl ??= TextEditingController(text: g.toString());
    blueCtrl ??= TextEditingController(text: b.toString());
    opacityCtrl ??= TextEditingController(text: o.toString());
  }

  /// 颜色变化回调
  void colorChange(_ColorType type, Rx attribute, double value) {
    if (type == _ColorType.o) {
      attribute.value = value;
    } else {
      attribute.value = value.toInt();
    }
    color.value = Color.fromRGBO(r.value, g.value, b.value, o.value).value;
    args.onColorChanged?.call(Color(color.value));
  }
}

/// 颜色选择器
class ColorPicker extends View<ColorPickerLogic> {
  ColorPicker({required String key, required ColorPickerArgs args}) : super(key: key, args: args, newLogic: ColorPickerLogic());

  @override
  Widget buildView(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          buildPreview(),
          buildColorSlider(_ColorType.r, logic.r),
          const Padding(padding: EdgeInsets.only(top: 12)),
          buildColorSlider(_ColorType.g, logic.g),
          const Padding(padding: EdgeInsets.only(top: 12)),
          buildColorSlider(_ColorType.b, logic.b),
          const Padding(padding: EdgeInsets.only(top: 12)),
          buildColorSlider(_ColorType.o, logic.o),
        ],
      ),
    );
  }

  Widget buildPreview() {
    if (!logic.args.showPreview) return Container();
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Text("颜色预览"),
          const Padding(padding: EdgeInsets.only(left: 12)),
          Neumorphic(child: Obx(() => Container(width: 40 / 0.618, height: 40, color: Color(logic.color.value)))),
        ],
      ),
    );
  }

  /// 颜色滑动选择器
  Widget buildColorSlider(_ColorType type, Rx attribute) {
    Color accent;
    // 最小值
    double min = 0;
    // 最大值
    double max = type == _ColorType.o ? 1 : 255;
    // 名称
    String title;
    // 输入控制器
    TextEditingController controller;
    // 输入格式化
    List<TextInputFormatter> inputFormatters;
    switch (type) {
      case _ColorType.r:
        accent = Colors.red;
        title = "红色";
        controller = logic.redCtrl!;
        inputFormatters = [FilteringTextInputFormatter.digitsOnly];
        break;
      case _ColorType.g:
        accent = Colors.green;
        title = "绿色";
        controller = logic.greenCtrl!;
        inputFormatters = [FilteringTextInputFormatter.digitsOnly];

        break;
      case _ColorType.b:
        accent = Colors.blue;
        title = "蓝色";
        controller = logic.blueCtrl!;
        inputFormatters = [FilteringTextInputFormatter.digitsOnly];

        break;
      case _ColorType.o:
        accent = Colors.black;
        title = "透明";
        controller = logic.opacityCtrl!;
        inputFormatters = [FilteringTextInputFormatter.allow(RegExp("[0-9.]"))];
        break;
    }
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Row(
      children: [
        // 名称
        Text(title),
        const Padding(padding: EdgeInsets.only(left: 4)),
        // 滑动器
        Expanded(
          flex: 3,
          child: Obx(
            () => NeumorphicSlider(
              value: attribute.value * 1.0,
              min: min,
              max: max,
              style: SliderStyle(depth: themeData.depth, accent: accent, variant: Colors.white),
              onChanged: (double percent) {
                String text = type != _ColorType.o ? percent.toInt().toString() : percent.toStringAsFixed(2);
                controller.text = text;
                logic.colorChange(type, attribute, double.parse(text));
              },
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.only(left: 4)),
        // 值
        Expanded(
          flex: 1,
          child: Neumorphic(
            style: NeumorphicStyle(depth: -themeData.depth),
            child: TextField(
              controller: controller,
              inputFormatters: inputFormatters,
              textInputAction: TextInputAction.done,
              onSubmitted: (String value) {
                if (value.isEmpty) value = "0";
                double percent = double.parse(value);
                if (percent > max) percent = max;
                if (percent < min) percent = min;
                controller.text = percent.toStringAsFixed(type != _ColorType.o ? 0 : 2);
                logic.colorChange(type, attribute, percent);
              },
            ),
          ),
        )
      ],
    );
  }
}
