import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_logger/ability/route/observer.dart';
import 'package:hg_logger/ability/route/route.dart';
import 'package:hg_logger/config.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/util/datetime_util.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/export.dart';

@immutable
class TimingDetailArgs extends ViewArgs {
  /// 导航id
  final int? navigatorId;

  /// 页面状态
  final PageState state;

  /// 返回调用
  final VoidCallback? onBack;

  const TimingDetailArgs({
    this.navigatorId,
    required this.state,
    this.onBack,
  });
}

@immutable
class TimingDetailDataSource<M extends Timing> extends ViewDataSource {
  final M timing;

  const TimingDetailDataSource({required this.timing});
}

class TimingDetailLogic<M extends Timing> extends ViewLogic<TimingDetailArgs, TimingDetailDataSource<M>> {
  /// tab控制器
  PageController pageController = PageController(initialPage: 0);

  /// 当前活跃的页面
  Rx<int> activeIndex = 0.obs;

  /// 记录这个参数的原因是，animateToPage会触发onPageChange，需要忽略
  bool isAnimateToPage = false;

  /// 获取时间
  M get timing => dataSource.timing;

  /// 打开调用
  @override
  void afterArgsUpdate() {
    // 判断是时间点还是时间段
    DateTime? start = timing.start.value;
    DateTime? end = timing.end.value;
    List<Notice> startNotice = timing.startNotice.value;
    List<Notice> endNotice = timing.endNotice.value;
    // 时间为空 或者 开始与结束时间相等且没有结束提醒，说明是时间点
    if (timing.isNull || (DateTimeUtil.compare(start, end) == 0 && endNotice.isEmpty)) {
      activeIndex.value = 0;
    } else {
      // 如果两个提醒长度不等，说明是自定义的
      if (startNotice.length != endNotice.length) {
        activeIndex.value = 2;
      }
      // 长度相等 比较内容是否相同 时间段的提醒应该一模一样
      else {
        bool isAllEquals = true;
        for (int i = 0; i < startNotice.length; i++) {
          Notice oneStart = startNotice[i];
          Notice oneEnd = endNotice[i];
          isAllEquals = oneStart.uniqueCode == oneEnd.uniqueCode;
          if (!isAllEquals) break;
        }
        if (isAllEquals) {
          activeIndex.value = 1;
        } else {
          activeIndex.value = 2;
        }
      }
    }
    pageController = PageController(initialPage: activeIndex.value);
  }

  /// 返回
  void back() {
    RouteHelper.back(id: args.navigatorId);
  }

  /// 页面返回时调用
  void onBack() {
    clearIllegal();
    args.onBack?.call();
  }

  /// 清空 非法情况的时间
  /// 没有时间清空提醒
  /// 没有时间清空重复
  void clearIllegal() {
    Attribute<DateTime?> start = timing.start;
    Attribute<DateTime?> end = timing.end;
    ModelListAttribute<Notice> startNotice = timing.startNotice;
    ModelListAttribute<Notice> endNotice = timing.endNotice;
    // 无时间有提醒 清空提醒
    if (start.isNull) startNotice.clear();
    if (end.isNull) endNotice.clear();
  }

  /// tab bar切换，控制tab view
  void onIndexChanged(int value) async {
    if (value == activeIndex.value) return;
    activeIndex.value = value;
    if (pageController.positions.isEmpty) return;
    HapticFeedback.lightImpact();
    isAnimateToPage = true;
    await pageController.animateToPage(
      activeIndex.value,
      duration: AppConfig.animationConfig.middleAnimationDuration,
      curve: Curves.linear,
    );
    isAnimateToPage = false;
  }

  /// tab view切换，更新控制tab bar
  void onPageChanged(int value) {
    if (isAnimateToPage) return;
    activeIndex.value = value;
    HapticFeedback.lightImpact();
  }
}

/// 时间详情弹框
abstract class TimingDetail<M extends Timing, L extends TimingDetailLogic<M>> extends View<L> with ObserverWidget {
  TimingDetail({
    required String key,
    required TimingDetailArgs args,
    required TimingDetailDataSource<M> dataSource,
    required L newLogic,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: newLogic);

  @override
  void observe(ObserverRouting? routing) {
    if (routing?.isBack == true) {
      logic.onBack();
    }
  }

  @override
  Widget buildView(BuildContext context) {
    return HgNeumorphicScaffold(
      leading: HgNeumorphicBackButton(onPressed: logic.back),
      trailing: Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: buildTabBar(),
        ),
      ),
      bodyPadding: EdgeInsets.zero,
      body: buildTabView(),
    );
  }

  /// 构建页签
  Widget buildTabBar() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    List<ToggleElement> children = ["时间", "时间段", "自定义"].map((name) {
      return ToggleElement(
        background: Center(child: HgNeumorphicText(name, color: themeData.disabledColor)),
        foreground: Center(child: HgNeumorphicText(name, color: themeData.accentColor)),
      );
    }).toList();
    return Obx(
      () => NeumorphicToggle(
        padding: EdgeInsets.zero,
        selectedIndex: logic.activeIndex.value,
        displayForegroundOnlyIfSelected: true,
        children: children,
        thumb: Container(),
        style: const NeumorphicToggleStyle(border: NeumorphicBorder()),
        onChanged: logic.onIndexChanged,
      ),
    );
  }

  /// 构建标签页区域
  Widget buildTabView() {
    return PageView.builder(
      clipBehavior: Clip.none,
      controller: logic.pageController,
      onPageChanged: logic.onPageChanged,
      itemCount: 3,
      itemBuilder: (context, index) {
        Widget child = Container();
        if (index == 0) child = buildTime();
        if (index == 1) child = buildPeriod();
        if (index == 2) child = buildCustom();
        return Padding(padding: const EdgeInsets.all(12), child: child);
      },
    );
  }

  /// 构建时间
  Widget buildTime();

  /// 构建时间段
  Widget buildPeriod();

  /// 构建自定义时间
  Widget buildCustom();
}
