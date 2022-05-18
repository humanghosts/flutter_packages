import 'dart:collection';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/config.dart';
import 'package:hg_logger/main.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'page/home_pages.dart';

/// 页面外部参数
@immutable
class ViewArgs {
  const ViewArgs();
}

/// 页面外部数据源
@immutable
class ViewDataSource {
  const ViewDataSource();
}

abstract class ViewLogicOnlyArgs<A extends ViewArgs> extends ViewLogic<A, ViewDataSource> {}

abstract class ViewLogicOnlyDataSource<D extends ViewDataSource> extends ViewLogic<ViewArgs, D> {}

abstract class ViewLogicOnly extends ViewLogic<ViewArgs, ViewDataSource> {}

/// 页面控制器
abstract class ViewLogic<A extends ViewArgs, D extends ViewDataSource> extends GetxController with OverlayHelper {
  /// 控制器的key
  late String _key;

  /// 控制器的外部参数
  late ViewArgs _args;

  /// 控制器的外部数据源
  late ViewDataSource _dataSource;

  /// 当前绑定的组件
  late View _widget;

  String get key => _key;

  A get args => _args as A;

  D get dataSource => _dataSource as D;

  View get widget => _widget;

  /// 控制器标签
  String get tag => _key;

  /// 是否全局控制器,如果是全局控制器会先检查控制器是否注册，未注册会自动注册先
  bool get global => true;

  /// 是否自动移除，如果自动移除，组件dispose的时候会删除这个控制器
  bool get autoRemove => true;

  /// 是否注册id,作用基本同[autoRemove]
  bool get assignId => false;

  /// 新建组件回调，可以用来更新参数
  void onWidgetCreate({required String key, ViewArgs? args, ViewDataSource? dataSource, required View widget}) {
    _key = key;
    _args = args ?? const ViewArgs();
    _dataSource = dataSource ?? const ViewDataSource();
    _widget = widget;
  }

  /// 新建组件的最后步骤
  void afterArgsUpdate() {}

  /// 组件构建回调
  void onWidgetBuild(BuildContext context) {}

  /// GetStatefulWidget组件Stated的initState回调 等效于
  /// 需要注意的是该方法是绑定组件，[onStart]或者[onInit]是绑定控制器，两者的生命周期不一样
  void onWidgetInitState(BuildContext context, GetBuilderState state) {}

  /// GetStatefulWidget组件Stated的didChangeDependencies回调
  void onWidgetDidChangeDependencies(BuildContext context, GetBuilderState state) {}

  /// GetStatefulWidget组件Stated的didUpdateWidget回调
  /// 调试时hot reload会调用
  void onWidgetDidUpdateWidget(BuildContext context, GetBuilder oldWidget, GetBuilderState state) {}

  /// GetStatefulWidget组件Stated的dispose回调
  /// 需要注意的是该方法是绑定组件，[onDelete]或[onClose]是绑定控制器，两者的生命周期不一样
  void onWidgetDispose(BuildContext context, GetBuilderState state) {}
}

/// 页面组件
abstract class View<L extends ViewLogic> extends StatelessWidget {
  /// 逻辑控制器
  late final L logic;

  /// 构造
  View({required String key, required L newLogic, ViewArgs? args, ViewDataSource? dataSource}) : super(key: ValueKey("${key}_$L")) {
    logic = Get.put<L>(newLogic, tag: key);
    logic.onWidgetCreate(key: key, args: args, dataSource: dataSource, widget: this);
    logic.afterArgsUpdate();
  }

  /// 创建组件key
  LocalKey getWidgetKey(Type type, [String? uniqueKey]) => ValueKey("${key}_$L${null == uniqueKey ? "" : "_$uniqueKey"}");

  @override
  Widget build(BuildContext context) {
    return GetBuilder<L>(
      init: logic,
      tag: logic.key,
      global: logic.global,
      autoRemove: logic.autoRemove,
      assignId: logic.assignId,
      initState: (state) => logic.onWidgetInitState(context, state),
      didChangeDependencies: (state) => logic.onWidgetDidChangeDependencies(context, state),
      didUpdateWidget: (oldWidget, state) => logic.onWidgetDidUpdateWidget(context, oldWidget, state),
      dispose: (state) => logic.onWidgetDispose(context, state),
      builder: (logic) {
        logic.onWidgetBuild(context);
        return buildView(context);
      },
    );
  }

  /// 构建页面
  Widget buildView(BuildContext context);
}

abstract class TutorialViewLogicOnlyArgs<A extends ViewArgs> extends TutorialViewLogic<A, ViewDataSource> {}

abstract class TutorialViewLogicOnlyDataSource<D extends ViewDataSource> extends TutorialViewLogic<ViewArgs, D> {}

abstract class TutorialViewLogicOnly extends TutorialViewLogic<ViewArgs, ViewDataSource> {}

/// 引导页扩展逻辑
///
/// 使用用户引导的步骤
///
/// 1. 页面logic继承[TutorialViewLogic]
///
/// 2. 实现[homePage]、[buildTutorial]方法 如果是子页面实现[tutorialSubKey]方法
///
/// 4. 调试过程放开[onWidgetDidUpdateWidget]并注释[onWidgetInitState]，可以通过hot reload重新显示指导页
///
/// 5. 正式过程放开[onWidgetInitState]并注释[onWidgetDidUpdateWidget]，这样只有第一次构建会显示指导页
///
/// 6. 如果想要指导完不关闭指导页注释[_onTutorialFinish]方法中的调用[TutorialHelper]的代码
///
/// 7. 父子组件的引导顺序是构建顺序，会根据构建顺序在[queuedTutorial]中排队，等待上一个引导完成
///
/// 8. 在组件内部需要引导的组件上使用[addTutorialTargetKey]为组件添加全局唯一的key
///
/// 9. 在logic的[buildTutorial]方法中调用[buildAndAddTargetFocus]通过key为指定组件添加引导
///
/// 10. 可通过重写[isTutorial]方法手动控制是否显示引导页，但用完记得删除调
abstract class TutorialViewLogic<A extends ViewArgs, D extends ViewDataSource> extends ViewLogic<A, D> {
  /// 引导key int是顺序
  final Map<int, String> tutorialIndex = {};

  /// 引导key
  final Map<String, GlobalObjectKey> tutorialKey = {};

  /// 引导组件
  final Map<String, TargetFocus> tutorialTargetFocus = {};

  /// 正是用  页面initState回调
  @override
  @mustCallSuper
  void onWidgetInitState(BuildContext context, GetBuilderState state) {
    super.onWidgetInitState(context, state);
    // 是否显示引导
    if (isTutorial) onInitState(context);
  }

  static OverlayEntry? tutorialLoader;
  static OverlayEntry? tutorialBackground;

  static void showTutorialOverlay() {
    if (null == tutorialLoader) {
      RouteHelper.overlayBuilder(
        (overlayLoader, overlayBackground) {
          tutorialLoader = overlayLoader;
          tutorialBackground = overlayBackground;
          return GestureDetector(
            child: Container(color: Colors.transparent),
            onTap: closeTutorialOverlay,
          );
        },
        opacity: 0,
      );
    }
  }

  static void closeTutorialOverlay() {
    if (tutorialLoader?.mounted ?? false) {
      tutorialLoader?.remove();
      tutorialLoader = null;
    }
    if (tutorialBackground?.mounted ?? false) {
      tutorialBackground?.remove();
      tutorialBackground = null;
    }
  }

  /// 打开时回调
  void onInitState(BuildContext context) {
    // 构建完成之后显示引导
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      showTutorialOverlay();
      Future.delayed(AppConfig.animationConfig.slowAnimationDuration, () {
        tutorialTargetFocus.clear();
        buildTutorial();
        if (tutorialIndex.isEmpty) return closeTutorialOverlay();
        List<int> keyOrder = tutorialIndex.keys.toList();
        keyOrder.sort((a, b) => a - b);
        List<TargetFocus> targets = [];
        for (var order in keyOrder) {
          String keyStr = tutorialIndex[order]!;
          TargetFocus? targetFocus = tutorialTargetFocus[keyStr];
          if (null == targetFocus) continue;
          targets.add(targetFocus);
        }
        if (targets.isEmpty) return closeTutorialOverlay();

        showTutorial(context, targets, homePage, tutorialSubKey);
      });
    });
  }

  /// 设置引导目标组件的key
  ///
  /// [index]是引导显示顺序
  ///
  /// [key]是当前homepage和subKey下的组件唯一标识
  ///
  /// [newKey]决定是否使用新的GlobalKey，默认是false，防止组件一致重复init
  ///
  /// [GlobalObjectKey]的[==]使用[identical]去比较两个value是否相同，
  /// 所以即使是相同的string变量，但是指向的对象不一样，所以还是会生成新的组件。
  ///
  /// 因此为了防止每次都生成新的组件，有必要复用之前的GlobalObjectKey对象
  /// 这里GlobalObjectKey也可以用GlobalKey替换，没有区别(没有试过，理论上没区别，都是key的复用)
  GlobalObjectKey? addTutorialTargetKey(int index, String key, [bool newKey = false]) {
    // 如果不引导不给key，防止同时打开多个相同页面global key冲突
    if (!isTutorial) return null;
    tutorialIndex[index] = key;
    GlobalObjectKey globalKey;
    if (newKey) {
      globalKey = newGlobalKey(key);
      tutorialKey[key] = globalKey;
    } else {
      globalKey = tutorialKey.putIfAbsent(key, () => newGlobalKey(key));
    }
    return globalKey;
  }

  /// 生成组件key 用homepage和subKey保证全局唯一
  /// [key]是[addTutorialTargetKey]的参数
  GlobalObjectKey newGlobalKey(String key) {
    return GlobalObjectKey("${homePage.value}_${tutorialSubKey == null ? "" : "${tutorialSubKey}_"}$key");
  }

  /// 获取组件key
  /// [key]是[addTutorialTargetKey]的参数
  GlobalObjectKey? getTutorialTargetKey(String key) {
    return tutorialKey[key];
  }

  /// 添加指导组件
  TutorialViewLogic addTutorialTargetFocus(String key, TargetFocus targetFocus) {
    tutorialTargetFocus[key] = targetFocus;
    return this;
  }

  /// 构建并添加指导
  TutorialViewLogic buildAndAddTargetFocus(
    String key, {
    TargetPosition? targetPosition,
    // 内容
    List<TargetContent>? contents,
    // 高亮地区的形状
    ShapeLightFocus? shape,
    // 曲率
    double? radius,
    // 边框
    BorderSide? borderSide,
    // 蒙版颜色
    Color? color,
    bool enableOverlayTab = true,
    bool enableTargetTab = true,
    // 跳过按钮的位置
    AlignmentGeometry? alignSkip,
    double? paddingFocus,
    Duration? focusAnimationDuration,
    Tween<double>? pulseVariation,
  }) {
    NeumorphicThemeData neumorphicThemeData = MainLogic.instance.neumorphicThemeData;
    TargetPosition? realTargetPosition = getTargetPosition(key, targetPosition);
    Color textColor = neumorphicThemeData.defaultTextColor;
    Color backgroundColor = Color.fromRGBO(255 - textColor.red, 255 - textColor.green, 255 - textColor.blue, 1);
    if (null == realTargetPosition) return this;
    return addTutorialTargetFocus(
      key,
      TargetFocus(
        identify: key,
        alignSkip: alignSkip,
        targetPosition: realTargetPosition,
        contents: contents,
        shape: shape ?? ShapeLightFocus.RRect,
        radius: radius ?? 12,
        borderSide: borderSide,
        color: color ?? backgroundColor,
        enableOverlayTab: enableOverlayTab,
        enableTargetTab: enableTargetTab,
        paddingFocus: paddingFocus ?? 0,
        focusAnimationDuration: focusAnimationDuration ?? AppConfig.animationConfig.middleAnimationDuration,
        pulseVariation: pulseVariation,
      ),
    );
  }

  /// copy from tutorial_coach_mark 插件自带的的方法不太适合
  /// 不支持sliver，modal的组件位置也有问题
  TargetPosition? getTargetPosition(String key, TargetPosition? customPosition) {
    if (null != customPosition) return customPosition;
    try {
      GlobalObjectKey? globalKey = getTutorialTargetKey(key);
      if (null == globalKey) throw Exception("$key组件未注册");
      RenderObject? renderObject = globalKey.currentContext!.findRenderObject();
      if (null == renderObject) return null;
      if (renderObject is RenderBox) {
        final size = renderObject.size;
        Offset offset = renderObject.localToGlobal(Offset.zero);
        return TargetPosition(size, offset);
      }
      if (renderObject is RenderSliver) {
        final size = renderObject.getAbsoluteSize();
        Offset offset = MatrixUtils.transformPoint(renderObject.getTransformTo(null), Offset.zero);
        return TargetPosition(size, offset);
      }
      throw Exception("组件类型未识别");
    } catch (e) {
      LogHelper.wtf(e);
      return null;
    }
  }

  /// 构建指导项
  void buildTutorial();

  /// 是否显示构建项
  bool get isTutorial => !TutorialHelper.getForceCloseAll() && TutorialHelper.getIsTutorial(homePage, tutorialSubKey);

  /// 子key
  String? get tutorialSubKey => null;

  /// 属于哪个主页
  HomePages get homePage;

  // --- 用户指导排队，为了解决多个指导同时显示的问题

  /// 当前正在显示的指导
  static TutorialCoachMark? currentCoachMark;

  /// 等待显示的指导 因为可能需要经常添加或删除元素，最好使用ListQueue
  static ListQueue<TutorialQueuedNode> queuedTutorial = ListQueue();

  /// 显示用户指导
  static void showTutorial(BuildContext context, List<TargetFocus> targets, HomePages homePage, [String? subKey]) {
    TutorialCoachMark tutorialCoachMark = TutorialCoachMark(
      context,
      targets: targets,
      hideSkip: true,
      paddingFocus: 0,
      opacityShadow: 0.8,
      onFinish: () => _onTutorialFinish(homePage, subKey),
      onClickTarget: (target) {
        HapticFeedback.lightImpact();
      },
      onClickOverlay: (target) {
        HapticFeedback.lightImpact();
      },
      onSkip: () => debugPrint("skip"),
    );
    if (currentCoachMark != null) {
      queuedTutorial.add(TutorialQueuedNode(tutorialCoachMark: tutorialCoachMark, homePage: homePage, subKey: subKey));
      return;
    }
    currentCoachMark = tutorialCoachMark;
    tutorialCoachMark.show(rootOverlay: true);
  }

  /// 指导完成回调
  static void _onTutorialFinish(HomePages homePage, [String? subKey]) async {
    closeTutorialOverlay();
    await TutorialHelper.setIsTutorial(homePage, false, subKey);
    if (queuedTutorial.isEmpty) {
      currentCoachMark = null;
      return;
    }
    TutorialQueuedNode? queuedNode;
    // 取出第一个要显示的指导
    while (queuedTutorial.isNotEmpty) {
      TutorialQueuedNode firstNode = queuedTutorial.removeFirst();
      bool isShow = _isTutorial(firstNode.homePage, firstNode.subKey);
      if (isShow) {
        queuedNode = firstNode;
        break;
      }
    }
    if (queuedNode != null) {
      currentCoachMark = queuedNode.tutorialCoachMark;
      queuedNode.tutorialCoachMark.show(rootOverlay: true);
    }
  }

  /// 是否显示指导
  static bool _isTutorial(HomePages homePage, [String? subKey]) => !TutorialHelper.getForceCloseAll() && TutorialHelper.getIsTutorial(homePage, subKey);
}

class TutorialQueuedNode {
  final TutorialCoachMark tutorialCoachMark;
  final HomePages homePage;
  final String? subKey;

  const TutorialQueuedNode({
    required this.tutorialCoachMark,
    required this.homePage,
    this.subKey,
  });
}

class OverlayHelper {
  OverlayEntry? loader;
  OverlayEntry? background;
  bool isOverlay = false;

  /// 打开弹框
  void showOverlay() {
    if (isOverlay) return;
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    isOverlay = true;
    RouteHelper.overlayBuilder((loader, background) {
      this.loader = loader;
      this.background = background;
      if (!isOverlay) closeOverlay();
      return Scaffold(
        backgroundColor: themeData.baseColor.withOpacity(0.5),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: overlayContent,
        ),
      );
    });
  }

  /// 弹框内容
  List<Widget> get overlayContent {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return [
      SpinKitCircle(color: themeData.defaultTextColor),
      const Text("自动备份中"),
    ];
  }

  /// 关闭弹框
  void closeOverlay() {
    if (!isOverlay) return;
    loader?.remove();
    background?.remove();
    loader = null;
    background = null;
    isOverlay = false;
  }
}
