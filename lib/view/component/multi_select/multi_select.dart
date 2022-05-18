import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hg_logger/ability/route/observer.dart';
import 'package:hg_logger/ability/route/route.dart';
import 'package:hg_logger/view/export.dart';

enum MultiSelectMode { page, widget }

/// 参数
@immutable
class MultiSelectArgs<T> extends ViewArgs {
  /// 是否多选
  final bool isMulti;

  /// 是否使用页面模式
  final MultiSelectMode mode;

  /// 导航ID
  final int? navigatorId;

  /// 页面标题
  final String title;

  /// 选项数量
  final int itemCount;

  /// 选中后
  final Function(int index)? onSelect;

  /// 选消后，单选不调用
  final Function(int index)? onUnSelect;

  /// 界面模式返回的时候用
  final Function(List<int> indexList)? onBack;

  /// 选项构建器
  final Widget Function(BuildContext context, int index, bool isSelect, Function(int index, bool isSelect) select)? itemBuilder;

  /// 列表滑动表现
  final ScrollPhysics? physics;

  final bool shrinkWrap;

  final bool canBeEmpty;

  final ScrollController? controller;

  final EdgeInsets? padding;

  final bool rawItem;

  const MultiSelectArgs({
    this.mode = MultiSelectMode.page,
    this.isMulti = false,
    this.itemCount = 0,
    this.title = "",
    this.onSelect,
    this.onUnSelect,
    this.itemBuilder,
    this.navigatorId,
    this.onBack,
    this.physics,
    this.shrinkWrap = false,
    this.canBeEmpty = false,
    this.controller,
    this.rawItem = false,
    this.padding,
  });
}

/// 数据
@immutable
class MultiSelectDataSource extends ViewDataSource {
  final List<int>? selected;

  const MultiSelectDataSource({this.selected});
}

/// 逻辑
class MultiSelectLogic extends ViewLogic<MultiSelectArgs, MultiSelectDataSource> {
  Set<int> selected = {};

  void back() {
    if (args.mode == MultiSelectMode.widget) return;
    RouteHelper.back(id: args.navigatorId);
  }

  void onBack() {
    args.onBack?.call(selected.toList());
  }

  @override
  void afterArgsUpdate() {
    selected.clear();
    selected.addAll(dataSource.selected ?? []);
  }

  void select(int index, bool isSelect) {
    if (args.isMulti) {
      if (isSelect) {
        selected.add(index);
        args.onSelect?.call(index);
      } else {
        selected.remove(index);
        args.onUnSelect?.call(index);
      }
    } else {
      if (isSelect) {
        selected.clear();
        selected.add(index);
        args.onSelect?.call(index);
        back();
      } else {
        if (args.canBeEmpty) {
          selected.clear();
          back();
        } else {
          RouteHelper.toast(msg: "至少选择一个");
        }
      }
    }
    update();
  }
}

/// 页面
class MultiSelect extends View<MultiSelectLogic> with ObserverWidget {
  MultiSelect({required String key, MultiSelectArgs? args, MultiSelectDataSource? dataSource})
      : super(
          key: key,
          args: args ?? const MultiSelectArgs(),
          dataSource: dataSource ?? const MultiSelectDataSource(),
          newLogic: MultiSelectLogic(),
        );

  @override
  void observe(ObserverRouting? routing) {
    if (routing?.isBack == true) {
      logic.onBack();
    }
  }

  @override
  Widget buildView(BuildContext context) {
    switch (logic.args.mode) {
      case MultiSelectMode.page:
        return Neumorphic(
          child: HgNeumorphicScaffold(
            leading: HgNeumorphicBackButton(onPressed: logic.back),
            title: HgNeumorphicText(logic.args.title),
            body: buildMultiSelect(),
          ),
        );
      case MultiSelectMode.widget:
        return buildMultiSelect();
    }
  }

  Widget buildMultiSelect() {
    return ListView.builder(
      clipBehavior: Clip.none,
      shrinkWrap: logic.args.shrinkWrap,
      physics: logic.args.physics,
      itemCount: logic.args.itemCount,
      controller: logic.args.controller,
      padding: logic.args.padding,
      itemBuilder: (BuildContext context, int index) {
        return buildItem(context, index);
      },
    );
  }

  /// 列表项
  Widget buildItem(BuildContext context, int index) {
    bool isSelect = logic.selected.contains(index);
    Widget? item = logic.args.itemBuilder?.call(context, index, isSelect, logic.select);
    if (logic.args.rawItem) return item ?? Container();
    return HgNeumorphicButton(
      margin: const EdgeInsets.all(8),
      padding: EdgeInsets.zero,
      child: ListTile(
        title: item,
        trailing: NeumorphicCheckbox(
          value: isSelect,
          onChanged: (value) => logic.select(index, value),
        ),
      ),
      onPressed: () => logic.select(index, !isSelect),
    );
  }
}
