import 'package:flutter/material.dart';
import 'package:hgs_device_info/device_info.dart';
import 'package:hgs_framework/framework.dart';
import 'package:reorderables/reorderables.dart';
import 'package:styled_widget/styled_widget.dart';

import '../clickable.dart';
import '../trick_provider.dart';
import 'tree_view.dart';

/// 树形节点 收缩展开按钮模式，决定是否占用空间
enum TreeNodeIconMode {
  /// 隐藏 会占用空间
  hidden,

  /// 禁用，显示并占用空间
  disable,

  /// 无，不占用空间
  none,
}

/// 树节点
class TreeNode {
  /// 节点ID
  final String key;

  /// 树节点绑定的值
  final dynamic value;

  /// 子节点
  late final List<TreeNode> children;

  /// 节点内容构建器，优先级高于[TreeViewArgs]
  late final Widget Function(TreeNodeLogic logic)? contentBuilder;

  TreeNode({
    required this.key,
    this.value,
    this.contentBuilder,
    List<TreeNode>? children,
  }) {
    this.children = children ?? [];
  }
}

/// 树节点参数
@immutable
class TreeNodeArgs extends TreeArgs {
  /// 树节点
  final TreeNode treeNode;

  /// 树控制器
  final TreeViewLogic treeViewLogic;

  final TreeNodeLogic? parentNodeLogic;

  /// 节点等级
  final int level;

  /// 普通构造
  TreeNodeArgs({
    required this.treeNode,
    required this.treeViewLogic,
    required this.level,
    this.parentNodeLogic,
    super.initExpanded,
    super.indent,
    super.iconSize,
    super.nodeVerticalPadding,
    super.iconMode,
    super.divider,
    super.verticalDivider,
    super.onReorder,
    super.transitionBuilder,
    super.icon,
    super.nodeContentBuilder,
  });

  /// 拷贝树参数的构造
  TreeNodeArgs.fromTree({
    required this.treeNode,
    required this.treeViewLogic,
    required TreeViewArgs treeViewArgs,
  })  : level = 0,
        parentNodeLogic = null,
        super(
          indent: treeViewArgs.indent,
          nodeVerticalPadding: treeViewArgs.nodeVerticalPadding,
          initExpanded: treeViewArgs.initExpanded,
          iconMode: treeViewArgs.iconMode,
          divider: treeViewArgs.divider,
          iconSize: treeViewArgs.iconSize,
          verticalDivider: treeViewArgs.verticalDivider,
          onReorder: treeViewArgs.onReorder,
          icon: treeViewArgs.icon,
          transitionBuilder: treeViewArgs.transitionBuilder,
          nodeContentBuilder: treeViewArgs.nodeContentBuilder,
        );

  /// 拷贝上级节点的构造
  TreeNodeArgs.fromNode({
    Key? key,
    required this.treeNode,
    required TreeNodeArgs treeNodeArgs,
    required TreeNodeLogic parentLogic,
  })  : treeViewLogic = treeNodeArgs.treeViewLogic,
        parentNodeLogic = parentLogic,
        level = treeNodeArgs.level + 1,
        super(
          indent: treeNodeArgs.indent,
          nodeVerticalPadding: treeNodeArgs.nodeVerticalPadding,
          initExpanded: treeNodeArgs.initExpanded,
          iconMode: treeNodeArgs.iconMode,
          divider: treeNodeArgs.divider,
          iconSize: treeNodeArgs.iconSize,
          verticalDivider: treeNodeArgs.verticalDivider,
          onReorder: treeNodeArgs.onReorder,
          icon: treeNodeArgs.icon,
          transitionBuilder: treeNodeArgs.transitionBuilder,
          nodeContentBuilder: treeNodeArgs.nodeContentBuilder,
        );

  String get logicKey {
    if (null != parentNodeLogic) {
      return "${parentNodeLogic!.key}_${treeNode.key}";
    }
    return "${treeViewLogic.key}_${treeNode.key}";
  }

  static getKey(String parentKey, String key) {
    return "${parentKey}_$key}";
  }
}

/// 树节点控制器
class TreeNodeLogic extends ViewLogicOnlyArgs<TreeNodeArgs> {
  /// 展开收缩更新标识
  RxBool isExpanded = false.obs;

  /// 子节点更新标识
  RxInt childrenUpdateFlag = 0.obs;

  /// 子节点动画控制器，用于进场和退场
  Map<String, AnimationController> childrenAnimationControllerMap = {};

  @override
  void onReady() {
    super.onReady();
    isExpanded.value = args.initExpanded;
  }

  /// 展开下级节点
  void expand() => isExpanded.value = true;

  /// 收缩下级节点
  void collapse() {
    for (AnimationController controller in childrenAnimationControllerMap.values) {
      controller.reverse();
    }
    isExpanded.value = false;
  }

  /// 展开或收缩下级节点
  void toggle() {
    if (isExpanded.value) {
      collapse();
    } else {
      expand();
    }
  }

  /// 重新构建子节点 会直接修改TreeNode
  void resetChildren(List<TreeNode> children) {
    args.treeNode.children.clear();
    args.treeNode.children.addAll(children);
    childrenAnimationControllerMap.clear();
    childrenUpdateFlag++;
  }

  /// 添加子节点
  void addChild(TreeNode child) {
    args.treeNode.children.add(child);
    childrenUpdateFlag++;
  }

  /// 移除子节点
  Future<void> removeChild(String key) async {
    String id = TreeNodeArgs.getKey(this.key, key);

    await childrenAnimationControllerMap[id]?.reverse();
    childrenAnimationControllerMap.remove(id);
    args.treeNode.children.removeWhere((element) => element.key == key);
    childrenUpdateFlag++;
  }

  /// 子节点重排序
  void onReorder(int oldIndex, int newIndex) {
    List<TreeNode> children = args.treeNode.children;
    TreeNode node = children.removeAt(oldIndex);
    children.insert(newIndex, node);
    childrenUpdateFlag++;
    args.onReorder?.call(oldIndex, newIndex, args.treeNode);
  }
}

/// 子节点控件
class TreeNodeView extends View<TreeNodeLogic> {
  TreeNodeView({
    required TreeNodeArgs args,
  }) : super(key: args.logicKey, args: args, logic: TreeNodeLogic());

  @override
  Widget buildView(BuildContext context) {
    return [
      // 主节点
      Obx(() => buildNode(context)),
      // 子节点
      Obx(() => buildChildren(context)),
    ].toColumn(crossAxisAlignment: CrossAxisAlignment.start);
  }

  /// 构建主节点
  Widget buildNode(BuildContext context) {
    // 需要根据子节点是否存在决定展开收起按钮的状态，所以监听这个变量
    logic.childrenUpdateFlag.value;
    // 子节点的内容
    List<TreeNode>? children = logic.args.treeNode.children;
    // 是否是叶子节点
    bool isLeaf = children.isEmpty;
    // 分隔符
    List<Widget> dividerList = [];
    // 垂直分割线
    for (int i = 0; i < logic.args.level; i++) {
      dividerList.add(SizedBox(
        width: logic.args.indent,
        child: logic.args.verticalDivider,
      ));
    }

    Widget nodeContent;
    if (logic.args.treeNode.contentBuilder != null) {
      nodeContent = logic.args.treeNode.contentBuilder!.call(logic);
    } else {
      nodeContent = logic.args.nodeContentBuilder.call(logic.args.treeViewLogic, logic.args.treeNode, logic);
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 垂直分割线
          ...dividerList,
          // 展开收缩按钮
          Container(
            padding: logic.args.nodeVerticalPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Obx(() => buildExpandIcon(context, isLeaf, logic.isExpanded.value))],
            ),
          ),
          // 节点内容
          Container(padding: logic.args.nodeVerticalPadding, child: nodeContent),
        ],
      ),
    );
  }

  /// 展开收缩按钮构建器
  Widget buildExpandIcon(BuildContext context, bool isLeaf, bool isExpanded) {
    // 按钮模式
    TreeNodeIconMode iconMode = logic.args.iconMode;
    ThemeData theme = themeConfig.themeData;
    // 按钮色彩
    Color? color = iconMode == TreeNodeIconMode.disable && isLeaf ? theme.disabledColor : theme.textButtonTheme.style?.foregroundColor?.resolve({});
    // 按钮组件
    Widget icon = logic.args.icon ?? const Icon(Icons.expand_circle_down_outlined);

    // 点击方法
    VoidCallback? onTap;
    if (iconMode != TreeNodeIconMode.disable || !isLeaf) {
      onTap = logic.toggle;
    }
    // 提示语
    String? tooltip;
    if (!isLeaf) tooltip = logic.isExpanded.value ? "收起" : "展开";

    // 按钮
    Widget iconButton = Clickable(
      onTap: onTap,
      tooltip: tooltip,
      child: IconTheme.merge(
        data: IconThemeData(color: color),
        child: AnimatedRotation(
          turns: logic.isExpanded.value ? 0 : -0.25,
          duration: animationConfig.fastAnimationDuration,
          child: SizedBox.square(
            dimension: logic.args.iconSize,
            child: icon.fittedBox(fit: BoxFit.fitHeight),
          ),
        ),
      ),
    );

    Widget child;
    switch (iconMode) {
      case TreeNodeIconMode.hidden:
        child = Opacity(
          opacity: isLeaf ? 0 : 1,
          child: SizedBox.square(dimension: logic.args.indent, child: isLeaf ? const SizedBox.shrink() : iconButton),
        );
        break;
      case TreeNodeIconMode.disable:
        child = SizedBox.square(dimension: logic.args.indent, child: iconButton);
        break;
      case TreeNodeIconMode.none:
        child = isLeaf ? const SizedBox.shrink() : SizedBox.square(dimension: logic.args.indent, child: iconButton);
        break;
    }

    return AnimatedSwitcher(
      key: ValueKey("${logic.key}_icon"),
      duration: animationConfig.fastAnimationDuration,
      transitionBuilder: (child, animation) {
        return SizeTransition(
          sizeFactor: animation,
          axisAlignment: -1.0,
          axis: Axis.horizontal,
          child: child,
        );
      },
      child: child,
    );
  }

  /// 构建子节点
  Widget buildChildren(BuildContext context) {
    logic.childrenUpdateFlag.value;
    List<TreeNode> children = logic.args.treeNode.children;
    bool isLeaf = children.isEmpty;
    if (!logic.isExpanded.value || isLeaf) {
      return AnimatedSwitcher(
        key: ValueKey("${logic.key}_children"),
        duration: animationConfig.fastAnimationDuration,
        transitionBuilder: (child, animation) {
          return SizeTransition(sizeFactor: animation, axisAlignment: -1.0, child: child);
        },
        child: const SizedBox.shrink(),
      );
    }

    List<Widget> childrenWidget = [];
    for (TreeNode node in children) {
      childrenWidget.add(buildChildNode(context, node));
    }

    Widget? divider;
    if (childrenWidget.isNotEmpty && logic.args.divider != null) {
      divider = Container(padding: EdgeInsets.only(left: logic.args.indent), child: logic.args.divider!);
    }
    return AnimatedSwitcher(
      key: ValueKey("${logic.key}_children"),
      duration: animationConfig.fastAnimationDuration,
      transitionBuilder: (child, animation) {
        return SizeTransition(sizeFactor: animation, axisAlignment: -1.0, child: child);
      },
      child: logic.args.onReorder == null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (divider != null) divider,
                ...childrenWidget,
                const SizedBox(height: 12),
              ],
            )
          : Column(
              children: [
                if (divider != null) divider,
                ReorderableColumn(
                  onReorder: logic.onReorder,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  needsLongPressDraggable: DeviceInfoHelper().isMobile,
                  scrollController: ScrollController(),
                  children: childrenWidget,
                ),
                const SizedBox(height: 12),
              ],
            ),
    );
  }

  /// 构建单个节点
  Widget buildChildNode(BuildContext context, TreeNode node) {
    Widget nodeWidget;
    TreeNodeArgs treeNodeArgs = TreeNodeArgs.fromNode(treeNode: node, treeNodeArgs: logic.args, parentLogic: logic);
    TreeNodeView treeNodeView = TreeNodeView(
      args: treeNodeArgs,
    );
    if (logic.args.transitionBuilder != null) {
      nodeWidget = logic.args.transitionBuilder!.call(node, treeNodeView);
    } else {
      nodeWidget = buildSlideInLeft(node, treeNodeView);
    }
    return Column(
      key: ValueKey(treeNodeArgs.logicKey),
      children: [
        nodeWidget,
        if (node != logic.args.treeNode.children.last && logic.args.divider != null)
          Container(padding: EdgeInsets.only(left: logic.args.indent), child: logic.args.divider!),
      ],
    );
  }

  Widget buildSlideInLeft(TreeNode node, Widget child) {
    String id = TreeNodeArgs.getKey(logic.key, node.key);
    // 动画控制器
    AnimationController controller = logic.childrenAnimationControllerMap.putIfAbsent(id, () {
      AnimationController newController = AnimationController(
        duration: animationConfig.fastAnimationDuration,
        vsync: SimpleTickerProvider(),
      );
      return newController;
    });

    Animation<double> animation = Tween<double>(begin: 100 * -1, end: 0).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    // 立即播放动画
    Future.delayed(Duration.zero, () => controller.forward());

    return AnimatedBuilder(
      key: ValueKey(id),
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        return Transform.translate(
          offset: Offset(animation.value, 0),
          child: child,
        );
      },
      child: child,
    );
  }
}
