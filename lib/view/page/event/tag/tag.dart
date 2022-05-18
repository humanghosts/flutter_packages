import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:customizable_space_bar/customizable_space_bar.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/route/route.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/service/services.dart';
import 'package:hg_logger/view/export.dart';

import 'tag_edit.dart';
import 'tag_item.dart';

/// 参数
@immutable
class TagRowArgs extends ViewArgs {
  /// 导航id
  final int navigatorId;

  /// 选中标签时的操作
  final Function(Tag? tag)? onActive;

  final GlobalKey? tutorialKey;

  final Function(EventConfig confg)? onTagListChange;

  const TagRowArgs({
    this.onActive,
    required this.navigatorId,
    this.tutorialKey,
    this.onTagListChange,
  });
}

@immutable
class TagRowDataSource extends ViewDataSource {
  final EventConfig config;

  final Tag? activeTag;

  const TagRowDataSource({required this.config, this.activeTag});
}

class TagRowLogic extends ViewLogic<TagRowArgs, TagRowDataSource> {
  EventConfig get config => dataSource.config;

  Tag? get activeTag => dataSource.activeTag;

  final EventConfigService configService = EventConfigService.instance;

  /// 标签配置服务
  final PageController pageController = PageController(initialPage: 0);

  /// 标签页行数
  final int rowSize = 2;

  /// 标签页列数
  final int columnSize = 6;

  /// 区域高度 动态高度，这个是初始值
  Rx<double> expandHeight = 170.0.obs;

  /// 当前标签页页数
  Rx<int> pageIndex = 0.obs;

  /// 标签页页数
  Rx<int> pageSize = 1.obs;

  @override
  void afterArgsUpdate() {
    resetPage();
  }

  /// 重置标签页数等设置
  void resetPage() {
    // 标签总数
    int tagLength = config.tagList.value.length;
    // 每页的标签数
    int itemLengthInPage = columnSize * rowSize;
    // 标签页数
    int pageSize = max((tagLength / itemLengthInPage).ceil(), 1);
    this.pageSize.value = pageSize;
    // 当前页数 如果当前页数大于最大页数，定位至最后一页，用于删除时页数减少的情况
    if (pageIndex >= pageSize) {
      pageIndex.value = pageSize - 1;
    }
    // 标签宽度
    double itemWidth = (Get.width - 24) / columnSize;
    // 标签高度 = 图标高度+名称高度
    double itemHeight = itemWidth;

    // 按照实际行数算高度
    int realRowSize = rowSize;
    if (tagLength <= itemLengthInPage) {
      realRowSize = (tagLength / columnSize).ceil();
    }
    realRowSize = max(1, realRowSize);
    // 每一项的高度+间隔高度
    expandHeight.value = realRowSize * itemHeight + (realRowSize + 1) * 16;
    if (pageController.positions.isNotEmpty) pageController.jumpToPage(pageIndex.value);
  }

  /// 标签页翻页
  void onPageChanged(int index) {
    pageIndex.value = index;
    HapticFeedback.lightImpact();
  }

  /// 活跃标签
  void active(Tag? tag) {
    if (activeTag?.id.value == tag?.id.value) return;
    args.onActive?.call(tag);
  }

  /// 点击标签
  void tap(Tag tag) => active(tag);

  /// 设置
  void setConfig(EventConfig config) async {
    args.onTagListChange?.call(config);
  }
}

/// 页面
class TagRow extends View<TagRowLogic> {
  TagRow({
    required String key,
    required TagRowArgs args,
    required TagRowDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: TagRowLogic());

  @override
  Widget buildView(BuildContext context) {
    return Obx(() {
      return SliverAppBar(
        automaticallyImplyLeading: false,
        expandedHeight: logic.expandHeight.value,
        pinned: true,
        elevation: 0,
        forceElevated: true,
        flexibleSpace: CustomizableSpaceBar(
          builder: (context, scrollingRate) {
            List<Widget> children = [];
            // 标签
            if (scrollingRate < 1) {
              children.add(Opacity(opacity: 1 - scrollingRate, child: buildSlidable(scrollingRate)));
            }
            // 名称
            if (scrollingRate > 0) {
              children.add(Opacity(opacity: scrollingRate, child: buildTabBar(scrollingRate)));
            }
            return Stack(
              children: children,
              clipBehavior: Clip.none,
            );
          },
        ),
      );
    });
  }

  /// 构建选中标签
  Widget buildTabBar(double rate) {
    String text = logic.activeTag == null ? "无选中标签" : logic.activeTag.toString();
    Widget logo = Container(
      padding: const EdgeInsets.only(right: 8),
      child: logic.activeTag == null ? null : Neumorphic(child: Logo.expand(iconValue: logic.activeTag!.icon.value)),
    );
    return Neumorphic(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [logo, Text(text, style: const TextStyle(fontWeight: FontWeight.bold))],
        ),
      ),
    );
  }

  /// 构建可滑动区域
  Widget buildSlidable(double rate) {
    return BounceInDown(
      key: ValueKey(logic.key),
      child: Neumorphic(
        key: logic.args.tutorialKey,
        child: Obx(() {
          return Slidable(
            key: key,
            direction: Axis.vertical,
            closeOnScroll: true,
            child: buildTabView(),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              extentRatio: 80 / logic.expandHeight.value,
              dismissible: DismissiblePane(
                closeOnCancel: true,
                onDismissed: () {},
                confirmDismiss: () async {
                  toEdit();
                  HapticFeedback.lightImpact();
                  return false;
                },
              ),
              children: [Expanded(child: buildEditAction())],
            ),
          );
        }),
      ),
    );
  }

  /// 构建编辑按钮
  Widget buildEditAction() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return SizedBox.expand(
      child: HgNeumorphicButton(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HgNeumorphicIcon(Icons.edit, color: Colors.orange),
              const Text("编辑", style: TextStyle(color: Colors.orange)),
            ],
          ),
        ),
        style: NeumorphicStyle(depth: -themeData.depth),
        onPressed: toEdit,
      ),
    );
  }

  Widget buildTabView() {
    if (logic.config.tagList.isNull) {
      return Container();
    }
    List<Widget> pages = [];
    for (int i = 0; i < logic.pageSize.value; i++) {
      pages.add(buildOneTabView(i));
    }
    return PageView.builder(
      onPageChanged: logic.onPageChanged,
      controller: logic.pageController,
      itemCount: pages.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.zero,
          alignment: Alignment.center,
          child: pages[index],
        );
      },
    );
  }

  /// 构建标签页
  Widget buildOneTabView(int pageIndex) {
    // 每页数量
    int pageRange = logic.rowSize * logic.columnSize;
    // 页开始
    int start = pageIndex * pageRange;
    int end = start + pageRange - 1;
    end = min(logic.config.tagList.value.length - 1, end);
    end = max(end, 0);
    // 遍历行
    List<Widget> children = [];
    for (int i = start; i <= end; i++) {
      children.add(buildTag(logic.config.tagList.value[i]));
    }
    return GridView.builder(
      clipBehavior: Clip.none,
      padding: const EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: logic.columnSize,
        childAspectRatio: 0.8,
        crossAxisSpacing: 4,
        mainAxisSpacing: 16,
      ),
      itemCount: children.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return children[index];
      },
    );
  }

  /// 构建一个标签
  Widget buildTag(Tag tag) {
    return TagRowItem(
      key: tag.id.value,
      args: TagRowItemArgs(
        isActive: logic.activeTag?.id.value == tag.id.value,
        onTap: () => logic.tap(tag),
      ),
      dataSource: TagRowItemDataSource(tag: tag),
    );
  }

  void toEdit() {
    int nestedId = "tag_row_edit".hashCode;
    RouteHelper.bottomPageNested(
      nestedId: nestedId,
      parentId: logic.args.navigatorId,
      page: TagRowEdit(
        key: "tag_row_edit",
        args: TagRowEditArgs(
          navigatorId: nestedId,
          parentNavigatorId: logic.args.navigatorId,
          onDone: logic.setConfig,
        ),
        dataSource: TagRowEditDataSource(config: logic.config),
      ),
    );
  }
}
