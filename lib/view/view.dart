import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hg_framework/ability/toast/overlay.dart';
import 'package:hg_framework/hg_framework.dart';
import 'package:hg_framework/hg_framework.dart' as framework;
import 'package:theme/theme.dart';

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

/// 只有参数没有数据源的逻辑
abstract class ViewLogicOnlyArgs<A extends ViewArgs> extends ViewLogic<A, ViewDataSource> {}

/// 只有数据源没有参数的逻辑
abstract class ViewLogicOnlyDataSource<D extends ViewDataSource> extends ViewLogic<ViewArgs, D> {}

/// 只有逻辑
abstract class ViewLogicOnly extends ViewLogic<ViewArgs, ViewDataSource> {}

/// 页面控制器
abstract class ViewLogic<A extends ViewArgs, D extends ViewDataSource> extends GetxController {
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

  set dataSource(D dataSource) => _dataSource = dataSource;

  set args(A args) => _args = args;

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
    afterArgsUpdate();
  }

  /// 新建组件的最后步骤
  void afterArgsUpdate() {}

  @mustCallSuper
  @override
  void onReady() {
    super.onReady();
    // 防止不同类型的组件key重复导致回调不正确
    String key = "${this.key}_$runtimeType";
    appLogic.listenRefresh(key, () => update());
    ThemeHelper().listenThemeUpdate(key, () => update());
    // appLogic.listenAppLifecycleUpdate(key, (lifecycle) => update());
    OrientationHelper().listenOrientationUpdate(key, (orientation) => update());
  }

  @mustCallSuper
  @override
  void onClose() {
    super.onClose();
    // 防止不同类型的组件key重复导致回调不正确
    String key = "${this.key}_$runtimeType";
    appLogic.removeRefreshListener(key);
    ThemeHelper().removeThemeUpdateListener(key);
    // appLogic.removeAppLifecycleListener(key);
    OrientationHelper().removeOrientationUpdateListener(key);
  }

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

  /// 当前应用数据
  ThemeData get theme => ThemeHelper().themeData;

  /// 当前应用模板
  ThemeTemplate get themeTemplate => ThemeHelper().themeTemplate;

  /// 应用配置
  AppConfig get appConfig => framework.appConfig;

  /// 动画配置
  AnimationConfig get animationConfig => appConfig.animationConfig;

  /// 中速动画时间
  Duration get middleAnimationDuration => animationConfig.middleAnimationDuration;

  /// 快速动画时间
  Duration get fastAnimationDuration => animationConfig.fastAnimationDuration;

  /// 慢速动画时间
  Duration get slowAnimationDuration => animationConfig.slowAnimationDuration;

  /// 是否正忙
  RxBool isBusy = false.obs;

  /// 显示加载框
  void showLoading({String? message, Widget? messageWidget, bool onlyDebug = false}) {
    isBusy.value = true;
    OverlayHelper().showLoading(
      runtimeType.toString(),
      message: messageWidget ?? (message == null ? null : Text(message)),
      onlyDebug: onlyDebug,
    );
  }

  /// 关闭加载框
  void closeLoading() {
    isBusy.value = false;
    OverlayHelper().closeLoading(runtimeType.toString());
  }
}

/// 页面组件
abstract class View<L extends ViewLogic> extends StatelessWidget {
  /// 逻辑控制器
  late final L logic;

  get args => logic.args;

  get dataSource => logic.dataSource;

  /// 构造
  View({required String key, required L logic, ViewArgs? args, ViewDataSource? dataSource}) : super(key: ValueKey("${key}_$L")) {
    this.logic = Get.put<L>(logic, tag: key);
    this.logic.onWidgetCreate(key: key, args: args, dataSource: dataSource, widget: this);
  }

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
        return Builder(builder: (context) {
          logic.onWidgetBuild(context);
          return buildViewWithTheme(context);
        });
      },
    );
  }

  Widget buildViewWithTheme(BuildContext context) {
    return Theme(data: logic.theme, child: buildView(context));
  }

  /// 构建页面
  Widget buildView(BuildContext context);

  /// 创建子组件key：$key_$type[_$uniqueKey]
  /// [type]子组件类型
  /// [uniqueKey]子组件多个的时候，传入唯一标识
  LocalKey getChildLocalKey(Type type, [String? uniqueKey]) => ValueKey(getChildKey(type, uniqueKey));

  GlobalKey getChildGlobalKey(Type type, [String? uniqueKey]) => GlobalObjectKey(getChildKey(type, uniqueKey));

  /// 创建子组件key，防止出现key冲突
  String getChildKey(Type type, [String? uniqueKey]) => "${key}_$type${null == uniqueKey ? "" : "_$uniqueKey"}";
}
