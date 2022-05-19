import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:orientation/orientation.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:statusbarz/statusbarz.dart';

import 'ability/export.dart';
import 'config.dart';
import 'entity/entities.dart';
import 'init/init.dart';
import 'service/services.dart';
import 'view/export.dart';

/// 入口方法
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 设置允许的屏幕方向
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runZonedGuarded(
    () async {
      await init();
      await MainLogic.instance.findThemeConfig();
      runApp(const Main());
    },
    (error, stackTrace) {
      LogHelper.wtf(error.toString(), error: error, stackTrace: stackTrace);
    },
    zoneSpecification: const ZoneSpecification(),
  );
}

/// 主页控制器
class MainLogic extends GetxController with PageBuilder, OrientationListener, ThemeListener, AppLifecycleListener, OverlayHelper {
  MainLogic._();

  static MainLogic get instance => Get.put<MainLogic>(MainLogic._());

  /// 路由id
  final int navigatorId = AppConfig.rootNavigatorId;

  /// 应用构建完回调
  final Map<String, VoidCallback> _onReadyCallback = {};

  /// 注册构建完回调
  void registerReadyCallback(String key, VoidCallback callback) => _onReadyCallback[key] = callback;

  /// 应用构建时调用
  void onWidgetBuild(BuildContext context) {
    initThemeListener();
    initOrientationListener();
    isShowIntro.value = SharedPreferencesHelper.prefs.getBool(SharedPreferencesKeys.isShowIntro) ?? true;
  }

  @override
  onReady() {
    for (var value in _onReadyCallback.values) {
      value();
    }
  }

  @override
  onClose() {
    closeOrientationListener();
  }

  /// 根据页面重新渲染
  @override
  void pageChangedReRender() => update();

  /// 重新根据主题渲染
  @override
  void themeChangedReRender() => update();

  /// 生命周期改变回调
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    HomePageLogic? pageLogic = activeLogic;
    pageLogic?.didChangeAppLifecycleState(state);
  }

  /// 屏幕方向改变监听
  @override
  void onDeviceOrientationChanged(DeviceOrientation deviceOrientation) {
    activeLogic?.onDeviceOrientationChanged(deviceOrientation);
  }

  /// 是否显示介绍页
  Rx<bool> isShowIntro = true.obs;

  /// 介绍页关闭调用
  void onIntroEnd() async {
    SharedPreferencesHelper.prefs.setBool(SharedPreferencesKeys.isShowIntro, false);
    isShowIntro.value = false;
  }

  /// 蒙版更新标识
  Rx<int> overlayUpdateFlag = 0.obs;

  @override
  void onOverlayReRender() {
    overlayUpdateFlag.value++;
  }
}

/// 主程序
class Main extends StatelessWidget with WidgetsBindingObserver {
  MainLogic get logic => MainLogic.instance;

  const Main({Key? key}) : super(key: key);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    logic.didChangeAppLifecycleState(state);
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    log("didChangePlatformBrightness:${Get.mediaQuery.platformBrightness}");
    logic.didChangePlatformBrightness();
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);
    log("didChangeLocales");
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainLogic>(
      init: logic,
      autoRemove: false,
      initState: (state) {
        WidgetsBinding.instance?.addObserver(this);
      },
      dispose: (state) {
        WidgetsBinding.instance?.removeObserver(this);
      },
      builder: (logic) {
        logic.onWidgetBuild(context);
        return buildWithTheme();
      },
    );
  }

  /// 包装主题
  Widget buildWithTheme() {
    ThemeConfig config = logic.themeConfig;
    Brightness brightness = logic.brightness;
    ThemeTemplate template;
    if (brightness == Brightness.light) {
      template = config.light.value;
    } else {
      template = config.dark.value;
    }
    ThemeDataValue themeDataValue = template.data.value;
    if (themeDataValue.isNull) return buildWithApp();
    // 在这里添加新的主题类型
    if (themeDataValue.themeType == ThemeType.neumorphic) return buildWithNeumorphic(themeDataValue);
    return buildWithApp();
  }

  /// 包装新拟态主题
  Widget buildWithNeumorphic(ThemeDataValue themeDataValue) {
    NeumorphicThemeTemplateData templateData = themeDataValue.themeData as NeumorphicThemeTemplateData;
    NeumorphicThemeData neumorphicThemeData = templateData.toNeumorphicThemeData();
    ThemeData themeData = templateData.toThemeData(brightness: logic.brightness);
    return NeumorphicTheme(
      theme: neumorphicThemeData,
      darkTheme: neumorphicThemeData,
      child: buildWithApp(light: themeData, dark: themeData),
    );
  }

  /// 包装app
  Widget buildWithApp({ThemeData? light, ThemeData? dark}) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConfig.appName,
      theme: light,
      darkTheme: dark,
      themeMode: ThemeMode.system,
      navigatorObservers: [
        Observer(RouteHelper.observer, ObserverRouting()),
        Statusbarz.instance.observer,
      ],
      home: buildHomeOrIntro(),
      locale: const Locale('zh', 'CN'),
      supportedLocales: const <Locale>[Locale('zh', 'CN')],
      localizationsDelegates: const [
        // 本地化的代理类
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }

  /// 是否构建应用介绍页面
  Widget buildHomeOrIntro() {
    return Obx(() {
      bool isShowIntro = logic.isShowIntro.value;
      if (isShowIntro) {
        return IntroductionPage(key: 'intro', args: IntroductionArgs(onIntroEnd: logic.onIntroEnd));
      } else {
        return buildHomeWithWillScope();
      }
    });
  }

  /// 包装will_scope+navigator
  Widget buildHomeWithWillScope() {
    return Stack(
      children: [
        WillPopScope(
          child: Navigator(
            key: Get.nestedKey(AppConfig.rootNavigatorId),
            onGenerateRoute: (routeSettings) {
              return MaterialWithModalsPageRoute(builder: (context) => Neumorphic(child: buildHome()), settings: routeSettings);
            },
          ),
          onWillPop: () async => false,
        ),
        buildOverlay(),
      ],
    );
  }

  /// 构建主页
  Widget buildHome() {
    NeumorphicThemeData themeData = logic.neumorphicThemeData;
    return RefreshConfiguration(
      headerBuilder: () {
        return WaterDropHeader(
          refresh: SpinKitCircle(color: themeData.disabledColor),
          waterDropColor: themeData.disabledColor,
          complete: HgNeumorphicIcon(Icons.done, color: themeData.disabledColor),
        );
      },
      enableScrollWhenRefreshCompleted: true,
      child: Scrollable(
        physics: const PageScrollPhysics(parent: ClampingScrollPhysics()),
        controller: logic._controller,
        axisDirection: AxisDirection.right,
        viewportBuilder: (BuildContext context, ViewportOffset position) {
          return Viewport(
            axisDirection: AxisDirection.right,
            offset: position,
            clipBehavior: Clip.hardEdge,
            slivers: <Widget>[
              // 抽屉导航
              SliverFillViewport(
                viewportFraction: 0.5,
                padEnds: false,
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return buildDrawer();
                  },
                  childCount: 1,
                ),
              ),
              // 主页页面
              SliverFillViewport(
                viewportFraction: 1,
                padEnds: false,
                delegate: SliverChildListDelegate([buildPage()]),
              ),
            ],
          );
        },
      ),
    );
  }

  /// 构建蒙版
  Widget buildOverlay() {
    return Obx(() {
      debugPrint("蒙版更新次数${logic.overlayUpdateFlag.value}");
      Map<int, Set<String>> indexOverlay = logic.indexOverlay;
      if (indexOverlay.isEmpty) return Container();
      // stack子组件
      List<Widget> children = [];
      // 蒙版顺讯
      List<int> indexList = indexOverlay.keys.toList();
      indexList.sort();
      for (int index in indexList) {
        Set<String>? overlayKeySet = indexOverlay[index];
        if (null == overlayKeySet || overlayKeySet.isEmpty) continue;
        for (String overlayKey in overlayKeySet) {
          Widget? overlayWidget = logic.overlayWidget[overlayKey];
          if (null == overlayWidget) continue;
          children.add(overlayWidget);
        }
      }
      if (children.isEmpty) return Container();
      return Stack(children: children);
    });
  }

  /// 构建导航
  Widget buildDrawer() {
    List<Widget> children = [];
    for (HomePages page in HomePages.list) {
      children.add(buildDrawerItem(page));
    }
    children.insert(children.length - 1, const Spacer());
    return Neumorphic(child: SafeArea(child: Column(children: children)));
  }

  /// 构建具体导航项
  Widget buildDrawerItem(HomePages page) {
    String value = page.value;
    String current = logic.activePage;
    bool isActive = value == current;
    HomePageLogic? homePageLogic = logic.getPageLogic(value);
    if (null == homePageLogic) return Container();
    return homePageLogic.buildDrawer(
      isActive: isActive,
      iconData: page.iconData,
      title: page.title,
      action: () => logic.setActivePage(value),
    );
  }

  /// 构建具体页面
  Widget buildPage() {
    HomePages homePage = HomePages.map[logic.activePage]!;
    return homePage.build(navigatorId: AppConfig.rootNavigatorId);
  }
}

/// 屏幕方向监听器
abstract class OrientationListener {
  // --- 屏幕方向 ---
  /// 当前屏幕方向 使用这个参数的原因是，当应用禁用左右旋转之后，mediaQuery的方向九不会变化了
  /// 这个参数即使是锁定旋转也可以生效
  DeviceOrientation? deviceOrientation;

  /// 屏幕方向监听订阅
  StreamSubscription<DeviceOrientation>? _subscription;

  /// 初始化
  void initOrientationListener() {
    _subscription = OrientationPlugin.onOrientationChange.listen((value) {
      deviceOrientation = value;
    });
  }

  /// 关闭
  void closeOrientationListener() {
    _subscription?.cancel();
  }

  /// 监听屏幕方向
  void listenDeviceOrientation(DeviceOrientation deviceOrientation) {
    if (this.deviceOrientation != deviceOrientation) {
      this.deviceOrientation = deviceOrientation;
      onDeviceOrientationChanged(deviceOrientation);
    }
  }

  /// 屏幕方向改变回调
  void onDeviceOrientationChanged(DeviceOrientation deviceOrientation);
}

/// 主题监听器
abstract class ThemeListener {
  /// 主题服务
  ThemeConfigService themeConfigService = ThemeConfigService.instance;

  /// 主题配置
  ThemeConfig themeConfig = ThemeConfig();

  /// 系统亮度
  Brightness brightness = Brightness.light;

  /// 获取当前的新拟态主题
  NeumorphicThemeData get neumorphicThemeData => NeumorphicTheme.currentTheme(Get.context!);

  void initThemeListener() {
    brightness = window.platformBrightness;
    updateTheme(themeConfig);
  }

  /// 查询主题配置
  Future<void> findThemeConfig() async {
    themeConfig = await themeConfigService.find();
  }

  /// 更新主题
  void updateTheme(ThemeConfig themeConfig) {
    this.themeConfig = themeConfig;
    themeChangedReRender();
  }

  /// 重新构建
  Future<void> rebuild() async {
    await findThemeConfig();
    themeChangedReRender();
  }

  /// 重新根据主题渲染
  void themeChangedReRender();

  /// 系统亮度调整 用于WidgetsBindingObserver的方法调用
  void didChangePlatformBrightness() {
    Brightness brightness = Get.mediaQuery.platformBrightness;
    if (this.brightness == brightness) return;
    this.brightness = brightness;
    log("brightness changed");
    themeChangedReRender();
  }
}

/// 应用生命周期监听器
abstract class AppLifecycleListener {
  /// 当前app状态
  AppLifecycleState appLifecycleState = AppLifecycleState.resumed;

  /// 生命周期改变回调
  @mustCallSuper
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log("didChangeAppLifecycleState:$state");
    appLifecycleState = state;
  }
}

abstract class PageBuilder {
  /// 滑动控制器，用来显示drawer
  final ScrollController _controller = ScrollController(initialScrollOffset: Get.width * 0.5);

  /// 当前活跃页面
  String _activePage = HomePages.quickaccess.value;

  /// 获取当前活跃页面
  String get activePage => _activePage;

  /// 当前活跃页面的逻辑控制器
  HomePageLogic? get activeLogic => HomePages.map[activePage]!.getLogic();

  /// 获取固定的页面逻辑控制器
  HomePageLogic? getPageLogic(String page) => HomePages.map[page]!.getLogic();

  /// 切换活跃页面
  void setActivePage(String value) async {
    String current = Get.currentRoute;
    if (value == current || value == activePage) {
      closeDrawer();
      return;
    }
    HomePageLogic? pageLogic = activeLogic;
    if (null != pageLogic) {
      bool canPop = await pageLogic.canPagePop();
      if (!canPop) {
        closeDrawer();
        return;
      }
      pageLogic.onPagePop();
    }
    _activePage = value;
    closeDrawer();
    pageChangedReRender();
  }

  /// 页面改变重新渲染
  void pageChangedReRender();

  /// 打开菜单抽屉
  void openDrawer() {
    if (_controller.positions.isNotEmpty) {
      _controller.animateTo(
        0,
        duration: AppConfig.animationConfig.fastAnimationDuration,
        curve: Curves.linear,
      );
    }
  }

  /// 关闭菜单抽屉
  void closeDrawer() {
    if (_controller.positions.isNotEmpty) {
      _controller.animateTo(
        Get.width * 0.5,
        duration: AppConfig.animationConfig.middleAnimationDuration,
        curve: Curves.linear,
      );
    }
  }
}

/// 蒙版助手
abstract class OverlayHelper {
  /// 蒙版组件
  Map<String, Widget> overlayWidget = {};

  /// 蒙版顺序
  Map<int, Set<String>> indexOverlay = {};

  /// 蒙版顺序
  Map<String, int> overlayIndex = {};

  /// 显示蒙版 index越高越靠上
  void showOverlay({required String key, int index = 0, required Widget widget}) {
    overlayWidget[key] = widget;
    indexOverlay.putIfAbsent(index, () => {}).add(key);
    overlayIndex[key] = index;
    onOverlayReRender();
  }

  /// 关闭蒙版
  void closeOverlay(String key) {
    int? index = overlayIndex[key];
    if (null != index) indexOverlay.putIfAbsent(index, () => {}).remove(key);
    overlayWidget.remove(key);
    overlayIndex.remove(key);
    onOverlayReRender();
  }

  /// 蒙版修改渲染
  void onOverlayReRender();
}
