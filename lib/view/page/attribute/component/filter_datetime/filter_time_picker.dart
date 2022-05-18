import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/util/datetime_util.dart';
import 'package:hg_logger/view/export.dart';
import 'package:numberpicker/numberpicker.dart';

/// 参数
@immutable
class FilterTimePickerArgs extends ViewArgs {
  /// 导航ID
  final int navigatorId;

  /// 返回调用
  final Function()? onBack;

  const FilterTimePickerArgs({required this.navigatorId, this.onBack});
}

/// 数据
@immutable
class FilterTimePickerDataSource extends ViewDataSource {
  final FilterDateTime filterDateTime;

  const FilterTimePickerDataSource({required this.filterDateTime});
}

/// 逻辑
class FilterTimePickerLogic extends ViewLogic<FilterTimePickerArgs, FilterTimePickerDataSource> {
  /// 返回
  void back() {
    RouteHelper.back(id: args.navigatorId);
  }

  /// 返回回调
  void onBack() {
    args.onBack?.call();
  }

  Rx<int> hour = 0.obs;
  Rx<int> minute = 0.obs;

  /// 打开回调
  @override
  void afterArgsUpdate() {
    FilterDateTime filterDateTime = dataSource.filterDateTime;
    DateTime now = DateTime.now();
    filterDateTime.time ??= now;
    hour.value = filterDateTime.time!.hour;
    minute.value = filterDateTime.time!.minute;
  }

  /// 设置时间
  void setHour(int value) {
    DateTime dateTime = dataSource.filterDateTime.time!;
    DateTime now = DateTime.now();
    if (dateTime.hour != value) {
      // 这里使用now却不使用dateTime的原因是：
      // time属性只记录time，不记录date，使用now的date数据还能看出来是哪天修改的
      dataSource.filterDateTime.time = DateTime(now.year, now.month, now.day, value, dateTime.minute);
      dataSource.filterDateTime.type ??= FilterDateTimeTypeEnum.day;
      hour.value = value;
    }
  }

  /// 设置分钟
  void setMinute(int value) {
    DateTime dateTime = dataSource.filterDateTime.time!;
    DateTime now = DateTime.now();
    if (dateTime.minute != value) {
      dataSource.filterDateTime.time = DateTime(now.year, now.month, now.day, dateTime.hour, value);
      dataSource.filterDateTime.type ??= FilterDateTimeTypeEnum.day;
      minute.value = value;
    }
  }
}

/// 页面
class FilterTimePicker extends View<FilterTimePickerLogic> with ObserverWidget {
  FilterTimePicker({
    required String key,
    required FilterTimePickerArgs args,
    required FilterTimePickerDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: FilterTimePickerLogic());

  @override
  void observe(ObserverRouting? routing) {
    if (routing?.isBack == true) {
      logic.onBack();
    }
  }

  @override
  Widget buildView(BuildContext context) {
    return HgNeumorphicScaffold(
      leading: HgNeumorphicBackButton(onPressed: logic.back),
      title: HgNeumorphicText("时间选择"),
      bodyPadding: const EdgeInsets.symmetric(horizontal: 12),
      body: ListView(
        padding: EdgeInsets.only(top: 12, bottom: Get.height * 0.5),
        children: [buildTimePicker()],
      ),
    );
  }

  /// 构建内容
  Widget buildTimePicker() {
    // 过滤日期时间
    FilterDateTime filterDateTime = logic.dataSource.filterDateTime;
    // 当前日期时间
    DateTime now = DateTime.now();
    // 设置时间
    filterDateTime.time ??= now;
    // 日期文本
    String dateText;
    if (filterDateTime.type == FilterDateTimeTypeEnum.custom) {
      dateText = DateTimeUtil.dateFormat(filterDateTime.customDate);
    } else {
      dateText = filterDateTime.type!.name;
    }

    return NeumorphicFormField(
      title: Obx(
        () => Text(
          "$dateText ${logic.hour.value.toString().padLeft(2, "0")}:${logic.minute.value.toString().padLeft(2, "0")}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildNumberPicker(23, logic.hour, logic.setHour),
            const Text(":", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            buildNumberPicker(59, logic.minute, logic.setMinute),
          ],
        ),
      ),
    );
  }

  Widget buildNumberPicker(int max, Rx<int> rxAttr, Function(int value) onChanged) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Neumorphic(
      child: Obx(
        () => NumberPicker(
          key: ValueKey("${logic.key}$max"),
          minValue: 0,
          maxValue: max,
          itemCount: 5,
          itemHeight: 40,
          value: rxAttr.value,
          onChanged: onChanged,
          zeroPad: true,
          haptics: true,
          selectedTextStyle: TextStyle(color: themeData.defaultTextColor, fontSize: 24, fontWeight: FontWeight.w500),
          textStyle: TextStyle(color: themeData.disabledColor, fontSize: 12, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }
}
