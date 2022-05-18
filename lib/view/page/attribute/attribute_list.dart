import 'dart:async';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_logger/ability/route/route.dart';
import 'package:hg_logger/entity/data/event_attribute.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/service/services.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/export.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'attribute_detail.dart';
import 'attribute_settings.dart';

@immutable
class AttributeListArgs extends ViewArgs {
  /// 导航id
  final int navigatorId;

  /// 为介绍页预留
  final bool isIntro;

  const AttributeListArgs({required this.navigatorId, this.isIntro = false});
}

abstract class AttributeListLogic<M extends EventAttribute> extends ViewLogicOnlyArgs<AttributeListArgs> {
  /// 属性服务
  EventAttributeService<M> get service;

  /// 数据
  List<M> dataList = [];

  RefreshController refreshController = RefreshController();

  /// 初始化调用
  @override
  void onReady() {
    findAll();
  }

  @override
  void afterArgsUpdate() {
    // 不加这个hot reload会报错一个控制器给多个刷新组件用
    refreshController = RefreshController();
  }

  /// 新增
  Future<void> add(M model) async {
    await service.save(model);
    dataList.insert(0, model);
    RouteHelper.toast(msg: "添加成功");
    update();
  }

  /// 删除
  Future<void> remove(M model) async {
    await service.remove(model);
    dataList.removeWhere((e) => e.id.value == model.id.value);
    RouteHelper.toast(msg: "删除成功");
    update();
  }

  /// 更新
  Future<void> save(M model) async {
    await service.save(model);
    RouteHelper.toast(msg: "保存成功");
    update();
  }

  /// 查找所有属性
  Future<void> findAll() async {
    dataList.clear();
    List<M> all = await service.findByOrder();
    if (all.isEmpty) return;
    dataList.addAll(all);
    refreshController.refreshCompleted();
    update();
  }
}

/// 属性列表
abstract class AttributeList<M extends EventAttribute, L extends AttributeListLogic<M>> extends View<L> {
  AttributeList({
    required String key,
    required AttributeListArgs args,
    required L newLogic,
  }) : super(key: key, args: args, newLogic: newLogic);

  @override
  Widget buildView(BuildContext context) {
    if (logic.args.isIntro) {
      return buildGrid();
    }
    return buildRefresher();
  }

  Widget buildRefresher() {
    return SmartRefresher(
      key: ValueKey(logic.key),
      controller: logic.refreshController,
      onRefresh: () {
        HapticFeedback.lightImpact();
        logic.findAll();
      },
      child: buildGrid(),
    );
  }

  /// 交错布局
  Widget buildGrid() {
    List<Widget> children = [];
    for (M data in logic.dataList) {
      // 名称长度
      double titleLength = data.toString().length.toDouble();
      // 描述长度
      double subTitleLength = (data.content.value?.length ?? 0) * 1.0;
      // 最大长度
      double maxLength = max(titleLength, subTitleLength);
      int rowCount;
      if (maxLength <= 1) {
        rowCount = 1;
      } else if (maxLength <= 8) {
        rowCount = 2;
      } else if (maxLength <= 14) {
        rowCount = 3;
      } else {
        rowCount = 4;
      }
      children.add(StaggeredGridTile.count(crossAxisCellCount: rowCount, mainAxisCellCount: 0.8, child: buildItem(data)));
    }

    return StaggeredGrid.count(
      crossAxisCount: 4,
      children: children,
      axisDirection: AxisDirection.down,
    );
  }

  /// 构建单项
  Widget buildItem(M data) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    // 名称
    Widget mainTitle = Text(data.toString(), style: const TextStyle(fontSize: 16));
    // 描述
    Widget? subTitle = data.content.isNull ? null : Text(data.content.value!, style: TextStyle(color: themeData.disabledColor));
    List<Widget> columnChildren = [mainTitle];
    if (null != subTitle) columnChildren.add(subTitle);
    // 图标
    Widget leading = Neumorphic(child: Logo(iconValue: data.icon.value), style: NeumorphicStyle(depth: -themeData.depth));
    return HgNeumorphicButton(
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.all(8),
      child: Removeable(
        key: data.id.value,
        groupTag: M.toString(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 0, child: leading),
              const Padding(padding: EdgeInsets.only(left: 8)),
              Expanded(
                flex: 1,
                child: Container(
                  clipBehavior: Clip.none,
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: columnChildren),
                ),
              ),
            ],
          ),
        ),
        onRemove: logic.args.isIntro ? null : () => logic.remove(data),
      ),
      onPressed: () => logic.args.isIntro ? null : detail(data),
    );
  }

  /// 打开明细
  void detail(M model) {
    toDetail(
      model: model.clone() as M,
      state: PageState.edit,
      onDone: (newModel) async {
        model.merge(newModel);
        await logic.save(model);
      },
    );
  }

  /// 新增
  void add() {
    toDetail(
      model: ConstructorCache.get(M),
      state: PageState.add,
      onDone: logic.add,
    );
  }

  /// 明细页面的子路由ID
  int get detailNavigatorId;

  /// 设置页面的子路由
  int get settingsNavigatorId;

  /// 打开明细页面
  void toDetail({
    required M model,
    required PageState state,
    required Function(M newModel) onDone,
  }) {
    AttributeDetailArgs<M> detailArgs = AttributeDetailArgs<M>(
      navigatorId: detailNavigatorId,
      parentNavigatorId: logic.args.navigatorId,
      state: state,
      onDone: onDone,
    );
    AttributeDetailDataSource<M> detailDataSource = AttributeDetailDataSource<M>(data: model);
    RouteHelper.bottomPageNested(
      parentId: logic.args.navigatorId,
      nestedId: detailNavigatorId,
      page: buildDetailPage(model.id.value, detailArgs, detailDataSource),
    );
  }

  /// 构建明细页面
  Widget buildDetailPage(String key, AttributeDetailArgs<M> args, AttributeDetailDataSource<M> dataSource);

  /// 打开设置页面
  void toSettings() {
    AttributeSettingsArgs settingsArgs = AttributeSettingsArgs(
      parentNavigatorId: logic.args.navigatorId,
      navigatorId: settingsNavigatorId,
      onDone: logic.findAll,
    );
    RouteHelper.bottomPageNested(
      parentId: logic.args.navigatorId,
      nestedId: settingsNavigatorId,
      page: buildSettings(logic.key, settingsArgs),
    );
  }

  /// 构建设置页面
  Widget buildSettings(String key, AttributeSettingsArgs args);
}
