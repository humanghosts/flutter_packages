import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/export.dart';
import 'package:hg_orm/hg_orm.dart';

import '../card/card.dart';
import '../detail/detail_event.dart';
import '../detail/detail_origin.dart';

/// 外部参数
@immutable
class OriginEventSearchArgs extends ViewArgs {
  /// 导航id
  final int navigatorId;

  const OriginEventSearchArgs({required this.navigatorId});
}

/// 逻辑
class OriginEventSearchLogic extends OriginEventLogic<OriginEventSearchArgs, ViewDataSource> {
  /// 搜索框控制器
  final TextEditingController searchController = TextEditingController();

  /// 搜索文本
  Rx<String> searchText = "".obs;

  /// 搜索框焦点
  FocusNode focusNode = FocusNode();

  /// 列表更新标识
  Rx<int> listUpdateFlag = 0.obs;

  /// 搜索
  Future<void> search(String text) async {
    searchText.value = text;
    eventList.clear();
    if (text.isEmpty) {
      eventList = await originService.findTree();
    } else {
      eventList = await originService.findTree(
        filter: GroupFilter.or([
          SingleFilter.matches(field: Event.nameKey, value: text),
          SingleFilter.matches(field: Event.contentKey, value: text),
        ]),
      );
    }
    listUpdateFlag.value++;
  }

  void clearSearch() async {
    searchController.clear();
    searchText.value = "";
  }

  @override
  void afterRemove(OriginEvent event) {
    eventList.removeWhere((element) => element.id.value == event.id.value);
    listUpdateFlag.value++;
  }

  @override
  void unFocus() {
    focusNode.unfocus();
  }

  @override
  void focus() {
    focusNode.requestFocus();
  }

  @override
  void buildTutorial() {}
}

/// 事件搜索页面
class OriginEventSearch extends View<OriginEventSearchLogic> {
  OriginEventSearch({required String key, required OriginEventSearchArgs args})
      : super(
          key: key,
          args: args,
          newLogic: OriginEventSearchLogic(),
        );

  @override
  Widget buildView(BuildContext context) {
    return HgNeumorphicScaffold(
      title: buildSearchBar(),
      body: buildSearchPanel(),
      bodyPadding: EdgeInsets.zero,
    );
  }

  /// 构建搜索框
  Widget buildSearchBar() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return SizedBox(
      height: kToolbarHeight,
      child: Neumorphic(
        style: NeumorphicStyle(depth: -themeData.depth),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 搜索框
            CupertinoSearchTextField(
              controller: logic.searchController,
              placeholder: "搜索事件",
              focusNode: logic.focusNode,
              backgroundColor: themeData.baseColor,
              prefixIcon: HgNeumorphicIcon(Icons.search),
              prefixInsets: const EdgeInsets.only(left: 4),
              suffixMode: OverlayVisibilityMode.never,
              onChanged: (value) => logic.searchText.value = value,
              onSubmitted: logic.search,
              style: TextStyle(color: themeData.defaultTextColor),
            ),
            // 清空按钮
            Positioned(
              right: 0,
              child: Obx(
                () {
                  if (logic.searchText.value.isEmpty) return Container();
                  return HgNeumorphicButton(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.all(4),
                    style: const NeumorphicStyle(boxShape: NeumorphicBoxShape.circle()),
                    child: HgNeumorphicIcon(Icons.clear),
                    onPressed: logic.clearSearch,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建搜索面板
  Widget buildSearchPanel() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Obx(() {
      int listUpdateFlagValue = logic.listUpdateFlag.value;
      debugPrint("事件搜索列表刷新:$listUpdateFlagValue");
      if (logic.eventList.isNotEmpty) {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          itemBuilder: (context, index) {
            return buildItem(logic.eventList[index]);
          },
          itemCount: logic.eventList.length,
        );
      } else {
        return Center(child: Text("无事发生", style: TextStyle(color: themeData.disabledColor)));
      }
    });
  }

  Widget buildItem(OriginEvent event) {
    return FadeInLeft(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: EventCard<OriginEvent>(
          key: "search_${event.id.value}",
          args: EventCardArgs<OriginEvent>(
            onTap: (event) => toDetail(event, PageState.edit),
            canRemove: logic.canRemove,
            onRemove: logic.remove,
            onAction: logic.doAction,
            state: PageState.edit,
          ),
          dataSource: EventCardDataSource<OriginEvent>(event: event, config: logic.config),
        ),
      ),
    );
  }

  /// 源事件
  void toOrigin(OriginEvent origin, PageState state) {}

  /// 事件详情
  void toDetail(OriginEvent event, PageState state) {
    RouteHelper.bottomPageNested(
      parentId: logic.args.navigatorId,
      nestedId: event.id.value.hashCode,
      page: OriginEventDetail(
        key: event.id.value,
        args: EventDetailArgs(
          parentNavigatorId: logic.args.navigatorId,
          state: state,
          navigatorId: event.id.value.hashCode,
          onBack: () => logic.search(logic.searchText.value),
          onDone: () => logic.search(logic.searchText.value),
        ),
        dataSource: EventDetailDataSource(event: event, config: logic.config),
      ),
    );
  }
}
