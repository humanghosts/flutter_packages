import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/util/datetime_util.dart';
import 'package:hg_logger/view/export.dart';
import 'package:timeline_tile/timeline_tile.dart' as timeline;
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

/// 外部参数
@immutable
class EventDetailStatusHistoryArgs<M extends Event> extends ViewArgs {
  final void Function(Status status)? toStatus;

  const EventDetailStatusHistoryArgs({this.toStatus});
}

/// 外部数据
@immutable
class EventDetailStatusHistoryDataSource<M extends Event> extends ViewDataSource {
  final M event;
  final EventConfig config;
  final Map<String, Status> statusHistoryMap;

  const EventDetailStatusHistoryDataSource({
    required this.event,
    required this.config,
    required this.statusHistoryMap,
  });
}

/// 逻辑
class EventDetailStatusHistoryLogic<M extends Event> extends TutorialViewLogic<EventDetailStatusHistoryArgs<M>, EventDetailStatusHistoryDataSource<M>> {
  @override
  void buildTutorial() {
    buildAndAddTargetFocus(
      "list",
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) => HgNeumorphicText("状态历史列表，显示当前事件的状态修改历史、"
              "\n修改历史包括时间、来源和原因，"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "status",
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) => HgNeumorphicText("历史状态，点击可查看状态详情"),
        ),
      ],
    );
  }

  @override
  String? get tutorialSubKey => "detail_status_history";

  @override
  HomePages get homePage => HomePages.event;
}

/// 页面
class EventDetailStatusHistory<M extends Event> extends View<EventDetailStatusHistoryLogic<M>> {
  EventDetailStatusHistory({
    required String key,
    required EventDetailStatusHistoryArgs args,
    required EventDetailStatusHistoryDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: EventDetailStatusHistoryLogic());

  @override
  Widget buildView(BuildContext context) {
    List<StatusHistoryRecord> statusHistory = logic.dataSource.event.statusHistory.reversed.toList();
    return ListView.builder(
      key: logic.addTutorialTargetKey(0, "list"),
      padding: EdgeInsets.only(left: 12, right: 12, bottom: Get.height * 0.25),
      clipBehavior: Clip.hardEdge,
      itemBuilder: (context, index) {
        StatusHistoryRecord record = statusHistory[index];
        bool isFirst = index == 0;
        bool isLast = index == statusHistory.length - 1;
        return buildStatusHistoryRecord(record: record, isFirst: isFirst, isLast: isLast);
      },
      itemCount: statusHistory.length,
    );
  }

  /// 构建状态历史记录
  Widget buildStatusHistoryRecord({required StatusHistoryRecord record, required bool isFirst, required bool isLast}) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    Widget endChild;
    String dateTime = DateTimeUtil.format(record.datetime.value);
    String? statusId = record.statusId.value;
    Status? status = logic.dataSource.statusHistoryMap[statusId];
    if (statusId == null || status == null) {
      endChild = Text.rich(
        TextSpan(children: [
          TextSpan(text: dateTime),
          const TextSpan(text: "状态"),
          const TextSpan(text: "删除", style: TextStyle(color: Colors.red)),
        ]),
      );
    } else {
      TextDecoration decoration;
      if (status.isDelete.value) {
        decoration = TextDecoration.combine([TextDecoration.underline, TextDecoration.lineThrough]);
      } else {
        decoration = TextDecoration.underline;
      }
      endChild = Text.rich(
        TextSpan(children: [
          const TextSpan(text: "状态由"),
          TextSpan(text: record.source.value.sourceType.toString(), style: TextStyle(color: themeData.accentColor)),
          const TextSpan(text: "修改为"),
          TextSpan(
            text: status.toString(),
            style: TextStyle(color: themeData.accentColor, decoration: decoration),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                HapticFeedback.lightImpact();
                logic.args.toStatus?.call(status);
              },
          ),
          TextSpan(text: record.source.value.sourceType == StatusRecordSourceType.auto ? "\n原因是" : ""),
          TextSpan(
              text: record.source.value.sourceType == StatusRecordSourceType.auto ? "${record.reason.value}" : "",
              style: TextStyle(color: themeData.accentColor)),
        ]),
        style: const TextStyle(overflow: TextOverflow.visible),
      );
    }

    Widget? indicator;
    if (null != status) {
      indicator = HgNeumorphicButton(
        key: isFirst ? logic.addTutorialTargetKey(1, "status") : null,
        child: Logo(iconValue: status.icon.value, size: 30),
        padding: EdgeInsets.zero,
        onPressed: () => logic.args.toStatus?.call(status),
      );
    }

    return timeline.TimelineTile(
      alignment: timeline.TimelineAlign.start,
      beforeLineStyle: timeline.LineStyle(color: themeData.disabledColor, thickness: 2),
      endChild: Neumorphic(
        margin: const EdgeInsets.only(left: 12, bottom: 12),
        child: ListTile(
          title: Text(dateTime),
          subtitle: endChild,
          isThreeLine: record.source.value.sourceType == StatusRecordSourceType.auto ? true : false,
          visualDensity: VisualDensity.compact,
        ),
      ),
      indicatorStyle: timeline.IndicatorStyle(indicator: indicator, height: 35, width: 35),
      isFirst: isFirst,
      isLast: isLast,
    );
  }
}
