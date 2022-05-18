import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/entity/data/notice.dart';
import 'package:hg_logger/entity/data/timing.dart';
import 'package:hg_logger/util/datetime_util.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/export.dart';

import 'notice/notice_detail.dart';
import 'notice/notice_list.dart';

@immutable
class TimingDetailCustomArgs extends ViewArgs {
  /// 页面状态
  final PageState state;

  /// 导航id
  final int? navigatorId;

  const TimingDetailCustomArgs({
    required this.state,
    this.navigatorId,
  });
}

@immutable
class TimingDetailCustomDataSource<T extends Timing> extends ViewDataSource {
  final T timing;

  const TimingDetailCustomDataSource({required this.timing});
}

class TimingDetailCustomLogic<T extends Timing> extends TutorialViewLogic<TimingDetailCustomArgs, TimingDetailCustomDataSource<T>> {
  Rx<DateTime> start = DateTime.now().obs;
  Rx<DateTime> end = DateTime.now().obs;
  Rx<bool> isStartEmpty = false.obs;
  Rx<bool> isEndEmpty = false.obs;
  Rx<int> startNoticeUpdateFlag = 0.obs;
  Rx<int> endNoticeUpdateFlag = 0.obs;

  /// 打开回调
  @override
  void afterArgsUpdate() {
    startNoticeUpdateFlag.value = 0;
    endNoticeUpdateFlag.value = 0;
    if (dataSource.timing.start.isNull) {
      isStartEmpty.value = true;
    } else {
      start.value = dataSource.timing.start.value!;
      isStartEmpty.value = false;
    }
    if (dataSource.timing.end.isNull) {
      isEndEmpty.value = true;
    } else {
      end.value = dataSource.timing.end.value!;
      isEndEmpty.value = false;
    }
  }

  /// 返回
  void back() {
    RouteHelper.back(id: args.navigatorId);
  }

  /// 设置开始时间
  void setStart(DateTime dateTime) {
    dataSource.timing.start.value = dateTime;
    start.value = dateTime;
    isStartEmpty.value = false;
    if (start.value.isAfter(end.value)) {
      setEnd(start.value);
    }
  }

  /// 设置结束时间
  void setEnd(DateTime dateTime) {
    dataSource.timing.end.value = dateTime;
    end.value = dateTime;
    isEndEmpty.value = false;
    if (end.value.isBefore(start.value)) {
      setStart(end.value);
    }
  }

  /// 清空开始时间
  void clearStart() async {
    bool? isClear = await RouteHelper.showOneChoiceRequest();
    if (isClear != true) return;
    dataSource.timing.start.clear();
    isStartEmpty.value = true;
  }

  /// 清空结束时间
  void clearEnd() async {
    bool? isClear = await RouteHelper.showOneChoiceRequest();
    if (isClear != true) return;
    dataSource.timing.end.clear();
    isEndEmpty.value = true;
  }

  /// 开始提醒修改
  void onStartNoticeChanged() {
    startNoticeUpdateFlag.value++;
  }

  /// 结束提醒修改
  void onEndNoticeChanged() {
    endNoticeUpdateFlag.value++;
  }

  /// 清空开始提醒
  void clearStartNotice() async {
    bool? isClear = await RouteHelper.showOneChoiceRequest(msg: "确定删除所有开始提醒吗?");
    if (isClear != true) return;
    dataSource.timing.startNotice.clear();
    startNoticeUpdateFlag.value++;
  }

  /// 清空结束提醒
  void clearEndNotice() async {
    bool? isClear = await RouteHelper.showOneChoiceRequest(msg: "确定删除所有结束提醒吗?");
    if (isClear != true) return;
    dataSource.timing.endNotice.clear();
    endNoticeUpdateFlag.value++;
  }

  @override
  void buildTutorial() {}

  @override
  String? get tutorialSubKey => "attribute_timing_custom";

  @override
  HomePages get homePage => HomePages.event;
}

/// 时间详情弹框
class TimingDetailCustom<M extends Timing, L extends TimingDetailCustomLogic<M>> extends View<L> {
  TimingDetailCustom({
    required String key,
    required TimingDetailCustomArgs args,
    required TimingDetailCustomDataSource<M> dataSource,
    required L newLogic,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: newLogic);

  @override
  Widget buildView(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: Get.height * 0.5),
      clipBehavior: Clip.none,
      children: [
        // 开始时间
        buildCustomDateTimeRow(
          rxValue: logic.start,
          isEmpty: logic.isStartEmpty,
          attribute: logic.dataSource.timing.start,
          onChanged: logic.setStart,
          onClear: logic.clearStart,
        ),
        const Padding(padding: EdgeInsets.only(top: 16)),
        // 开始提醒
        buildCustomNoticeRow(
          updateFlag: logic.startNoticeUpdateFlag,
          attribute: logic.dataSource.timing.startNotice,
          onClear: logic.clearStartNotice,
          onNoticeChanged: logic.onStartNoticeChanged,
        ),
        const Padding(padding: EdgeInsets.only(top: 16)),
        // 结束时间
        buildCustomDateTimeRow(
          rxValue: logic.end,
          isEmpty: logic.isEndEmpty,
          attribute: logic.dataSource.timing.end,
          onChanged: logic.setEnd,
          onClear: logic.clearEnd,
        ),
        const Padding(padding: EdgeInsets.only(top: 16)),
        // 结束提醒
        buildCustomNoticeRow(
          updateFlag: logic.endNoticeUpdateFlag,
          attribute: logic.dataSource.timing.endNotice,
          onClear: logic.clearEndNotice,
          onNoticeChanged: logic.onEndNoticeChanged,
        ),
        const Padding(padding: EdgeInsets.only(top: 16)),
        // 其它
        ...buildExtend(),
      ],
    );
  }

  /// 构建额外内容
  List<Widget> buildExtend() => [];

  /// 构建时间行
  Widget buildCustomDateTimeRow({
    required Rx<DateTime> rxValue,
    required Rx<bool> isEmpty,
    required Attribute<DateTime?> attribute,
    required Function(DateTime dateTime) onChanged,
    required VoidCallback onClear,
  }) {
    return Obx(
      () => NeumorphicFormField(
        title: Row(children: [HgNeumorphicIcon(Icons.calendar_today), Text(attribute.title)]),
        hintText: "${attribute.title}选择",
        initValue: isEmpty.value ? "" : DateTimeUtil.format(rxValue.value),
        readOnly: logic.args.state == PageState.browse,
        onTap: () => toDateTimePicker(attribute, onChanged),
        onClear: attribute.value == null ? null : onClear,
      ),
    );
  }

  /// 构建提醒行
  Widget buildCustomNoticeRow({
    required Rx<int> updateFlag,
    required ModelListAttribute<Notice> attribute,
    required VoidCallback onClear,
    required VoidCallback onNoticeChanged,
  }) {
    return NeumorphicFormField(
      title: Row(children: [HgNeumorphicIcon(Icons.notifications), Text(attribute.title)]),
      onTap: () => toNoticeList(attribute, onNoticeChanged),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          // 提示
          TextFormField(
            onTap: () => toNoticeList(attribute, onNoticeChanged),
            maxLines: 1,
            decoration: InputDecoration(hintText: "${attribute.title}选择"),
            readOnly: true,
          ),
          // 提醒列表
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            physics: const AlwaysScrollableScrollPhysics(),
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            child: Obx(() {
              int updateFlagValue = updateFlag.value;
              debugPrint("${attribute.title}提醒列表更新次数:$updateFlagValue");
              ListAttribute<Notice> noticeList = attribute;
              List<Widget> children = [];
              for (Notice notice in noticeList.value) {
                children.add(Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: HgNeumorphicChip(
                    label: Text(notice.toString()),
                    onTap: () => toNoticeDetail(notice, onNoticeChanged),
                  ),
                ));
              }
              return Row(children: children);
            }),
          ),
          // 清空按钮
          Obx(() {
            int updateFlagValue = updateFlag.value;
            debugPrint("${attribute.title}提醒列表更新次数:$updateFlagValue");
            if (logic.args.state == PageState.browse || attribute.isNull) return Container();
            return Positioned(
              right: 0,
              child: HgNeumorphicButton(
                padding: const EdgeInsets.all(4),
                margin: const EdgeInsets.only(right: 16),
                style: const NeumorphicStyle(boxShape: NeumorphicBoxShape.circle()),
                child: HgNeumorphicIcon(Icons.clear),
                onPressed: onClear,
              ),
            );
          }),
        ],
      ),
    );
  }

  /// 跳转到时间选择
  void toDateTimePicker(Attribute<DateTime?> attribute, Function(DateTime dateTime) onChanged) {
    if (null == logic.args.navigatorId) {
      RouteHelper.cupertinoBottomSheet(sheet: buildDateTimePicker(attribute, onChanged));
    } else {
      RouteHelper.to(page: buildDateTimePicker(attribute, onChanged), id: logic.args.navigatorId);
    }
  }

  /// 时间选择页面
  Widget buildDateTimePicker(Attribute<DateTime?> attribute, Function(DateTime dateTime) onChanged) {
    if (attribute.isNull) attribute.value = DateTime.now();
    return _DateTimePicker(
      key: "event_detail_custom_${attribute.name}",
      args: _DateTimePickerArgs(
        navigatorId: logic.args.navigatorId,
        onBack: onChanged,
        title: attribute.title,
      ),
      dataSource: _DateTimePickerDataSource(dateTime: attribute.value!),
    );
  }

  /// 打开提醒列表
  void toNoticeList(ModelListAttribute<Notice> attribute, VoidCallback onNoticeChanged) {
    if (logic.args.state == PageState.browse) return;
    HapticFeedback.lightImpact();
    if (null == logic.args.navigatorId) {
      RouteHelper.cupertinoBottomSheet(sheet: buildNoticeList(attribute, onNoticeChanged));
    } else {
      RouteHelper.to(page: buildNoticeList(attribute, onNoticeChanged), id: logic.args.navigatorId);
    }
  }

  ///  构建提醒列表
  Widget buildNoticeList(ModelListAttribute<Notice> attribute, VoidCallback onNoticeChanged) {
    return NoticeList(
      key: 'timing_detail_custom_notice_${M}_${attribute.name}',
      dataSource: NoticeListDataSource(noticeList: attribute.value),
      args: NoticeListArgs(
        state: logic.args.state,
        navigatorId: logic.args.navigatorId,
        onBack: (noticeList) {
          attribute.value = noticeList;
          onNoticeChanged.call();
        },
      ),
    );
  }

  /// 打开提醒详情
  void toNoticeDetail(Notice notice, VoidCallback onNoticeChanged) {
    if (logic.args.state == PageState.browse) return;
    if (null == logic.args.navigatorId) {
      RouteHelper.cupertinoBottomSheet(sheet: buildNoticeDetail(notice, onNoticeChanged));
    } else {
      RouteHelper.to(page: buildNoticeDetail(notice, onNoticeChanged), id: logic.args.navigatorId);
    }
  }

  ///  构建提醒详情
  Widget buildNoticeDetail(Notice notice, VoidCallback onNoticeChanged) {
    return NoticeDetail(
      key: notice.hashCode.toString(),
      dataSource: NoticeDetailDataSource(notice: notice),
      args: NoticeDetailArgs(onBack: onNoticeChanged, navigatorId: logic.args.navigatorId),
    );
  }
}

/// 外部参数
@immutable
class _DateTimePickerArgs extends ViewArgs {
  /// 返回回调
  final ValueChanged<DateTime>? onBack;

  /// 导航id
  final int? navigatorId;

  /// 标题
  final String title;

  const _DateTimePickerArgs({
    this.onBack,
    this.navigatorId,
    required this.title,
  });
}

/// 外部数据
@immutable
class _DateTimePickerDataSource extends ViewDataSource {
  final DateTime dateTime;

  const _DateTimePickerDataSource({required this.dateTime});
}

/// 逻辑
class _DateTimePickerLogic extends ViewLogic<_DateTimePickerArgs, _DateTimePickerDataSource> {
  DateTime dateTime = DateTime.now();

  /// 打开回调
  @override
  void afterArgsUpdate() {
    dateTime = dataSource.dateTime;
  }

  /// 返回
  void back() {
    RouteHelper.back(id: args.navigatorId);
  }

  /// 返回回调
  void onBack() {
    args.onBack?.call(dateTime);
  }
}

/// 页面
class _DateTimePicker extends View<_DateTimePickerLogic> with ObserverWidget {
  _DateTimePicker({
    required String key,
    required _DateTimePickerArgs args,
    required _DateTimePickerDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: _DateTimePickerLogic());

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
      title: Text(logic.args.title),
      body: ListView(
        padding: EdgeInsets.only(bottom: Get.height * 0.5),
        clipBehavior: Clip.none,
        children: [
          DateTimePicker(
            key: "${logic.key}_date_time_picker",
            args: DateTimePickerArgs(
              initialDate: logic.dateTime,
              firstDate: DateTime.fromMillisecondsSinceEpoch(0),
              lastDate: DateTime(2050, 12, 31),
              onDateTimeChanged: (dateTime) => logic.dateTime = dateTime,
            ),
          )
        ],
      ),
    );
  }
}
