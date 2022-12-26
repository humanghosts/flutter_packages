import 'package:flutter/material.dart';
import 'package:hgs_framework/framework.dart';
import 'package:hgs_framework/framework.dart' as framework;

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

  /// 参数
  A get args => _args as A;

  /// 数据源
  D get dataSource => _dataSource as D;

  /// 当前绑定的组件
  View get widget => _widget;

  /// 设置数据源
  set dataSource(D dataSource) => _dataSource = dataSource;

  /// 设置参数
  set args(A args) => _args = args;

  /// 控制器标签
  String get tag => _key;

  /// 是否全局控制器,如果是全局控制器会先检查控制器是否注册，未注册会自动注册先
  /// [GetBuilderState.initState]
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
    appLogic.listenOnRebuild(listenerKey, onAppRebuild);
    themeConfig.addListener(listenerKey, onThemeUpdate);
    appLogic.listenAppLifecycleUpdate(listenerKey, onAppLifecycleUpdate);
  }

  /// 监听器key，加[runtimeType]是为了防止不同类型的组件key重复导致回调不正确
  String get listenerKey => "${key}_$runtimeType";

  /// 应用重建回调[onReady]
  void onAppRebuild() => update();

  /// 主题更新回调[onReady]
  void onThemeUpdate() => update();

  /// 应用生命周期变化回调[onReady]
  void onAppLifecycleUpdate(AppLifecycleState lifecycleState) => update();

  /// 调用地址[DisposableInterface.onInit]
  @mustCallSuper
  @override
  void onClose() {
    super.onClose();
    appLogic.removeRebuildListener(listenerKey);
    themeConfig.removeListener(listenerKey);
    appLogic.removeAppLifecycleListener(listenerKey);
  }

  /// [global]调用链
  /// [GetBuilderState.initState] (非global只需要这一步)
  /// [GetInstance.find]
  /// [GetInstance._initDependencies]
  /// [GetInstance._startController]
  @override
  InternalFinalCallback<void> get onStart => super.onStart;

  /// [DisposableInterface.onInit] 主要目的是渲染后调用[onReady]
  @override
  void onInit() => super.onInit();

  /// 调用链
  /// [GetBuilderState.dispose]
  /// [GetInstance.delete]
  @override
  InternalFinalCallback<void> get onDelete => super.onDelete;

  /// 组件构建回调[View.build]
  void onWidgetBuild(BuildContext context) {}

  /// GetStatefulWidget组件Stated的initState回调 调用地址[GetBuilderState.initState]
  /// 需要注意的是该方法是绑定组件，[onStart]或者[onInit]是绑定控制器，两者的生命周期不一样
  void onWidgetInitState(BuildContext context, GetBuilderState state) {}

  /// GetStatefulWidget组件Stated的didChangeDependencies回调 调用地址[GetBuilderState.didChangeDependencies]
  void onWidgetDidChangeDependencies(BuildContext context, GetBuilderState state) {}

  /// GetStatefulWidget组件Stated的didUpdateWidget回调 调用地址[GetBuilderState.didUpdateWidget]
  /// 调试时hot reload会调用
  void onWidgetDidUpdateWidget(BuildContext context, GetBuilder oldWidget, GetBuilderState state) {}

  /// GetStatefulWidget组件Stated的dispose回调 调用地址[GetBuilderState.dispose]
  /// 需要注意的是该方法是绑定组件，[onDelete]或[onClose]是绑定控制器，两者的生命周期不一样
  void onWidgetDispose(BuildContext context, GetBuilderState state) {}
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
    return Theme(data: themeConfig.themeData, child: buildView(context));
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
