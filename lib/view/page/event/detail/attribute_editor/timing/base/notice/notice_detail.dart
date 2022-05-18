import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/config.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/view/export.dart';
import 'package:numberpicker/numberpicker.dart';

@immutable
class NoticeDetailArgs extends ViewArgs {
  /// 展示类型
  final List<NoticeType> showTypes;

  /// 返回回调
  final Function()? onBack;

  /// 导航ID
  final int? navigatorId;

  const NoticeDetailArgs({
    this.showTypes = const [NoticeType.before, NoticeType.fixed],
    this.onBack,
    this.navigatorId,
  });
}

@immutable
class NoticeDetailDataSource extends ViewDataSource {
  final Notice notice;

  const NoticeDetailDataSource({required this.notice});
}

class NoticeDetailLogic extends ViewLogic<NoticeDetailArgs, NoticeDetailDataSource> {
  /// 当前活跃的页面
  Rx<int> activeIndex = 0.obs;

  /// 记录这个参数的原因是，animateToPage会触发onPageChange，需要忽略
  bool isAnimateToPage = false;

  PageController pageController = PageController(initialPage: 0);

  /// 打开回调，重新设置初始页
  @override
  void afterArgsUpdate() {
    List<NoticeType> showTypes = args.showTypes;
    List<int> showTypeValues = showTypes.map((e) => e.value).toList();
    int noticeType = dataSource.notice.type.value;
    if (!showTypeValues.contains(noticeType)) {
      activeIndex.value = 0;
    } else {
      activeIndex.value = showTypeValues.indexOf(noticeType);
    }
    pageController = PageController(initialPage: activeIndex.value);
    if (pageController.positions.isNotEmpty) {
      pageController.jumpToPage(activeIndex.value);
    }
  }

  /// 返回
  void back() {
    RouteHelper.back(id: args.navigatorId);
  }

  /// 返回回调
  void onBack() {
    clearUnUse();
    args.onBack?.call();
  }

  /// 处理不需要的数据数据，
  void clearUnUse() {
    // 是否时提前提醒
    Notice notice = dataSource.notice;
    NoticeType type = args.showTypes[activeIndex.value];
    notice.type.value = type.value;
    if (type == NoticeType.before) {
      notice.fixedTime.clear();
    }
    if (type == NoticeType.fixed) {
      notice.days.clear();
      notice.hours.clear();
      notice.minutes.clear();
    }
  }

  /// 设置固定时间提醒
  void setFixedTime(DateTime dateTime) {
    dataSource.notice.fixedTime.value = dateTime;
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
class NoticeDetail extends View<NoticeDetailLogic> with ObserverWidget {
  NoticeDetail({
    required String key,
    NoticeDetailArgs? args,
    required NoticeDetailDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: NoticeDetailLogic());

  @override
  void observe(ObserverRouting? routing) {
    if (routing?.isBack == true) {
      logic.onBack();
    }
  }

  @override
  Widget buildView(BuildContext context) {
    Widget? title;
    Widget? trailing;
    if (logic.args.showTypes.length <= 1) {
      title = Text(logic.args.showTypes.first.name, style: const TextStyle(fontWeight: FontWeight.bold));
    } else {
      trailing = Expanded(child: Container(padding: const EdgeInsets.symmetric(horizontal: 12), child: buildTabBar()));
    }
    return HgNeumorphicScaffold(
      leading: HgNeumorphicBackButton(onPressed: logic.back),
      trailing: trailing,
      title: title,
      bodyPadding: EdgeInsets.zero,
      body: buildTabViews(),
    );
  }

  /// 构建导航栏
  Widget buildTabBar() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    List<ToggleElement> children = logic.args.showTypes.map((type) {
      return ToggleElement(
        background: Center(child: Text(type.name, style: TextStyle(color: themeData.disabledColor))),
        foreground: Center(child: Text(type.name, style: TextStyle(color: themeData.accentColor))),
      );
    }).toList();
    return Obx(() => NeumorphicToggle(
          padding: EdgeInsets.zero,
          selectedIndex: logic.activeIndex.value,
          displayForegroundOnlyIfSelected: true,
          children: children,
          thumb: Container(),
          style: const NeumorphicToggleStyle(border: NeumorphicBorder()),
          onChanged: logic.onIndexChanged,
        ));
  }

  /// 构建标签页
  Widget buildTabViews() {
    return PageView.builder(
      clipBehavior: Clip.none,
      itemBuilder: (context, index) {
        NoticeType type = logic.args.showTypes[index];
        Widget child = Container();
        if (type == NoticeType.before) child = buildBeforeTabBarView();
        if (type == NoticeType.fixed) child = buildFixedTabBarView();
        return Padding(padding: const EdgeInsets.all(12), child: child);
      },
      itemCount: logic.args.showTypes.length,
      controller: logic.pageController,
      onPageChanged: logic.onPageChanged,
    );
  }

  /// 构建提前提醒时间
  Widget buildBeforeTabBarView() {
    return _BeforeTimePicker(key: logic.dataSource.notice.hashCode.toString(), notice: logic.dataSource.notice);
  }

  /// 构建固定提醒时间
  Widget buildFixedTabBarView() {
    logic.dataSource.notice.fixedTime.value ??= DateTime.now();
    return DateTimePicker(
      key: "notice_time",
      args: DateTimePickerArgs(
        firstDate: DateTime.fromMillisecondsSinceEpoch(0),
        lastDate: DateTime(2050, 12, 31),
        initialDate: logic.dataSource.notice.fixedTime.value!,
        onDateTimeChanged: logic.setFixedTime,
      ),
    );
  }
}

/// 逻辑
class _BeforeTimePickerLogic extends ViewLogicOnly {
  Notice notice;

  _BeforeTimePickerLogic(this.notice);

  Rx<int> days = 0.obs;
  Rx<int> hours = 0.obs;
  Rx<int> minutes = 0.obs;

  /// 打开回调
  @override
  void afterArgsUpdate() {
    days.value = notice.days.value;
    hours.value = notice.hours.value;
    minutes.value = notice.minutes.value;
  }

  /// 设置天数
  void setDay(int value) {
    if (notice.days.value != value) {
      notice.days.value = value;
      days.value = notice.days.value;
    }
  }

  /// 设置小时数
  void setHour(int value) {
    if (notice.hours.value != value) {
      notice.hours.value = value;
      hours.value = notice.hours.value;
    }
  }

  /// 设置分钟数
  void setMinute(int value) {
    if (notice.minutes.value != value) {
      notice.minutes.value = value;
      minutes.value = notice.minutes.value;
    }
  }
}

/// 提前提醒
class _BeforeTimePicker extends View<_BeforeTimePickerLogic> {
  _BeforeTimePicker({required String key, required Notice notice})
      : super(
          key: key,
          newLogic: _BeforeTimePickerLogic(notice),
        );

  @override
  Widget buildView(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: Get.height * 0.5),
      clipBehavior: Clip.none,
      children: [
        buildNumberPicker(60, logic.days, logic.setDay, "天"),
        buildNumberPicker(23, logic.hours, logic.setHour, "小时"),
        buildNumberPicker(59, logic.minutes, logic.setMinute, "分钟"),
      ],
    );
  }

  Widget buildNumberPicker(int max, Rx<int> rxValue, Function(int value) onChanged, String title) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Neumorphic(
      margin: const EdgeInsets.symmetric(vertical: 8),
      style: NeumorphicStyle(depth: -themeData.depth),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Neumorphic(
            margin: const EdgeInsets.all(16),
            child: Obx(() => NumberPicker(
                  key: ValueKey(max),
                  minValue: 0,
                  maxValue: max,
                  itemCount: 5,
                  itemHeight: 80,
                  itemWidth: 40,
                  infiniteLoop: true,
                  value: rxValue.value,
                  onChanged: onChanged,
                  zeroPad: true,
                  axis: Axis.horizontal,
                  haptics: true,
                  selectedTextStyle: TextStyle(color: themeData.defaultTextColor, fontSize: 24, fontWeight: FontWeight.w500),
                  textStyle: TextStyle(color: themeData.disabledColor, fontSize: 12, fontWeight: FontWeight.w300),
                )),
          ),
          Text(title),
        ],
      ),
    );
  }
}
