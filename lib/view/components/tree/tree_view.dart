import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hg_framework/hg_framework.dart';
import 'package:reorderables/reorderables.dart';

/// 树参数
class TreeArgs extends ViewArgs {
  /// 树节点上下间距
  final EdgeInsetsGeometry? nodeVerticalPadding;

  /// 节点默认展开状态
  final bool initExpanded;

  /// 展开收缩按钮模式
  final TreeNodeIconMode iconMode;

  /// 节点间的分割组件
  final Widget? divider;

  /// 展开收缩按钮大小
  final double? iconSize;

  /// 展开按钮
  final Widget? icon;

  /// 垂直分割线构建器
  final Widget? verticalDivider;

  /// 不同级别的树节点的水平缩进
  final double indent;

  /// 重排序回调
  final void Function(int oldIndex, int newIndex, TreeNode? parent)? onReorder;

  /// 动画构建器
  final Widget Function(TreeNode node, Widget child)? transitionBuilder;

  late final Widget Function(TreeViewLogic viewLogic, TreeNode node, TreeNodeLogic nodeLogic) nodeContentBuilder;

  TreeArgs({
    this.indent = 40,
    this.nodeVerticalPadding,
    this.initExpanded = false,
    this.iconMode = TreeNodeIconMode.none,
    this.divider,
    this.iconSize,
    this.verticalDivider,
    this.transitionBuilder,
    this.onReorder,
    this.icon,
    Widget Function(TreeViewLogic viewLogic, TreeNode node, TreeNodeLogic nodeLogic)? nodeContentBuilder,
  }) {
    this.nodeContentBuilder = nodeContentBuilder ?? (viewLogic, node, nodeLogic) => const SizedBox.shrink();
  }
}

/// 树表参数
@immutable
class TreeViewArgs extends TreeArgs {
  /// 根节点
  final List<TreeNode> nodes;

  /// 获取树控制器
  final void Function(TreeViewLogic treeController)? treeController;

  TreeViewArgs({
    required this.nodes,
    this.treeController,
    super.indent,
    super.nodeVerticalPadding,
    super.initExpanded,
    super.iconMode = TreeNodeIconMode.none,
    super.divider,
    super.iconSize,
    super.verticalDivider,
    super.onReorder,
    super.icon,
    super.nodeContentBuilder,
  });
}

/// 树表控制器
class TreeViewLogic extends ViewLogicOnlyArgs<TreeViewArgs> {
  @override
  void afterArgsUpdate() {
    super.afterArgsUpdate();
    args.treeController?.call(this);
  }

  /// 根节点更新标识
  RxInt rootUpdateFlag = 0.obs;

  /// 子节点动画控制器，用于进场和退场
  Map<String, AnimationController> childrenAnimationControllerMap = {};

  /// 重新构建节点
  void resetRoot(List<TreeNode> nodes) {
    args.nodes.clear();
    args.nodes.addAll(nodes);
    childrenAnimationControllerMap.clear();
    rootUpdateFlag++;
  }

  /// 添加节点
  void addRoot(TreeNode node) {
    args.nodes.add(node);
    rootUpdateFlag++;
  }

  /// 移除节点
  void removeRoot(String key) async {
    await childrenAnimationControllerMap[key]?.reverse();
    childrenAnimationControllerMap.remove(key);
    args.nodes.removeWhere((element) => element.key == key);
    rootUpdateFlag++;
  }

  /// 重排序
  void onReorder(int oldIndex, int newIndex) {
    List<TreeNode> roots = args.nodes;
    TreeNode node = roots.removeAt(oldIndex);
    roots.insert(newIndex, node);
    rootUpdateFlag++;
    args.onReorder?.call(oldIndex, newIndex, null);
  }
}

/// 树表
class TreeView extends View<TreeViewLogic> {
  TreeView({
    required String key,
    required TreeViewArgs args,
  }) : super(key: key, args: args, logic: TreeViewLogic());

  @override
  Widget buildView(BuildContext context) {
    return Obx(() {
      logic.rootUpdateFlag.value;
      List<Widget> children = [];
      List<TreeNode> roots = logic.args.nodes;
      for (TreeNode node in roots) {
        children.add(buildNode(context, node));
      }
      // 不支持重排序
      if (logic.args.onReorder == null) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: children);
      }

      return ReorderableColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        onReorder: logic.onReorder,
        needsLongPressDraggable: DeviceInfoHelper.isMobile,
        scrollController: ScrollController(),
        children: children,
      );
    });
  }

  /// 构建单个节点
  Widget buildNode(BuildContext context, TreeNode node) {
    Widget nodeWidget;
    TreeNodeView treeNodeView = TreeNodeView(
      args: TreeNodeArgs.fromTree(treeNode: node, treeViewLogic: logic, treeViewArgs: logic.args),
    );
    if (logic.args.transitionBuilder != null) {
      nodeWidget = logic.args.transitionBuilder!.call(node, treeNodeView);
    } else {
      nodeWidget = buildSlideInLeft(logic, node, treeNodeView);
    }
    return Column(
      key: ValueKey(node.key),
      children: [
        nodeWidget,
        if (logic.args.divider != null && node != logic.args.nodes.last) logic.args.divider!,
      ],
    );
  }

  /// 构建滑入动画
  Widget buildSlideInLeft(TreeViewLogic logic, TreeNode node, Widget child) {
    String id = node.key;
    // 动画控制器
    AnimationController controller = logic.childrenAnimationControllerMap.putIfAbsent(id, () {
      AnimationController newController = AnimationController(
        duration: logic.fastAnimationDuration,
        vsync: SimpleTickerProvider(),
      );
      return newController;
    });

    Animation<double> animation = Tween<double>(begin: 100 * -1, end: 0).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    // 立即播放动画
    Future.delayed(Duration.zero, () {
      if (controller.status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });

    return Container(
      key: ValueKey(id),
      child: AnimatedBuilder(
        key: ValueKey(id),
        animation: controller,
        builder: (BuildContext context, Widget? child) {
          return Transform.translate(
            offset: Offset(animation.value, 0),
            child: child,
          );
        },
        child: child,
      ),
    );
  }
}
