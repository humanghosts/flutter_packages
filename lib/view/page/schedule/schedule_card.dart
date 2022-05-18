import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/export.dart';

import '../event/card/card.dart';

@immutable
class ScheduleCardArgs<T extends Event> extends ViewArgs {
  /// 状态
  final PageState state;

  /// 删除事件
  final Function(T event)? onRemove;

  /// 是否可以删除
  final Future<bool> Function(T event)? canRemove;

  /// 点击事件
  final Function(T event)? onTap;

  /// 样式
  final NeumorphicStyle? style;

  /// 展开事件
  final void Function(bool expanded, T event)? onExpanded;
  final bool isExpanded;
  final bool isRoot;

  const ScheduleCardArgs({
    this.onRemove,
    this.canRemove,
    this.onTap,
    required this.state,
    this.style,
    this.onExpanded,
    this.isExpanded = false,
    this.isRoot = true,
  });
}

@immutable
class ScheduleCardDataSource<T extends Event> extends ViewDataSource {
  final T event;
  final EventConfig config;

  const ScheduleCardDataSource({required this.event, required this.config});
}

class ScheduleCardLogic<T extends Event> extends ViewLogic<ScheduleCardArgs<T>, ScheduleCardDataSource<T>> {
  /// 未删除的子事件
  List<T> unRemoveChildren = [];

  /// 是否是结束状态
  Rx<bool> isEnd = false.obs;

  /// 事件是否被删除
  bool get isRemoved => dataSource.event.isDelete.value;

  @override
  void onWidgetInitState(BuildContext context, GetBuilderState<GetxController> state) {
    updateIsEnd();
  }

  @override
  void onWidgetDidUpdateWidget(BuildContext context, GetBuilder<GetxController> oldWidget, GetBuilderState<GetxController> state) {
    updateIsEnd();
  }

  void updateIsEnd() {
    isEnd.value = false;
    unRemoveChildren = dataSource.event.children.value.where((child) => child.isDelete.value == dataSource.event.isDelete.value).map((e) => e as T).toList();
    if (dataSource.event.status.isNull) return;
    Set<String> endStatusIdList = dataSource.config.endStatus.value.map((e) => e.id.value).toSet();
    String statusId = dataSource.event.status.value!.id.value;
    isEnd.value = endStatusIdList.contains(statusId);
  }

  /// 删除点击
  void onRemove(T event) {
    args.onRemove?.call(event);
  }

  /// 事件点击
  void onTap(T event) {
    args.onTap?.call(event);
  }
}

/// 事件卡片
class ScheduleCard<T extends Event> extends View<ScheduleCardLogic<T>> {
  ScheduleCard({
    required String key,
    required ScheduleCardArgs<T> args,
    required ScheduleCardDataSource<T> dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: ScheduleCardLogic<T>());

  @override
  Widget buildView(BuildContext context) {
    return HgNeumorphicButton(
      padding: EdgeInsets.zero,
      style: logic.args.style,
      child: Slidable(
        key: ValueKey(logic.dataSource.event.id.value),
        closeOnScroll: true,
        child: buildEvent(),
        enabled: logic.args.state != PageState.browse,
        endActionPane: buildEndActionPane(),
      ),
      onPressed: () => logic.onTap(logic.dataSource.event),
    );
  }

  /// 次要动作
  ActionPane? buildEndActionPane() {
    // 浏览状态不可操作
    if (logic.args.state == PageState.browse) return null;
    List<EventCardSlideAction> slideActions = [];
    EventCardSlideAction? removeAction = buildRemoveAction();
    if (null != removeAction) slideActions.add(removeAction);
    if (slideActions.isEmpty) return null;
    return ActionPane(
      extentRatio: min(slideActions.length * 0.25, 0.5),
      motion: const StretchMotion(),
      children: slideActions,
      dismissible: DismissiblePane(
        closeOnCancel: true,
        onDismissed: () => slideActions.last.onDismissed.call(),
        confirmDismiss: () async {
          HapticFeedback.lightImpact();
          if (removeAction == null) return false;
          bool result = (await logic.args.canRemove?.call(logic.dataSource.event)) ?? false;
          return result;
        },
      ),
    );
  }

  /// 删除动作
  EventCardSlideAction? buildRemoveAction() {
    // onRemove没有不显示
    if (null == logic.args.onRemove) return null;
    return EventCardSlideAction(
      isLast: true,
      isFirst: logic.dataSource.config.secondaryActions.isNull,
      color: Colors.red,
      child: HgNeumorphicIcon(
        Icons.delete_forever,
        size: 24,
        iconStyle: const NeumorphicStyle(color: Colors.white),
      ),
      onDismissed: () => logic.onRemove(logic.dataSource.event),
      onTap: () async {
        bool result = (await logic.args.canRemove?.call(logic.dataSource.event)) ?? false;
        if (result != true) return;
        logic.onRemove(logic.dataSource.event);
      },
    );
  }

  /// 构建事件
  Widget buildEvent() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    bool hasNot = logic.unRemoveChildren.isEmpty && logic.args.isRoot;
    Status? status = logic.dataSource.event.status.value;
    Priority? priority = logic.dataSource.event.priority.value;
    return DefaultTextStyle(
      maxLines: 1,
      style: TextStyle(
        color: logic.isRemoved ? themeData.disabledColor : null,
        decoration: logic.isRemoved ? TextDecoration.lineThrough : null,
        decorationColor: themeData.defaultTextColor,
        decorationThickness: 2,
        overflow: TextOverflow.ellipsis,
      ),
      child: Container(
        constraints: const BoxConstraints(minHeight: 40),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 0,
                  child: buildPriority(),
                ),
                Padding(padding: EdgeInsets.only(left: status == null && priority == null ? 0 : 6)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // 主副标题
                    children: [buildName(), buildSubTitle() ?? Container()],
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: SizedBox(
                    width: hasNot ? 0 : 40,
                    height: hasNot ? 0 : 40,
                    child: logic.unRemoveChildren.isEmpty
                        ? null
                        : HgNeumorphicExpandedButton(
                            key: logic.key,
                            args: HgNeumorphicExpandedButtonArgs(
                              padding: const EdgeInsets.all(12),
                              initExpanded: logic.args.isExpanded,
                              onExpanded: (value) => logic.args.onExpanded?.call(value, logic.dataSource.event),
                              disabled: hasNot,
                            ),
                          ),
                  ),
                ),
              ],
            ),
            buildTag() ?? Container(),
          ],
        ),
      ),
    );
  }

  /// 构建优先级
  Widget buildPriority() {
    Priority? priority = logic.dataSource.event.priority.value;
    if (null == priority) return Container();
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Neumorphic(
      style: NeumorphicStyle(depth: themeData.depth == 0 ? 0 : -1),
      child: Logo(iconValue: priority.icon.value, size: 20),
    );
  }

  /// 构建标题
  Widget buildName() {
    return Obx(() {
      T event = logic.dataSource.event;
      Color color;
      NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
      if (logic.isEnd.value || event.name.isNull || logic.isRemoved) {
        color = themeData.disabledColor;
      } else {
        color = themeData.defaultTextColor;
      }
      return Text(event.toString(), style: TextStyle(color: color, fontSize: 18));
    });
  }

  /// 构建副标题[内容+时间+标签]
  Widget? buildSubTitle() {
    Widget? content = buildContent();
    Widget? timing = buildTiming();
    Widget? subTitle;
    if (content == null && timing == null) {
      subTitle = null;
    } else if (content != null && timing != null) {
      subTitle = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [content, timing]);
    } else if (content != null) {
      subTitle = content;
    } else {
      subTitle = timing;
    }
    return subTitle;
  }

  /// 构建内容
  Widget? buildContent() {
    T event = logic.dataSource.event;
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    if (event.content.isNull) return null;
    return Text(event.content.value.toString().trim(), style: TextStyle(color: themeData.disabledColor));
  }

  /// 时间
  Widget? buildTiming() {
    T event = logic.dataSource.event;
    if (event is! DeriveEvent) return null;
    if (event.timing.isNull || event.timing.value!.isNull) return null;
    List<Widget> itemList = [];
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    Color color = logic.isEnd.value || logic.isRemoved ? themeData.disabledColor : themeData.defaultTextColor;
    itemList.add(event.timing.value!.toWidget(color: color));
    return Container(
      margin: const EdgeInsets.only(top: 4),
      child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: itemList)),
    );
  }

  /// 标签
  Widget? buildTag() {
    List<Tag> tagList = logic.dataSource.event.tagList.value;
    if (tagList.isEmpty) return null;
    List<Widget> itemList = tagList.map((tag) {
      return EventCardTagChip(dataSource: EventCardTagChipDataSource(tag: tag), args: EventCardTagChipArgs(isRemoved: logic.isRemoved));
    }).toList();
    return Container(
      margin: const EdgeInsets.only(top: 4),
      child: SingleChildScrollView(clipBehavior: Clip.none, scrollDirection: Axis.horizontal, child: Row(children: itemList)),
    );
  }
}
