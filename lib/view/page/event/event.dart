import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/service/services.dart';
import 'package:hg_logger/view/export.dart';
import 'package:hg_logger/view/page/event/list/origin_list.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'search/origin_search.dart';

/// 主页处理器
class EventHomeLogic extends HomePageLogic {

  int activeIndex = 0;

  /// 页面控制器
  final PageController pageController = PageController(initialPage: 0);

  @override
  void buildTutorial() {
    addTutorialTargetKey(-1, "page_view");
    buildAndAddTargetFocus(
      "page_view",
      targetPosition: TargetPosition(const Size.square(4), Offset(Get.width / 2, Get.height / 2)),
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("事件主页，\n左右滑动可切换列表与搜索页面"),
        ),
      ],
    );
  }

  @override
  HomePages get homePage => HomePages.event;
}

/// 事件主页
class EventHomePage extends HomePage<EventHomeLogic> {


  EventHomePage({required String key, required HomePageArgs args}) : super(key: key, args: args, newLogic: EventHomeLogic());

  /// 构建事件主页
  @override
  Widget buildView(BuildContext context) {
    return Container(
      key: getWidgetKey(PageView, "Container"),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      clipBehavior: Clip.none,
      child: PageView(
        key: getWidgetKey(PageView),
        clipBehavior: Clip.none,
        controller: logic.pageController,
        children: [
          OriginEventList(key: logic.key, args: OriginEventListArgs(navigatorId: logic.args.navigatorId)),
          OriginEventSearch(key: logic.key, args: OriginEventSearchArgs(navigatorId: logic.args.navigatorId)),
        ],
        padEnds: false,
        physics: const ClampingScrollPhysics(),
        onPageChanged: (index) {
          logic.activeIndex = index;
          OriginEventListLogic listLogic = Get.find(tag: logic.key);
          OriginEventSearchLogic searchLogic = Get.find(tag: logic.key);
          if (index == 0) {
            searchLogic.unFocus();
            listLogic.focus();
          }
          if (index == 1) {
            searchLogic.focus();
            listLogic.unFocus();
          }
        },
      ),
    );
  }
}

abstract class OriginEventLogic<A extends ViewArgs, D extends ViewDataSource> extends TutorialViewLogic<A, D> {
  /// 事件服务
  final DeriveEventService deriveService = DeriveEventService.instance;
  final EventConfigService configService = EventConfigService.instance;
  final OriginEventService originService = OriginEventService.instance;

  /// 事件列表
  List<OriginEvent> eventList = [];

  /// 事件配置
  EventConfig config = EventConfig();

  /// 切换页面之后调用
  void unFocus() {}

  /// 切换页面之后调用
  void focus() {}

  /// 打开调用
  /// 查询事件配置
  @override
  void onReady() async {
    await findConfig();
  }

  /// 查询事件配置
  Future<void> findConfig() async {
    config = await configService.find();
  }


  /// 是否可以删除事件
  Future<bool> canRemove(OriginEvent event) async {
    String text;
    if (event.timingList.isNull || event.timingList.value.length == 1 && event.timingList.value.first.repeatRule.isNull) {
      text = "确定删除吗?";
    } else {
      text = "该事件的同时会删除所有日程，确定删除吗?";
    }
    bool? canRemove = await RouteHelper.showOneChoiceRequest(msg: text);
    return canRemove == true;
  }

  /// 删除事件 重新分组
  Future<void> remove(OriginEvent event) async {
    // 判断是否可以删除
    bool result = await beforeRemove(event);
    if (!result) return;
    bool isRemoveChildrenRes = await isRemoveChildren(event);
    // 删除
    await originService.remove(event, isRemoveChildren: isRemoveChildrenRes);
    // 提示
    RouteHelper.toast(msg: "${event.toString()}删除成功");
    // 删除后处理
    afterRemove(event);
  }

  /// 删除前调用
  Future<bool> beforeRemove(OriginEvent event) async => true;

  /// 是否同时删除子事件
  Future<bool> isRemoveChildren(Event event) async {
    bool hasChildren = !event.children.isNull;
    bool isRemoveChildren = false;
    if (hasChildren) {
      // 询问用户是否删除子事件
      bool? res = await RouteHelper.showOneChoiceRequest(msg: "存在子事件，是否同时删除?", cancelText: "不删除");
      isRemoveChildren = res == true;
    }
    return isRemoveChildren;
  }

  /// 删除后调用
  void afterRemove(OriginEvent event) {
    // 从列表中移除
    eventList.removeWhere((e) => e.id.value == event.id.value);
    // 更新
    update();
  }

  /// 执行动作 因为有可能涉及到标签的过滤条件，所以需要刷新列表
  void doAction(OriginEvent event, Status action) async {
    // 判断是否可以执行动作
    bool result = await beforeAction(event, action);
    if (!result) return;
    String msg = "";
    if (event.children.isNull) {
      if (event.timingList.isNull) {
        msg = "";
      } else {
        msg = "更改该事件状态会同时更改其所有日程状态,确定更改吗?";
      }
    } else {
      if (event.timingList.isNull) {
        msg = "更改该事件状态会同时更改其子事件状态,确定更改吗?";
      } else {
        msg = "更改该事件状态会同时更改其子事件及其所有日程状态,确定更改吗?";
      }
    }
    if (msg.isNotEmpty) {
      bool? res = await RouteHelper.showOneChoiceRequest(msg: msg, doneText: "更改" cancelText: "不更改");
      if (res != true) return;
    }
    // 执行
    await originService.doAction(event, action);
    // 执行后操作
    afterAction(event, action);
  }

  /// 动作前调用
  Future<bool> beforeAction(OriginEvent event, Status action) async => true;

  /// 动作后调用
  void afterAction(OriginEvent event, Status action) {}

  @override
  HomePages get homePage => HomePages.event;
}
