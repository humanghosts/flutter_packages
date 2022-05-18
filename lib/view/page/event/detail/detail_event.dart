import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/config.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/service/services.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/export.dart';
import 'package:hg_logger/view/page/attribute/status/status_detail.dart';
import 'package:hg_logger/view/page/event/detail/children_editor/children_editor.dart';
import 'package:hg_logger/view/page/event/detail/status_history/status_history.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../attribute/attribute_detail.dart';
import 'attribute_editor/attribute_editor.dart';
import 'content_editor/content_editor.dart';
import 'parent_editor/parent_editor.dart';
import 'quick_add.dart';

/// 事件详情的参数
@immutable
class EventDetailArgs<T extends Event> extends ViewArgs {
  /// 当前级别
  final int level;

  /// 路由id
  final int navigatorId;

  /// 上级路由id
  final int parentNavigatorId;

  /// 页面状态
  final PageState state;

  /// 返回回调
  final VoidCallback? onBack;

  /// 返回回调
  final VoidCallback? onDone;

  const EventDetailArgs({
    this.level = 0,
    required this.navigatorId,
    required this.parentNavigatorId,
    required this.state,
    this.onBack,
    this.onDone,
  });
}

/// 事件详情的数据源
@immutable
class EventDetailDataSource<T extends Event> extends ViewDataSource {
  /// 事件
  final T event;

  /// 事件配置
  final EventConfig config;

  const EventDetailDataSource({required this.event, required this.config});
}

/// 逻辑
abstract class EventDetailLogic<M extends Event> extends TutorialViewLogic<EventDetailArgs<M>, EventDetailDataSource<M>> {
  /// 获取服务
  EventService<M> get service;

  /// 操作的数据
  /// 确认的时候会merge
  late M data;

  EventDetailLogic() {
    data = newModel();
  }

  /// 活跃的页签
  Rx<int> activeIndex = 0.obs;

  /// 滑动控制器
  PageController pageController = PageController(initialPage: 0);

  /// 名称输入框焦点
  FocusNode nameNode = FocusNode();

  /// 事件内容输入框焦点
  FocusNode contentNode = FocusNode();

  /// 子事件更新标识
  Rx<int> childUpdateFlag = 0.obs;

  /// 父事件更新标识
  Rx<int> parentUpdateFlag = 0.obs;

  /// 属性更新标识
  Rx<int> attributeUpdateFlag = 0.obs;

  /// 名称更新标识
  Rx<int> nameUpdateFlag = 0.obs;

  /// 状态历史
  Map<String, Status> statusHistoryMap = {};

  /// 状态历史更新标识
  Rx<int> statusHistoryMapUpdateFlag = 0.obs;

  /// 打开回调
  @override
  void afterArgsUpdate() async {
    data = dataSource.event.clone() as M;
    beforeSuperCall();
    bool isRemoved = await checkRemoved();
    if (isRemoved) return;
    await findStatusHistory();
    afterSuperCall();
  }

  /// 打开前
  void beforeSuperCall() {
    // 重置标识
    activeIndex.value = 0;
    childUpdateFlag.value = 0;
    parentUpdateFlag.value = 0;
    attributeUpdateFlag.value = 0;
    statusHistoryMapUpdateFlag.value = 0;
    pageController = PageController(initialPage: activeIndex.value);
  }

  /// 打开后
  void afterSuperCall() {}

  /// 检查是否被删除
  Future<bool> checkRemoved() async {
    bool isRemoved = await service.isRemoved(dataSource.event);
    if (!isRemoved) return false;
    await showCupertinoDialog<bool>(
      context: Get.context!,
      builder: (context) {
        return const CupertinoAlertDialog(
          title: Text("提示"),
          content: Text("该事件已被删除!"),
          actions: <Widget>[CupertinoDialogAction(child: Text("确认"), onPressed: RouteHelper.back)],
        );
      },
    );
    back();
    return true;
  }

  /// 查询状态历史状态
  Future<void> findStatusHistory() async {
    Set<String> statusIdSet = {};
    List<StatusHistoryRecord> historyRecordList = data.statusHistory.value;
    for (StatusHistoryRecord record in historyRecordList) {
      if (record.statusId.isNull) continue;
      statusIdSet.add(record.statusId.value!);
    }
    // 这里不用清空的原因是，查不到的用不到，用到的查得到
    if (statusIdSet.isEmpty) return;
    statusHistoryMap.addAll(await service.findHistoryStatus(statusIdSet));
    statusHistoryMapUpdateFlag.value++;
  }

  /// 返回按钮操作
  void back() {
    RouteHelper.back(id: args.parentNavigatorId);
    args.onBack?.call();
  }

  /// 确认按钮操作
  void done() async {
    M? parent = dataSource.event.parent.value as M?;
    if (parent != null && parent.state == States.none) return;
    debugPrint("done");
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    MainLogic.instance.showOverlay(
      key: "detail_event",
      widget: Scaffold(
        backgroundColor: themeData.baseColor.withOpacity(0.5),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: overlayContent,
        ),
      ),
    );
    dataSource.event.merge(data, mergeBase: true);
    await service.save(dataSource.event);
    RouteHelper.toast(msg: "保存成功");
    args.onDone?.call();
    MainLogic.instance.closeOverlay("detail_event");
    RouteHelper.back(id: args.parentNavigatorId);
  }

  @override
  List<Widget> get overlayContent {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return [
      SpinKitCircle(color: themeData.defaultTextColor),
      GestureDetector(
        child: const Text("保存中"),
        onTap: closeOverlay,
      ),
    ];
  }

  /// 删除提示文本
  String get canRemoveText => "确定删除吗?";

  /// 删除当前打开的事件
  void remove() async {
    bool? canRemove = await RouteHelper.showOneChoiceRequest(msg: canRemoveText);
    if (canRemove != true) return;
    bool isRemoveChildrenRes = await isRemoveChildren(data);
    dataSource.event.merge(data, mergeBase: true);
    await service.remove(dataSource.event, isRemoveChildren: isRemoveChildrenRes);
    back();
  }

  /// 是否同时删除子事件
  Future<bool> isRemoveChildren(M event) async {
    bool hasChildren = !event.children.isNull;
    bool isRemoveChildren = false;
    if (hasChildren) {
      // 询问用户是否删除子事件
      bool? res = await RouteHelper.showOneChoiceRequest(msg: "存在子事件，是否同时删除?", cancelText: "不删除");
      isRemoveChildren = res == true;
    }
    return isRemoveChildren;
  }

  /// 名称修改
  void setName(String name) {
    if (name.isEmpty) {
      data.name.value = null;
    } else {
      data.name.value = name;
    }
    nameUpdateFlag.value++;
  }

  /// 返回后操作
  /// 检查事件是否被删除
  /// 更新整个页面
  void afterBack() async {
    await checkRemoved();
    pageController = PageController(initialPage: activeIndex.value);
    update();
  }

  /// 新事件
  M newModel();

  /// 添加子事件
  void onChildAdd(M child) {
    if (args.state == PageState.browse) return;
    data.children.add(child);
    childUpdateFlag.value++;
  }

  /// 添加多个子事件
  void onChildrenAdd(List<M> children) async {
    if (args.state == PageState.browse) return;
    data.children.addAll(children);
    childUpdateFlag.value++;
  }

  /// 子事件是否可以移除
  Future<bool> canChildRemove(M child) async {
    bool? canRemove = await RouteHelper.showOneChoiceRequest(msg: "是否断开事件关联?\n注:断开后子事件不会删除", doneText: "断开");
    return canRemove == true;
  }

  /// 删除子事件
  void removeChild(M child) async {
    if (args.state == PageState.browse) return;
    data.children.remove(child);
    if (child.state == States.none) {
      childUpdateFlag.value++;
      return;
    }
    // 是否删除
    bool? isRemove = await RouteHelper.showOneChoiceRequest(msg: "是否同时删除?\n注:删除操作不可逆", cancelText: "不删除");
    if (isRemove != true) {
      childUpdateFlag.value++;
      return;
    }
    // 是否同时删除子事件
    bool isRemoveChildrenRes = await isRemoveChildren(child);
    await service.remove(child, isRemoveChildren: isRemoveChildrenRes);
    childUpdateFlag.value++;
  }

  /// 记录这个参数的原因是，animateToPage会触发onPageChange，需要忽略
  bool isAnimateToPage = false;

  /// tab bar切换，控制tab view
  void onIndexChanged(int index) async {
    if (index == activeIndex.value) return;
    activeIndex.value = index;
    if (pageController.positions.isEmpty) return;
    HapticFeedback.lightImpact();
    if (index == 0) {
      if (args.state != PageState.browse) {
        nameNode.unfocus();
        contentNode.requestFocus();
      }
    } else {
      nameNode.unfocus();
      contentNode.unfocus();
    }
    isAnimateToPage = true;
    await pageController.animateToPage(
      activeIndex.value,
      duration: AppConfig.animationConfig.middleAnimationDuration,
      curve: Curves.linear,
    );
    isAnimateToPage = false;
  }

  /// tab view切换，更新控制tab bar
  void onPageChanged(int index) {
    if (isAnimateToPage) return;
    activeIndex.value = index;
    if (index == 0) {
      if (args.state != PageState.browse) {
        nameNode.unfocus();
        contentNode.requestFocus();
      }
    } else {
      nameNode.unfocus();
      contentNode.unfocus();
    }
    HapticFeedback.lightImpact();
  }

  @override
  void buildTutorial() {
    buildAndAddTargetFocus(
      "remove_button",
      shape: ShapeLightFocus.Circle,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("删除按钮，\n点击后删除事件并返回上一界面"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "tab_bar",
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("事件属性标签页控制栏，\n点击可切换标签页"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "tab_view",
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) => HgNeumorphicText("事件属性标签页，\n左右滑动可切换标签页"),
        ),
      ],
    );
  }

  @override
  String? get tutorialSubKey => "detail";

  @override
  HomePages get homePage => HomePages.event;
}

/// 事件详情
abstract class EventDetail<M extends Event, L extends EventDetailLogic<M>> extends View<L> {
  EventDetail({
    required String key,
    required EventDetailArgs<M> args,
    required EventDetailDataSource<M> dataSource,
    required L newLogic,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: newLogic);

  @override
  Widget buildView(BuildContext context) {
    return HgNeumorphicScaffold(
      leading: HgNeumorphicBackButton(onPressed: logic.back),
      trailing: buildTrailing(),
      title: buildTitle(),
      body: buildDetail(),
      bodyPadding: const EdgeInsets.symmetric(vertical: 12),
    );
  }

  Widget? buildTrailing() {
    if (logic.args.state == PageState.browse) return null;
    Widget removeButton = HgNeumorphicButton(
      key: logic.addTutorialTargetKey(1, "remove_button"),
      getTooltip: () => "删除",
      style: const NeumorphicStyle(boxShape: NeumorphicBoxShape.circle()),
      child: HgNeumorphicIcon(Icons.delete, color: Colors.red),
      onPressed: logic.remove,
    );
    Widget doneButton = HgNeumorphicDoneButton(onPressed: logic.done);
    if (logic.dataSource.event.state == States.none) return doneButton;
    return Row(children: [removeButton, doneButton]);
  }

  Widget buildTitle() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Obx(() {
      int nameUpdateFlag = logic.nameUpdateFlag.value;
      debugPrint("名称更新次数:$nameUpdateFlag");
      String? name = logic.data.name.value;
      Color? color = name == null ? themeData.disabledColor : null;
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 120),
        child: Text(logic.data.toString(), style: TextStyle(color: color, fontWeight: FontWeight.bold)),
      );
    });
  }

  /// 构建表单
  Widget buildDetail() {
    return Column(
      children: [
        // 上半部分是名称属性等不需要大空间的内容
        Expanded(
          flex: 0,
          child: Column(children: [
            Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: buildNameField()),
            Padding(padding: const EdgeInsets.only(top: 16, left: 12, right: 12), child: buildAttrArea()),
          ]),
        ),
        const Padding(padding: EdgeInsets.only(top: 16)),
        // 下半部分是内容，子事件、父事件、原始事件等需要大空间的内容
        Expanded(
          child: Column(
            children: [
              Expanded(flex: 0, child: Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: buildTabBar())),
              Expanded(child: buildTabViews()),
            ],
          ),
        ),
      ],
    );
  }

  /// 构建名称字段
  Widget buildNameField() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    M data = logic.data;
    return Neumorphic(
      style: NeumorphicStyle(depth: -themeData.depth),
      child: TextFormField(
        key: ValueKey(data.name.value),
        initialValue: data.name.value,
        maxLines: 1,
        autofocus: true,
        readOnly: logic.args.state == PageState.browse,
        decoration: InputDecoration(hintText: logic.data.name.comment),
        onChanged: logic.setName,
        focusNode: logic.nameNode,
      ),
    );
  }

  /// 构建属性行
  Widget buildAttrArea() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return SizedBox(
      width: double.infinity,
      child: Neumorphic(
        padding: EdgeInsets.symmetric(vertical: themeData.depth),
        style: NeumorphicStyle(depth: -themeData.depth),
        child: Obx(() {
          int attributeUpdateFlag = logic.attributeUpdateFlag.value;
          debugPrint("属性更新次数:$attributeUpdateFlag");
          return EventAttributeEditor(
            key: logic.key,
            dataSource: EventAttributeEditorDataSource(event: logic.data),
            args: EventAttributeEditorArgs(
              navigatorId: logic.args.navigatorId,
              state: logic.args.state,
            ),
          );
        }),
      ),
    );
  }

  /// 构建多页签导航栏
  Widget buildTabBar() {
    return buildTabBarReactive(() {
      M event = logic.data;
      // 所有事件都有的内容
      List<ToggleElement> children = ["事件内容", "子事件"].map(buildToggleElement).toList();
      // 父事件不为空，添加父事件标签页
      if (!event.parent.isNull) children.add(buildToggleElement("父事件"));
      // 其他导航栏
      children.addAll(buildExtendsTabBar().map(buildToggleElement));
      // 状态历史
      children.add(buildToggleElement("状态历史"));
      return Obx(
        () => NeumorphicToggle(
          key: logic.addTutorialTargetKey(3, "tab_bar"),
          padding: EdgeInsets.zero,
          selectedIndex: logic.activeIndex.value,
          displayForegroundOnlyIfSelected: true,
          children: children,
          thumb: Container(),
          style: const NeumorphicToggleStyle(border: NeumorphicBorder()),
          onChanged: logic.onIndexChanged,
        ),
      );
    });
  }

  /// 构建自动更新的tab_bar,这个方法用来绑定obx变量
  Widget buildTabBarReactive(Widget Function() child) {
    return Container(child: child());
  }

  /// 其它的标签栏
  List<String> buildExtendsTabBar();

  /// 构建页签导航项
  ToggleElement buildToggleElement(String name) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return ToggleElement(
      background: Center(child: HgNeumorphicText(name, color: themeData.disabledColor)),
      foreground: Center(child: HgNeumorphicText(name, color: themeData.accentColor)),
    );
  }

  /// 构建多页签区域
  Widget buildTabViews() {
    return buildTabBarReactive(() {
      M event = logic.data;
      NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
      List<Widget> pages = [
        // 事件内容
        Neumorphic(
          style: NeumorphicStyle(depth: -themeData.depth),
          child: ContentEditor(
            key: logic.data.id.value,
            args: ContentEditorArgs(focusNode: logic.contentNode, state: logic.args.state, navigatorId: logic.args.navigatorId),
            dataSource: ContentEditorDataSource(event: logic.data),
          ),
        ),
        // 子事件
        buildChildren(),
      ];
      // 如果有父事件，显示父事件页签
      if (!event.parent.isNull) pages.add(buildParent());
      // 构建额外页签
      pages.addAll(buildExtendsTab());
      // 状态历史
      pages.add(buildStatusHistory());
      return Container(
        key: logic.addTutorialTargetKey(4, "tab_view"),
        child: PageView.builder(
          key: ValueKey(logic.key),
          clipBehavior: Clip.none,
          controller: logic.pageController,
          itemCount: pages.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12), child: pages[index]);
          },
          onPageChanged: logic.onPageChanged,
        ),
      );
    });
  }

  /// 构建反应式的tabView界面，用于绑定obx变量
  Widget buildTabViewReactive(Widget Function() child) {
    return Container(child: child());
  }

  /// 额外页签
  List<Widget> buildExtendsTab();

  /// 构建子事件字段
  Widget buildChildren() {
    return Obx(() {
      int childUpdateFlag = logic.childUpdateFlag.value;
      debugPrint("子事件更新次数:$childUpdateFlag");
      return EventDetailChildrenEditor<M>(
        key: logic.key,
        args: EventDetailChildrenEditorArgs<M>(
          state: logic.args.state,
          onTap: (child) => toChild(event: child, state: PageState.edit),
          onRemove: logic.removeChild,
          canRemove: logic.canChildRemove,
          addButtonBuilder: buildChildAddButton,
        ),
        dataSource: EventDetailChildrenEditorDataSource<M>(
          event: logic.data,
          config: logic.dataSource.config,
        ),
      );
    });
  }

  /// 子事件新增按钮
  Widget buildChildAddButton(GlobalKey? key) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return HgNeumorphicButton(
      key: key,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      child: HgNeumorphicIcon(Icons.add, color: themeData.accentColor),
      onPressed: quickAddChild,
      getTooltip: () => "新增",
    );
  }

  /// 构建父事件
  Widget buildParent() {
    return Obx(() {
      int parentUpdateFlag = logic.parentUpdateFlag.value;
      debugPrint("父事件更新次数:$parentUpdateFlag");
      return EventDetailParentEditor<M>(
        key: logic.key,
        args: EventDetailParentEditorArgs<M>(
          state: logic.args.state,
          onTap: (parent) => toDetail(event: parent, state: logic.args.state),
        ),
        dataSource: EventDetailParentEditorDataSource<M>(
          event: logic.data,
          config: logic.dataSource.config,
        ),
      );
    });
  }

  /// 构建状态更改历史
  Widget buildStatusHistory() {
    return Obx(() {
      int updateFlag = logic.statusHistoryMapUpdateFlag.value;
      debugPrint("状态历史更新次数:$updateFlag");
      return EventDetailStatusHistory(
        key: logic.key,
        args: EventDetailStatusHistoryArgs(toStatus: toStatus),
        dataSource: EventDetailStatusHistoryDataSource(
          event: logic.data,
          config: logic.dataSource.config,
          statusHistoryMap: logic.statusHistoryMap,
        ),
      );
    });
  }

  /// 新增子事件
  void quickAddChild() {
    M newChild = logic.newModel();
    // 拷贝父事件的标签
    newChild.tagList.addAll(logic.data.tagList.value);
    newChild.priority.value = logic.data.priority.value;
    newChild.status.value = logic.data.status.value;
    if (null != newChild.status.value) {
      newChild.statusHistory.add(
        StatusHistoryRecord(
          sourceType: StatusRecordSourceType.auto,
          status: newChild.status.value,
          reason: "继承父事件状态",
        ),
      );
    }

    RouteHelper.bottomSheet(
      sheet: EventQuickAdd<M>(
        key: newChild.id.value,
        args: EventQuickAddArgs(
          onFullScreen: (newChild) => toChild(event: newChild, state: PageState.add),
          navigatorId: logic.args.navigatorId,
          onDone: logic.onChildAdd,
        ),
        dataSource: EventQuickAddDataSource(event: newChild, config: logic.dataSource.config),
      ),
    );
  }

  /// 打开子事件
  void toChild({required M event, required PageState state}) {
    VoidCallback? onDone;
    if (state == PageState.add) onDone = () => logic.onChildAdd(event);
    toDetail(event: event, state: state, onDone: onDone);
  }

  /// 获取明细页面的导航id
  int getNextDetailNavigatorId(Event event) => "${logic.args.navigatorId}_${event.id.value}".hashCode;

  /// 新页面组件
  Widget buildNext({required M event, required PageState state, VoidCallback? onBack, VoidCallback? onDone});

  /// 打开新页面 点击卡片进入详情
  void toDetail({required M event, required PageState state, VoidCallback? onDone}) {
    RouteHelper.bottomPageNested(
      page: buildNext(event: event, state: state, onBack: logic.afterBack, onDone: onDone),
      parentId: logic.args.parentNavigatorId,
      nestedId: getNextDetailNavigatorId(event),
    );
  }

  /// 打开状态属性
  void toStatus(Status status) {
    int id = "event_status_history_${status.id.value}".hashCode;
    AttributeDetailArgs<Status> detailArgs = AttributeDetailArgs<Status>(
      parentNavigatorId: logic.args.parentNavigatorId,
      navigatorId: id,
      state: PageState.browse,
    );
    AttributeDetailDataSource<Status> detailDataSource = AttributeDetailDataSource<Status>(data: status);
    RouteHelper.bottomPageNested(
      parentId: logic.args.parentNavigatorId,
      nestedId: id,
      page: StatusDetail(key: status.id.value, args: detailArgs, dataSource: detailDataSource),
    );
  }
}
