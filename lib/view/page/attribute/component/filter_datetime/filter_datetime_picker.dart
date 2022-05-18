import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hg_logger/ability/route/route.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/util/datetime_util.dart';
import 'package:hg_logger/view/export.dart';

import '../expansion.dart';
import 'filter_date_picker.dart';
import 'filter_time_picker.dart';

enum FilterDateTimePickerMode { date, time, datetime }

/// 参数
@immutable
class FilterDateTimePickerArgs extends ViewArgs {
  /// 名称
  final String title;

  /// 导航id
  final int navigatorId;

  /// 模式
  final FilterDateTimePickerMode mode;

  /// 时间变化回调
  final ValueChanged<FilterDateTime>? onChanged;

  const FilterDateTimePickerArgs({
    required this.title,
    required this.navigatorId,
    this.mode = FilterDateTimePickerMode.datetime,
    this.onChanged,
  });
}

/// 数据
@immutable
class FilterDateTimePickerDataSource extends ViewDataSource {
  final FilterDateTime filterDateTime;

  const FilterDateTimePickerDataSource({required this.filterDateTime});
}

/// 逻辑
class FilterDateTimePickerLogic extends ViewLogic<FilterDateTimePickerArgs, FilterDateTimePickerDataSource> {
  void onChange() {
    args.onChanged?.call(dataSource.filterDateTime);
    update();
  }

  /// 清空日期
  void clearDate() {
    dataSource.filterDateTime.customDate = null;
    dataSource.filterDateTime.type = null;
    dataSource.filterDateTime.time = null;
    update();
  }

  /// 清空时间
  void clearTime() {
    dataSource.filterDateTime.time = null;
    update();
  }
}

/// 页面
class FilterDateTimePicker extends View<FilterDateTimePickerLogic> {
  FilterDateTimePicker({
    required String key,
    required FilterDateTimePickerArgs args,
    required FilterDateTimePickerDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: FilterDateTimePickerLogic());

  @override
  Widget buildView(BuildContext context) {
    // 只有日期
    if (logic.args.mode == FilterDateTimePickerMode.date) return buildDate();
    // 只有时间
    if (logic.args.mode == FilterDateTimePickerMode.time) return buildTime();
    // 日期时间
    // 副标题 显示具体日期时间的值
    Widget? subTitle;
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    if (!logic.dataSource.filterDateTime.isNull) {
      subTitle = Text(logic.dataSource.filterDateTime.toString(), style: TextStyle(color: themeData.disabledColor));
    }
    return Container(
      padding: const EdgeInsets.all(8),
      child: Expansion(
        key: logic.hashCode.toString(),
        args: ExpansionArgs(
          title: Text(logic.args.title),
          subtitle: subTitle,
          body: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Container(child: buildDate()),
                Container(child: buildTime()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 构建日期选择
  Widget buildDate() {
    // 副标题，显示具体值
    Widget? subTitle;
    // 当前时间
    FilterDateTime filterDateTime = logic.dataSource.filterDateTime;
    // 如果有值 显示值
    if (!filterDateTime.isNull) {
      NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
      String text;
      // 如果是自定类型的 显示具体值，否则显示类型名称
      if (filterDateTime.type == FilterDateTimeTypeEnum.custom) {
        text = DateTimeUtil.dateFormat(filterDateTime.customDate);
      } else {
        text = filterDateTime.type!.name;
      }
      subTitle = Text(text, style: TextStyle(color: themeData.disabledColor));
    }
    // 尾部按钮
    List<Widget> trailingChildren = [];
    // 清空值按钮
    if (null != subTitle) trailingChildren.add(buildClearButton(logic.clearDate));
    // 前往下一个页面的按钮
    trailingChildren.add(HgNeumorphicNextButton(onPressed: toDateSelector));
    return HgNeumorphicButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [const Text("日期"), subTitle ?? Container()],
          ),
          Row(children: trailingChildren)
        ],
      ),
      onPressed: toDateSelector,
    );
  }

  /// 时间
  Widget buildTime() {
    FilterDateTime filterDateTime = logic.dataSource.filterDateTime;
    // 没有选日期 不能选时间
    if (null == filterDateTime.type) {
      filterDateTime.time = null;
      return Container();
    }
    // 非自定义、当日、次日，不能选时间
    if (![FilterDateTimeTypeEnum.day, FilterDateTimeTypeEnum.nextDay, FilterDateTimeTypeEnum.custom].contains(filterDateTime.type)) {
      filterDateTime.time = null;
      return Container();
    }
    // 自定义没有日期 不能选时间
    if (filterDateTime.type == FilterDateTimeTypeEnum.custom && filterDateTime.customDate == null) {
      filterDateTime.time = null;
      return Container();
    }
    // 副标题，具体值
    Widget? subTitle;
    if (null != filterDateTime.time) {
      NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
      subTitle = Text(DateTimeUtil.timeFormat(filterDateTime.time), style: TextStyle(color: themeData.disabledColor));
    }

    List<Widget> trailingChildren = [];
    if (null != subTitle) trailingChildren.add(buildClearButton(logic.clearTime));
    trailingChildren.add(HgNeumorphicNextButton(onPressed: toTimeSelector));
    return HgNeumorphicButton(
      margin: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [const Text("时间"), subTitle ?? Container()],
          ),
          Row(children: trailingChildren)
        ],
      ),
      onPressed: toTimeSelector,
    );
  }

  /// 构建清空按钮
  Widget buildClearButton(Function() onClear) {
    return HgNeumorphicButton(
      getTooltip: () => "清空",
      style: const NeumorphicStyle(boxShape: NeumorphicBoxShape.circle()),
      child: HgNeumorphicIcon(Icons.close, color: Colors.redAccent),
      onPressed: onClear,
    );
  }

  /// 日期选择器
  void toDateSelector() {
    RouteHelper.to(
      page: FilterDatePicker(
        key: logic.dataSource.filterDateTime.hashCode.toString(),
        args: FilterDatePickerArgs(
          navigatorId: logic.args.navigatorId,
          onBack: logic.onChange,
        ),
        dataSource: FilterDatePickerDataSource(filterDateTime: logic.dataSource.filterDateTime),
      ),
      id: logic.args.navigatorId,
    );
  }

  /// 时间选择器
  void toTimeSelector() {
    RouteHelper.to(
      page: FilterTimePicker(
        key: logic.dataSource.filterDateTime.hashCode.toString(),
        args: FilterTimePickerArgs(
          navigatorId: logic.args.navigatorId,
          onBack: logic.onChange,
        ),
        dataSource: FilterTimePickerDataSource(
          filterDateTime: logic.dataSource.filterDateTime,
        ),
      ),
      id: logic.args.navigatorId,
    );
  }
}
