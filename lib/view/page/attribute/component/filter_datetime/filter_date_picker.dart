import 'package:date_format/date_format.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/route/observer.dart';
import 'package:hg_logger/ability/route/route.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/util/datetime_util.dart';
import 'package:hg_logger/view/export.dart';

/// 参数
@immutable
class FilterDatePickerArgs extends ViewArgs {
  /// 导航ID
  final int navigatorId;
  final VoidCallback? onBack;

  const FilterDatePickerArgs({
    required this.navigatorId,
    this.onBack,
  });
}

/// 数据
@immutable
class FilterDatePickerDataSource extends ViewDataSource {
  final FilterDateTime filterDateTime;

  const FilterDatePickerDataSource({required this.filterDateTime});
}

/// 逻辑
class FilterDatePickerLogic extends ViewLogic<FilterDatePickerArgs, FilterDatePickerDataSource> {
  /// 返回
  void back() {
    RouteHelper.back(id: args.navigatorId);
  }

  /// 页面返回调用
  void onBack() {
    args.onBack?.call();
  }

  void onCustomDateChanged(DateTime? date) {
    dataSource.filterDateTime.customDate = date;
    if (null == date) {
      dataSource.filterDateTime.type = null;
      dataSource.filterDateTime.time = null;
    }
    update();
  }
}

/// 页面
class FilterDatePicker extends View<FilterDatePickerLogic> with ObserverWidget {
  FilterDatePicker({
    required String key,
    required FilterDatePickerArgs args,
    required FilterDatePickerDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: FilterDatePickerLogic());

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
      title: HgNeumorphicText("日期选择"),
      body: buildDatePicker(),
    );
  }

  /// 日期选择
  Widget buildDatePicker() {
    FilterDateTime filterDateTime = logic.dataSource.filterDateTime;
    List<int> selected = [];
    if (null != filterDateTime.type) {
      selected.add(FilterDateTimeTypeEnum.list.indexOf(filterDateTime.type!));
    }
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return MultiSelect(
      key: "${logic.dataSource.filterDateTime.hashCode}_date",
      args: MultiSelectArgs(
        mode: MultiSelectMode.widget,
        rawItem: true,
        itemCount: FilterDateTimeTypeEnum.list.length,
        itemBuilder: (context, index, isSelect, action) {
          FilterDateTimeTypeEnum typeEnum = FilterDateTimeTypeEnum.list[index];
          Widget? subTitle;
          if (typeEnum == FilterDateTimeTypeEnum.custom && null != filterDateTime.customDate) {
            subTitle = Text(
              DateTimeUtil.dateFormat(filterDateTime.customDate),
              style: TextStyle(color: themeData.disabledColor, fontSize: 12),
            );
          }
          return HgNeumorphicButton(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.zero,
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(typeEnum.name), subTitle ?? Container()],
              ),
              trailing: NeumorphicCheckbox(
                value: isSelect,
                onChanged: (value) => action(index, value),
              ),
            ),
            onPressed: () {
              // 如果当前类型是自定义，并且再次点击按钮，编辑日期，否则选中，触发onSelect
              if (filterDateTime.type == typeEnum && typeEnum == FilterDateTimeTypeEnum.custom) {
                toDatePicker();
              } else {
                action(index, !isSelect);
              }
            },
          );
        },
        onSelect: (index) {
          filterDateTime.type = FilterDateTimeTypeEnum.list[index];
          filterDateTime.customDate = null;
          // 如果是自定义，编辑日期，否则返回
          if (filterDateTime.type == FilterDateTimeTypeEnum.custom) {
            toDatePicker();
          } else {
            logic.back();
          }
        },
      ),
      dataSource: MultiSelectDataSource(selected: selected),
    );
  }

  /// 打开日期选择
  void toDatePicker() {
    RouteHelper.to(page: buildDatePickerPage(), id: logic.args.navigatorId);
  }

  /// 日期选择页面
  Widget buildDatePickerPage() {
    FilterDateTime hgDateTime = logic.dataSource.filterDateTime;
    hgDateTime.customDate ??= DateTime.now();
    DateTime initialDate = hgDateTime.customDate!;
    return _DatePicker(
      key: hgDateTime.hashCode.toString(),
      args: _DatePickerArgs(
        initialDate: initialDate,
        firstDate: DateTime.fromMillisecondsSinceEpoch(0),
        lastDate: DateTime(2050, 12, 31),
        navigatorId: logic.args.navigatorId,
        onDateSelected: logic.onCustomDateChanged,
      ),
    );
  }
}

@immutable
class _DatePickerArgs extends ViewArgs {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final int navigatorId;
  final ValueChanged<DateTime?>? onDateSelected;

  const _DatePickerArgs({
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.navigatorId,
    this.onDateSelected,
  });
}

class _DatePickerLogic extends ViewLogicOnlyArgs<_DatePickerArgs> {
  /// 显示月份
  Rx<DateTime> month = DateTime.now().obs;

  /// 返回
  void back() {
    RouteHelper.back(id: args.navigatorId);
  }

  /// 打开回调
  @override
  void afterArgsUpdate() {
    month.value = args.initialDate;
  }

  /// 日期翻页
  void onPageChanged(DateTime start, DateTime end) {
    month.value = start;
    HapticFeedback.lightImpact();
  }

  /// 日期选择
  void onDateSelected(DateTime date) {
    DateTime? backDate;
    if (!date.isSameDay(args.initialDate)) {
      backDate = date;
    }
    args.onDateSelected?.call(backDate);
    back();
  }
}

class _DatePicker extends View<_DatePickerLogic> {
  _DatePicker({
    required String key,
    required _DatePickerArgs args,
  }) : super(key: key, args: args, newLogic: _DatePickerLogic());

  @override
  Widget buildView(BuildContext context) {
    return HgNeumorphicScaffold(
      leading: HgNeumorphicBackButton(onPressed: logic.back),
      title: HgNeumorphicText("自定义日期"),
      bodyPadding: const EdgeInsets.symmetric(horizontal: 12),
      body: buildCalendar(),
    );
  }

  Widget buildCalendar() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return ListView(
      clipBehavior: Clip.none,
      padding: EdgeInsets.only(top: 12, bottom: Get.height * 0.5),
      children: [
        Neumorphic(
          style: NeumorphicStyle(depth: -themeData.depth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16),
                child: Obx(() => Text(DateTimeUtil.format(logic.month.value, formats: [yyyy, "年", mm, "月"]))),
              ),
              Calendar(
                key: logic.key,
                args: CalendarArgs(
                  mode: CalendarMode.month,
                  initialDate: logic.args.initialDate,
                  firstDate: logic.args.firstDate,
                  lastDate: logic.args.lastDate,
                  selected: [logic.args.initialDate],
                  onPageChange: logic.onPageChanged,
                  onDateSelect: logic.onDateSelected,
                  style: const NeumorphicStyle(disableDepth: true),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
