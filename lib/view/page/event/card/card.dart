import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_logger/config.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/export.dart';

@immutable
class EventCardArgs<T extends Event> extends ViewArgs {
  /// 状态
  final PageState state;

  /// 删除事件
  final Function(T event)? onRemove;

  /// 是否可以删除
  final Future<bool> Function(T event)? canRemove;

  /// 点击事件
  final Function(T event)? onTap;

  /// 状态点击事件
  final Function(T event, Status status)? onAction;

  /// 样式
  final NeumorphicStyle? style;

  /// 是否是介绍页使用
  final bool isIntro;

  final bool isRoot;

  const EventCardArgs({
    this.onRemove,
    this.canRemove,
    this.onTap,
    this.onAction,
    required this.state,
    this.style,
    this.isIntro = false,
    this.isRoot = true,
  });
}

@immutable
class EventCardDataSource<T extends Event> extends ViewDataSource {
  final T event;
  final EventConfig config;

  const EventCardDataSource({required this.event, required this.config});
}

class EventCardLogic<T extends Event> extends ViewLogic<EventCardArgs<T>, EventCardDataSource<T>> {
  /// 未删除的子事件
  List<T> unRemoveChildren = [];

  /// 是否展开子事件
  Rx<bool> isExpand = false.obs;

  /// 是否是结束状态
  Rx<bool> isEnd = false.obs;

  /// 事件是否被删除
  bool get isRemoved => dataSource.event.isDelete.value;

  AnimationController? childrenAnimaController;

  @override
  void onWidgetInitState(BuildContext context, GetBuilderState<GetxController> state) {
    updateIsEnd();
  }

  @override
  void onWidgetDidUpdateWidget(BuildContext context, GetBuilder<GetxController> oldWidget, GetBuilderState<GetxController> state) {
    updateIsEnd();
  }

  void updateIsEnd() {
    isExpand.value = false;
    isEnd.value = false;
    unRemoveChildren = dataSource.event.children.value.where((child) => child.isDelete.value == dataSource.event.isDelete.value).map((e) => e as T).toList();
    if (dataSource.event.status.isNull) return;
    Set<String> endStatusIdList = dataSource.config.endStatus.value.map((e) => e.id.value).toSet();
    String statusId = dataSource.event.status.value!.id.value;
    isEnd.value = endStatusIdList.contains(statusId);
  }

  /// 展开/收缩
  void onExpand(bool value) async {
    if (!value) {
      childrenAnimaController?.reverse();
      await Future.delayed(AppConfig.animationConfig.middleAnimationDuration);
    }
    isExpand.value = value;
  }

  /// action点击
  void onAction(T event, Status status) {
    args.onAction?.call(event, status);
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
class EventCard<T extends Event> extends View<EventCardLogic<T>> {
  EventCard({
    required String key,
    required EventCardArgs<T> args,
    required EventCardDataSource<T> dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: EventCardLogic<T>());

  @override
  Widget buildView(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: HgNeumorphicButton(
                padding: EdgeInsets.zero,
                // margin: EdgeInsets.only(right: hasNot ? 0 : 12),
                style: logic.args.style,
                child: Slidable(
                  key: ValueKey(logic.dataSource.event.id.value),
                  closeOnScroll: true,
                  child: buildEvent(),
                  enabled: logic.args.state != PageState.browse,
                  startActionPane: buildActionPane(),
                  endActionPane: buildEndActionPane(),
                ),
                onPressed: () => logic.onTap(logic.dataSource.event),
              ),
            ),
          ],
        ),
        buildChildren(),
      ],
    );
  }

  /// 首要动作
  ActionPane? buildActionPane() {
    // 浏览状态不可操作
    if (logic.args.state == PageState.browse) return null;
    if (logic.args.onAction == null) return null;
    // 可操作状态
    List<Status> actions = logic.dataSource.config.actions.value;
    // 没有可操作状态 返回
    if (actions.isEmpty) return null;
    List<EventCardSlideAction> slideActions = [];
    for (int i = 0; i < actions.length; i++) {
      slideActions.add(buildStatusAction(actions[i], i == 0, i == actions.length - 1));
    }
    return ActionPane(
      extentRatio: min(actions.length * 0.25, 0.5),
      motion: const StretchMotion(),
      children: slideActions,
      dismissible: DismissiblePane(
        closeOnCancel: true,
        onDismissed: () {},
        confirmDismiss: () async {
          HapticFeedback.lightImpact();
          slideActions.first.onTap.call();
          return false;
        },
      ),
    );
  }

  /// 次要动作
  ActionPane? buildEndActionPane() {
    // 浏览状态不可操作
    if (logic.args.state == PageState.browse) return null;
    List<Status> actions = logic.dataSource.config.secondaryActions.value;
    List<EventCardSlideAction> slideActions = [];
    if (logic.args.onAction != null) {
      for (int i = 0; i < actions.length; i++) {
        slideActions.add(buildStatusAction(actions[i], i == 0, null == logic.args.onRemove && i == actions.length - 1));
      }
    }
    EventCardSlideAction? removeAction = buildRemoveAction();
    if (null != removeAction) slideActions.add(removeAction);
    if (slideActions.isEmpty) return null;
    return ActionPane(
      extentRatio: min(slideActions.length * 0.25, 0.5),
      motion: const StretchMotion(),
      children: slideActions,
      dismissible: DismissiblePane(
        closeOnCancel: true,
        onDismissed: () {
          slideActions.last.onDismissed.call();
        },
        confirmDismiss: () async {
          HapticFeedback.lightImpact();
          if (removeAction != null) {
            bool result = (await logic.args.canRemove?.call(logic.dataSource.event)) ?? false;
            return result;
          } else {
            return false;
          }
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

  /// 状态动作
  EventCardSlideAction buildStatusAction(Status status, bool isFirst, bool isLast) {
    IconValue icon = status.icon.value;
    return EventCardSlideAction(
      isFirst: isFirst,
      isLast: isLast,
      color: Color(icon.backgroundColor),
      child: HgNeumorphicIcon.fromIconValue(
        icon,
        size: 24,
        style: NeumorphicStyle(
          color: Color(icon.iconColor),
          disableDepth: true,
          border: NeumorphicBorder(color: Color(icon.backgroundColor)),
        ),
      ),
      onDismissed: () => logic.onAction(logic.dataSource.event, status),
      onTap: () => logic.onAction(logic.dataSource.event, status),
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
                  child: Column(
                    children: [
                      buildStatus(),
                      Padding(padding: EdgeInsets.only(top: status == null ? 0 : 6)),
                      buildPriority(),
                    ],
                  ),
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
                              initExpanded: logic.isExpand.value,
                              onExpanded: logic.onExpand,
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

  /// 构建状态
  Widget buildStatus() {
    Status? status = logic.dataSource.event.status.value;
    if (null == status) return Container();
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Neumorphic(
      style: NeumorphicStyle(depth: themeData.depth == 0 ? 0 : -1),
      child: Logo(iconValue: status.icon.value, size: 20),
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
    List<Widget> itemList = [];
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    Color color;
    if (logic.isEnd.value || logic.isRemoved) {
      color = themeData.disabledColor;
    } else {
      color = themeData.defaultTextColor;
    }
    T event = logic.dataSource.event;
    // 派生，显示timing
    if (event is DeriveEvent) {
      if (event.timing.isNull || event.timing.value!.isNull) return null;
      itemList.add(event.timing.value!.toWidget(color: color));
    }
    // 非派生 显示timing list
    else if (event is OriginEvent) {
      ListAttribute<RepeatableTiming> timingList = event.timingList;
      if (timingList.isNull) return null;
      for (int i = 0; i < timingList.value.length; i++) {
        RepeatableTiming timing = timingList.value[i];
        itemList.add(timing.toWidget(color: color));
        if (i != timingList.value.length - 1) {
          itemList.add(const Text(" , "));
        }
      }
    } else {
      return null;
    }
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

  /// 构建子事件列表
  Widget buildChildren() {
    return Obx(() {
      if (!logic.isExpand.value) return Container();
      if (logic.unRemoveChildren.isEmpty) return Container();
      List<Widget> childrenWidget = [];
      for (T childEvent in logic.unRemoveChildren) {
        childrenWidget.add(Container(
          margin: const EdgeInsets.only(bottom: 8),
          child: EventCard(
            key: logic.key + childEvent.id.value,
            dataSource: EventCardDataSource(event: childEvent, config: logic.dataSource.config),
            args: EventCardArgs(
              state: logic.args.state,
              onTap: logic.args.onTap,
              onRemove: logic.onRemove,
              canRemove: logic.args.canRemove,
              onAction: logic.onAction,
              isRoot: false,
            ),
          ),
        ));
      }
      return FadeInLeft(
        controller: (controller) => logic.childrenAnimaController = controller,
        child: Container(margin: const EdgeInsets.only(left: 12, top: 12), child: Column(children: childrenWidget)),
      );
    });
  }
}

class EventCardSlideAction extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final VoidCallback onDismissed;
  final bool isFirst;
  final bool isLast;
  final Color? color;

  const EventCardSlideAction({
    Key? key,
    required this.child,
    required this.onTap,
    required this.onDismissed,
    this.isFirst = false,
    this.isLast = false,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    double left = isFirst ? 12 : 0;
    double right = isLast ? 12 : 0;
    return Expanded(
      child: SizedBox.expand(
        child: HgNeumorphicButton(
          style: NeumorphicStyle(
            color: color,
            depth: -themeData.depth,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.horizontal(
              left: Radius.circular(left),
              right: Radius.circular(right),
            )),
          ),
          child: Center(child: child),
          onPressed: onTap,
        ),
      ),
    );
  }
}

@immutable
class EventCardTagChipArgs extends ViewArgs {
  final bool isRemoved;

  const EventCardTagChipArgs({this.isRemoved = false});
}

@immutable
class EventCardTagChipDataSource extends ViewDataSource {
  final Tag tag;

  const EventCardTagChipDataSource({required this.tag});
}

class EventCardTagChipLogic extends ViewLogic<EventCardTagChipArgs, EventCardTagChipDataSource> {}

class EventCardTagChip extends View<EventCardTagChipLogic> {
  EventCardTagChip({String? key, required EventCardTagChipArgs args, required EventCardTagChipDataSource dataSource})
      : super(key: key ?? dataSource.tag.id.value, args: args, dataSource: dataSource, newLogic: EventCardTagChipLogic());

  @override
  Widget buildView(BuildContext context) {
    IconValue icon = logic.dataSource.tag.icon.value;
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Container(
      margin: const EdgeInsets.only(right: 4),
      child: SizedBox.square(
        dimension: 20,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 标签底标
            HgNeumorphicIcon(
              FontAwesomeIcons.tag,
              size: 20,
              iconStyle: NeumorphicStyle(
                color: Color(icon.backgroundColor),
                border: themeData.depth != 0 ? const NeumorphicBorder.none() : NeumorphicBorder(color: themeData.borderColor, width: themeData.borderWidth),
              ),
            ),
            // 标签图标
            HgNeumorphicIcon.fromIconValue(
              icon,
              size: 10,
              style: NeumorphicStyle(color: Color(icon.iconColor)),
            ),
            logic.args.isRemoved ? HgNeumorphicIcon(Icons.remove, size: 20) : Container(),
          ],
        ),
      ),
    );
  }
}
