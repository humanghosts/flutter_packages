import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/config.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/export.dart';

import '../card/card.dart';

@immutable
class ActionCardArgs<T extends Event> extends ViewArgs {
  /// 状态
  final PageState state;

  /// 点击事件
  final Function(T event)? onTap;

  /// 样式
  final NeumorphicStyle? style;

  const ActionCardArgs({
    this.onTap,
    required this.state,
    this.style,
  });
}

@immutable
class ActionCardDataSource<T extends Event> extends ViewDataSource {
  final T event;
  final EventConfig config;

  const ActionCardDataSource({required this.event, required this.config});
}

class ActionCardLogic<T extends Event> extends ViewLogic<ActionCardArgs<T>, ActionCardDataSource<T>> {
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

  /// 事件点击
  void onTap(T event) {
    args.onTap?.call(event);
  }
}

/// 事件卡片
class ActionCard<T extends Event> extends View<ActionCardLogic<T>> {
  ActionCard({
    required String key,
    required ActionCardArgs<T> args,
    required ActionCardDataSource<T> dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: ActionCardLogic<T>());

  @override
  Widget buildView(BuildContext context) {
    return HgNeumorphicButton(
      padding: EdgeInsets.zero,
      style: logic.args.style,
      child: buildEvent(),
      onPressed: () => logic.onTap(logic.dataSource.event),
    );
  }

  /// 构建事件
  Widget buildEvent() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
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
