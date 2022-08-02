import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hg_framework/hg_framework.dart';
import 'package:reorderables/reorderables.dart';

/// 树形节点 收缩展开按钮模式，决定是否占用空间
enum TreeNodeIconMode { hidden, disable, none }

/// 树节点
class TreeNode<T> {
  /// 子节点
  final List<TreeNode<T>> children;

  /// 节点内容
  final Widget content;

  /// 节点ID
  final String key;

  final T? value;

  TreeNode({
    required this.key,
    List<TreeNode<T>>? children,
    Widget? content,
    this.value,
  })  : content = content ?? const SizedBox.shrink(),
        children = children ?? [];
}

/// 树参数
class TreeArgs<T> extends ViewArgs {
  /// 树节点上下间距
  final EdgeInsetsGeometry? padding;

  /// 节点默认展开状态
  final bool initExpanded;

  /// 展开收缩按钮模式
  final TreeNodeIconMode iconMode;

  /// 节点间的分割组件
  final Widget? divider;

  /// 展开收缩按钮大小
  final double? iconSize;

  /// 垂直分割线是否显示
  final bool showVerticalDivider;

  /// 不同级别的树节点的水平缩进
  final double indent;

  /// 重排序回调
  final void Function(int oldIndex, int newIndex, TreeNode<T>? parent)? onReorder;

  const TreeArgs({
    this.indent = 40,
    this.padding,
    this.initExpanded = false,
    this.iconMode = TreeNodeIconMode.none,
    this.divider,
    this.iconSize,
    this.showVerticalDivider = true,
    this.onReorder,
  });
}

/// 树表参数
@immutable
class TreeViewArgs<T> extends TreeArgs<T> {
  /// 根节点
  final List<TreeNode<T>> nodes;

  /// 获取树控制器
  final void Function(TreeViewLogic treeController)? treeController;

  const TreeViewArgs({
    required this.nodes,
    this.treeController,
    super.indent,
    super.padding,
    super.initExpanded,
    super.iconMode = TreeNodeIconMode.none,
    super.divider,
    super.iconSize,
    super.showVerticalDivider,
    super.onReorder,
  });
}

/// 树表控制器
class TreeViewLogic<T> extends ViewLogicOnlyArgs<TreeViewArgs<T>> {
  @override
  void afterArgsUpdate() {
    super.afterArgsUpdate();
    args.treeController?.call(this);
  }

  /// 获取节点控制器
  TreeNodeLogic<T>? treeNodeLogic(String key) {
    bool isRegistered = Get.isRegistered<TreeNodeLogic<T>>(tag: key);
    if (!isRegistered) return null;
    return Get.find<TreeNodeLogic<T>>(tag: key);
  }

  /// 根节点更新标识
  RxInt rootUpdateFlag = 0.obs;

  /// 子节点动画控制器，用于进场和退场
  Map<String, AnimationController> childrenAnimationControllerMap = {};

  /// 重新构建节点
  void setRoot(List<TreeNode<T>> nodes) {
    args.nodes.clear();
    args.nodes.addAll(nodes);
    childrenAnimationControllerMap.clear();
    rootUpdateFlag++;
  }

  /// 添加节点
  void addRoot(TreeNode<T> node) {
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
    List<TreeNode<T>> roots = args.nodes;
    TreeNode<T> node = roots.removeAt(oldIndex);
    roots.insert(newIndex, node);
    rootUpdateFlag++;
    args.onReorder?.call(oldIndex, newIndex, null);
  }
}

/// 树表
class TreeView<T> extends View<TreeViewLogic<T>> {
  TreeView({
    required String key,
    required TreeViewArgs<T> args,
  }) : super(key: key, args: args, logic: TreeViewLogic<T>());

  @override
  Widget buildView(BuildContext context) {
    return Obx(() {
      logic.rootUpdateFlag.value;
      List<Widget> children = [];
      List<TreeNode<T>> roots = logic.args.nodes;
      for (TreeNode<T> node in roots) {
        children.add(Column(
          key: ValueKey(node.key),
          children: [
            buildSlideInLeft(
              node,
              TreeNodeView<T>(
                key: node.key,
                args: TreeNodeArgs.fromTree(treeNode: node, treeViewLogic: logic, treeViewArgs: logic.args),
              ),
            ),
            if (logic.args.divider != null && node != roots.last) logic.args.divider!,
          ],
        ));
      }
      // 不支持重排序
      if (logic.args.onReorder == null) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: children);
      }

      return ReorderableColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        onReorder: logic.onReorder,
        needsLongPressDraggable: DeviceInfoHelper.isMobile,
        children: children,
      );
    });
  }

  Widget buildSlideInLeft(TreeNode<T> node, Widget child) {
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

/// 树节点参数
@immutable
class TreeNodeArgs<T> extends TreeArgs<T> {
  /// 树节点
  final TreeNode<T> treeNode;

  /// 树控制器
  final TreeViewLogic treeViewLogic;

  /// 节点等级
  final int level;

  const TreeNodeArgs({
    required this.treeNode,
    required this.treeViewLogic,
    required this.level,
    super.initExpanded,
    super.indent,
    super.iconSize,
    super.padding,
    super.iconMode,
    super.divider,
    super.showVerticalDivider,
    super.onReorder,
  });

  TreeNodeArgs.fromTree({
    required this.treeNode,
    required this.treeViewLogic,
    required TreeViewArgs<T> treeViewArgs,
  })  : level = 0,
        super(
          indent: treeViewArgs.indent,
          padding: treeViewArgs.padding,
          initExpanded: treeViewArgs.initExpanded,
          iconMode: treeViewArgs.iconMode,
          divider: treeViewArgs.divider,
          iconSize: treeViewArgs.iconSize,
          showVerticalDivider: treeViewArgs.showVerticalDivider,
          onReorder: treeViewArgs.onReorder,
        );

  TreeNodeArgs.fromNode({
    Key? key,
    required this.treeNode,
    required TreeNodeArgs<T> treeNodeArgs,
  })  : treeViewLogic = treeNodeArgs.treeViewLogic,
        level = treeNodeArgs.level + 1,
        super(
          indent: treeNodeArgs.indent,
          padding: treeNodeArgs.padding,
          initExpanded: treeNodeArgs.initExpanded,
          iconMode: treeNodeArgs.iconMode,
          divider: treeNodeArgs.divider,
          iconSize: treeNodeArgs.iconSize,
          showVerticalDivider: treeNodeArgs.showVerticalDivider,
          onReorder: treeNodeArgs.onReorder,
        );
}

/// 树节点控制器
class TreeNodeLogic<T> extends ViewLogicOnlyArgs<TreeNodeArgs<T>> {
  /// 展开收缩更新标识
  RxBool isExpanded = false.obs;

  /// 子节点更新标识
  RxInt childrenUpdateFlag = 0.obs;

  /// 按钮动画控制器
  AnimationController iconController = AnimationController(vsync: SimpleTickerProvider());
  late Animation<double> iconAnimation = Tween<double>(begin: 0, end: 1).animate(iconController);

  /// 子节点动画控制器，用于进场和退场
  Map<String, AnimationController> childrenAnimationControllerMap = {};

  @override
  void onReady() {
    super.onReady();
    isExpanded.value = args.initExpanded;
  }

  /// 展开
  void expand() {
    isExpanded.value = true;
  }

  /// 收缩
  void collapse() {
    for (AnimationController controller in childrenAnimationControllerMap.values) {
      controller.reverse();
    }
    isExpanded.value = false;
  }

  /// 变换
  void turn() {
    if (isExpanded.value) {
      collapse();
    } else {
      expand();
    }
  }

  /// 重新构建子节点
  void setChildren(List<TreeNode<T>> children) {
    args.treeNode.children.clear();
    args.treeNode.children.addAll(children);
    childrenAnimationControllerMap.clear();
    childrenUpdateFlag++;
  }

  /// 添加子节点
  void addChild(TreeNode<T> child) {
    args.treeNode.children.add(child);
    childrenUpdateFlag++;
  }

  /// 移除子节点
  void removeChild(String key) async {
    await childrenAnimationControllerMap[key]?.reverse();
    childrenAnimationControllerMap.remove(key);
    args.treeNode.children.removeWhere((element) => element.key == key);
    childrenUpdateFlag++;
  }

  /// 重排序
  void onReorder(int oldIndex, int newIndex) {
    List<TreeNode<T>> children = args.treeNode.children;
    TreeNode<T> node = children.removeAt(oldIndex);
    children.insert(newIndex, node);
    childrenUpdateFlag++;
    args.onReorder?.call(oldIndex, newIndex, args.treeNode);
  }
}

/// 页面
class TreeNodeView<T> extends View<TreeNodeLogic<T>> {
  TreeNodeView({
    required String key,
    required TreeNodeArgs<T> args,
  }) : super(key: key, args: args, logic: TreeNodeLogic<T>());

  @override
  Widget buildView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 主节点
        Obx(() => buildNode(context)),
        // 子节点
        Obx(() => buildChildren(context)),
      ],
    );
  }

  /// 构建主节点
  Widget buildNode(BuildContext context) {
    logic.childrenUpdateFlag.value;
    List<TreeNode>? children = logic.args.treeNode.children;
    bool isLeaf = children.isEmpty;
    List<Widget> dividerList = [];
    // 垂直分割线
    for (int i = 0; i < logic.args.level; i++) {
      dividerList.add(SizedBox(
        width: logic.args.indent,
        child: logic.args.showVerticalDivider ? const VerticalDivider() : const SizedBox.shrink(),
      ));
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 垂直分割线
          ...dividerList,
          // 展开收缩按钮
          Container(
            padding: logic.args.padding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Obx(() => iconBuilder(context, isLeaf, logic.isExpanded.value))],
            ),
          ),
          // 节点内容
          Container(padding: logic.args.padding, child: logic.args.treeNode.content),
        ],
      ),
    );
  }

  /// 展开收缩按钮构建器
  Widget iconBuilder(BuildContext context, bool isLeaf, bool isExpanded) {
    // 按钮模式
    TreeNodeIconMode iconMode = logic.args.iconMode;
    ThemeData theme = AppLogic.instance.themeData;
    // 按钮色彩
    Color? color = iconMode == TreeNodeIconMode.disable && isLeaf ? theme.disabledColor : theme.textButtonTheme.style?.foregroundColor?.resolve({});
    // 按钮
    Widget iconButton = Clickable(
      onTap: iconMode == TreeNodeIconMode.disable && isLeaf ? () {} : logic.turn,
      tooltip: logic.isExpanded.value ? "收起" : "展开",
      child: IconTheme.merge(
        data: IconThemeData(color: color),
        child: AnimatedRotation(
          turns: logic.isExpanded.value ? 0 : -0.25,
          duration: logic.fastAnimationDuration,
          child: Icon(Icons.expand_more, size: logic.args.iconSize),
        ),
      ),
    );

    Widget child;
    switch (iconMode) {
      case TreeNodeIconMode.hidden:
        child = Opacity(
          opacity: isLeaf ? 0 : 1,
          child: SizedBox(width: logic.args.indent, child: isLeaf ? const SizedBox.shrink() : iconButton),
        );
        break;
      case TreeNodeIconMode.disable:
        child = SizedBox(width: logic.args.indent, child: iconButton);
        break;
      case TreeNodeIconMode.none:
        child = isLeaf ? const SizedBox.shrink() : SizedBox(width: logic.args.indent, child: iconButton);
        break;
    }

    if (isLeaf) {
      return AnimatedSwitcher(
        key: ValueKey("${logic.key}_icon"),
        duration: logic.fastAnimationDuration,
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

    return AnimatedSwitcher(
      key: ValueKey("${logic.key}_icon"),
      duration: logic.fastAnimationDuration,
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
    List<TreeNode<T>> children = logic.args.treeNode.children;
    bool isLeaf = children.isEmpty;
    if (!logic.isExpanded.value || isLeaf) {
      return AnimatedSwitcher(
        key: ValueKey("${logic.key}_children"),
        duration: logic.fastAnimationDuration,
        transitionBuilder: (child, animation) {
          return SizeTransition(sizeFactor: animation, axisAlignment: -1.0, child: child);
        },
        child: const SizedBox.shrink(),
      );
    }

    List<Widget> childrenWidget = [];
    for (TreeNode<T> node in children) {
      childrenWidget.add(Column(
        key: ValueKey(node.key),
        children: [
          buildSlideInLeft(
            node,
            TreeNodeView(
              key: node.key,
              args: TreeNodeArgs.fromNode(treeNode: node, treeNodeArgs: logic.args),
            ),
          ),
          if (node != children.last && logic.args.divider != null) Container(padding: EdgeInsets.only(left: logic.args.indent), child: logic.args.divider!),
        ],
      ));
    }

    Widget? divider;
    if (childrenWidget.isNotEmpty && logic.args.divider != null) {
      divider = Container(padding: EdgeInsets.only(left: logic.args.indent), child: logic.args.divider!);
    }
    return AnimatedSwitcher(
      key: ValueKey("${logic.key}_children"),
      duration: logic.fastAnimationDuration,
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
                  needsLongPressDraggable: DeviceInfoHelper.isMobile,
                  children: childrenWidget,
                ),
                const SizedBox(height: 12),
              ],
            ),
    );
  }

  Widget buildSlideInLeft(TreeNode<T> node, Widget child) {
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
    Future.delayed(Duration.zero, () => controller.forward());

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
