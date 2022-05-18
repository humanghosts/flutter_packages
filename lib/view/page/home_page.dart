import 'package:animate_do/animate_do.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/main.dart';
import 'package:statusbarz/statusbarz.dart';

import '../export.dart';

/// 参数
@immutable
class HomePageArgs extends ViewArgs {
  /// 导航id
  final int navigatorId;

  const HomePageArgs({
    required this.navigatorId,
  });
}

/// 页面逻辑
abstract class HomePageLogic extends TutorialViewLogic<HomePageArgs, ViewDataSource> {
  /// 组件构建回调
  @override
  @mustCallSuper
  void onWidgetBuild(BuildContext context) {
    super.onWidgetBuild(context);
    // 刷新状态栏颜色
    Statusbarz.instance.refresh();
  }

  /// 页面是否可以退出
  Future<bool> canPagePop() async => true;

  /// 退出页面回调
  onPagePop() {}

  /// 应用生命周期回调
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  /// 屏幕方向改变回调
  void onDeviceOrientationChanged(DeviceOrientation deviceOrientation) {}

  @override
  void onWidgetDidUpdateWidget(BuildContext context, GetBuilder<GetxController> oldWidget, GetBuilderState<GetxController> state) {
    super.onWidgetDidUpdateWidget(context, oldWidget, state);
    if (isTutorial) onInitState(context);
  }

  /// 构建导航栏回调
  Widget buildDrawer({required bool isActive, required IconData iconData, required String title, required VoidCallback action}) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return HgNeumorphicButton(
      style: NeumorphicStyle(depth: isActive ? -themeData.depth : themeData.depth),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          HgNeumorphicIcon(iconData, size: 20),
          const Padding(padding: EdgeInsets.only(left: 8)),
          HgNeumorphicText(title),
        ],
      ),
      onPressed: action,
    );
  }

  /// 构建快速访问底栏
  Widget buildQuickaccess({required bool isActive, required IconData iconData, required String title, required VoidCallback action}) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    Widget text = HgNeumorphicText(
      title,
      style: NeumorphicStyle(color: isActive ? themeData.accentColor : themeData.disabledColor),
      size: 10,
    );
    Widget iconContainer;
    Widget textContainer;
    if (isActive) {
      iconContainer = BounceInDown(
        child: HgNeumorphicIcon(
          iconData,
          color: isActive ? themeData.accentColor : themeData.disabledColor,
          size: 30,
        ),
        from: 20,
      );
      textContainer = Container();
    } else {
      iconContainer = HgNeumorphicIcon(
        iconData,
        color: isActive ? themeData.accentColor : themeData.disabledColor,
        size: 20,
      );
      textContainer = SlideInUp(child: text, from: 20);
    }

    return SizedBox.expand(
      child: AspectRatio(
        aspectRatio: 1,
        child: HgNeumorphicButton(
          padding: EdgeInsets.zero,
          style: NeumorphicStyle(
            depth: isActive ? -themeData.depth : themeData.depth,
            border: NeumorphicBorder(width: isActive ? themeData.borderWidth : 0),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [iconContainer, textContainer]),
          onPressed: action,
        ),
      ),
    );
  }
}

/// 主页
abstract class HomePage<L extends HomePageLogic> extends View<L> {
  HomePage({
    required String key,
    required HomePageArgs args,
    required L newLogic,
  }) : super(key: key, newLogic: newLogic, args: args);
}
