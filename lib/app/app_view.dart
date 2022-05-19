import 'package:flutter/material.dart';

/// 主程序
class App extends StatelessWidget with WidgetsBindingObserver {
  MainLogic get logic => MainLogic.instance;

  const App({Key? key}) : super(key: key);

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
    ThemeData.from(colorScheme: colorScheme)
    
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
