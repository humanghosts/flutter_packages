import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/export.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'attribute_editor/attribute_editor.dart';

@immutable
class EventQuickAddArgs<T extends Event> extends ViewArgs {
  /// 导航ID
  final int navigatorId;

  /// 确认回调
  final ValueChanged<T>? onDone;

  /// 全屏回调
  final ValueChanged<T>? onFullScreen;

  const EventQuickAddArgs({
    this.onDone,
    this.onFullScreen,
    required this.navigatorId,
  });
}

@immutable
class EventQuickAddDataSource<T extends Event> extends ViewDataSource {
  /// 事件
  final T event;

  /// 配置
  final EventConfig config;

  const EventQuickAddDataSource({required this.event, required this.config});
}

///　快速新增逻辑
class EventQuickAddLogic<T extends Event> extends TutorialViewLogic<EventQuickAddArgs<T>, EventQuickAddDataSource<T>> {
  /// 关闭弹框
  void back() => RouteHelper.back();

  /// 打开回调
  @override
  void afterArgsUpdate() {
    // 设置默认状态
    if (dataSource.event.status.isNull) {
      dataSource.event.status.value = dataSource.config.defaultStatus.value;
      dataSource.event.statusHistory.add(
        StatusHistoryRecord(
          sourceType: StatusRecordSourceType.auto,
          status: dataSource.config.defaultStatus.value,
          reason: "默认值设置",
        ),
      );
    }
    // 设置默认优先级
    dataSource.event.priority.value ??= dataSource.config.defaultPriority.value;
  }

  /// 确认回调
  void done() {
    // 回调
    args.onDone?.call(dataSource.event);
    // 返回
    back();
  }

  /// 全屏回调
  void onOpenFullScreen() {
    // 返回
    back();
    // 回调
    args.onFullScreen?.call(dataSource.event);
  }

  /// 设置名称
  void setName(String value) {
    if (value.isEmpty) {
      dataSource.event.name.value = null;
      return;
    }
    dataSource.event.name.value = value;
  }

  @override
  void buildTutorial() {
    buildAndAddTargetFocus(
      "fullscreen_button",
      shape: ShapeLightFocus.Circle,
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) => HgNeumorphicText("全屏按钮，\n点击后进入事件详细录入页面"),
        ),
      ],
    );
  }

  @override
  String? get tutorialSubKey => "quick_add";

  @override
  HomePages get homePage => HomePages.event;
}

/// 快速新增
class EventQuickAdd<T extends Event> extends View<EventQuickAddLogic<T>> {
  EventQuickAdd({
    required String key,
    required EventQuickAddArgs<T> args,
    required EventQuickAddDataSource<T> dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: EventQuickAddLogic<T>());

  @override
  Widget buildView(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 按钮行
        buildFuncRow(),
        // 内容行
        buildContent(),
      ],
    );
  }

  /// 构建按钮行
  Widget buildFuncRow() {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Row(
        children: [
          // 全屏按钮
          HgNeumorphicButton(
            key: logic.addTutorialTargetKey(0, "fullscreen_button"),
            child: HgNeumorphicIcon(Icons.fullscreen),
            style: const NeumorphicStyle(boxShape: NeumorphicBoxShape.circle()),
            onPressed: logic.onOpenFullScreen,
            getTooltip: () => "全屏",
          ),
          // 中间空白
          Expanded(
            child: GestureDetector(
              // 没有颜色只有高度不渲染
              child: Container(color: Colors.transparent, height: kToolbarHeight),
              onTap: logic.back,
            ),
          ),
          // 确认按钮
          HgNeumorphicDoneButton(onPressed: logic.done),
        ],
      ),
    );
  }

  /// 构建内容
  Widget buildContent() {
    return Neumorphic(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(const BorderRadius.vertical(top: Radius.circular(12))),
      ),
      child: Column(
        children: [
          // 名称
          buildEventNameField(),
          // 间距
          const Padding(padding: EdgeInsets.only(top: 8)),
          // 属性行
          buildAttributeRow(),
        ],
      ),
    );
  }

  /// 构建事件名输入框
  Widget buildEventNameField() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Neumorphic(
      style: NeumorphicStyle(depth: -themeData.depth),
      child: TextFormField(
        autofocus: true,
        maxLines: 1,
        decoration: InputDecoration(hintText: logic.dataSource.event.name.comment),
        onChanged: logic.setName,
      ),
    );
  }

  /// 构建属性行
  Widget buildAttributeRow() {
    return Container(
      alignment: Alignment.centerLeft,
      child: EventAttributeEditor(
        key: logic.key,
        dataSource: EventAttributeEditorDataSource(event: logic.dataSource.event),
        args: const EventAttributeEditorArgs(state: PageState.add),
      ),
    );
  }
}
