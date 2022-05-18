import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_logger/config.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/view/component/export.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/page/attribute/attribute_detail.dart';
import 'package:hg_logger/view/page/attribute/status/status_list.dart';
import 'package:hg_logger/view/page/attribute/tag/tag_detail.dart';
import 'package:hg_logger/view/page/event/card/card.dart';
import 'package:hg_orm/hg_orm.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../attribute/attribute_list.dart';

@immutable
class IntroductionArgs {
  final VoidCallback? onIntroEnd;

  const IntroductionArgs({this.onIntroEnd});
}

/// 逻辑
class IntroductionLogic extends GetxController {
  late String key;
  late IntroductionArgs args;

  Rx<int> activeIndex = 0.obs;

  onOpen() {
    activeIndex.value = 0;
  }

  void onIndexChanged(int index) {
    activeIndex.value = index;
  }

  void onIntroEnd() {
    args.onIntroEnd?.call();
  }
}

/// 页面
class IntroductionPage extends StatelessWidget {
  late final IntroductionLogic logic;

  IntroductionPage({required String key, required IntroductionArgs args}) : super(key: ValueKey(key)) {
    logic = Get.put<IntroductionLogic>(IntroductionLogic(), tag: key);
    logic.key = key;
    logic.args = args;
    logic.onOpen();
  }

  final PageDecoration pageDecoration = const PageDecoration(
    titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
    bodyTextStyle: TextStyle(fontSize: 19.0),
    bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
    imagePadding: EdgeInsets.zero,
  );

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IntroductionLogic>(
      init: logic,
      tag: logic.key,
      builder: (logic) {
        return buildContainer(context);
      },
    );
  }

  Widget buildContainer(BuildContext context) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Neumorphic(
      child: SafeArea(
        child: IntroductionScreen(
          key: ValueKey(logic.key),
          globalHeader: buildLogo(),
          rawPages: buildIntroPageList(),
          onDone: logic.onIntroEnd,
          showSkipButton: false,
          skipOrBackFlex: 0,
          nextFlex: 0,
          showBackButton: false,
          showDoneButton: false,
          showNextButton: false,
          dotsDecorator: DotsDecorator(
            size: const Size.square(8),
            color: themeData.disabledColor,
            activeSize: const Size.square(16),
            activeColor: themeData.accentColor,
            activeShape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25.0))),
          ),
          onChange: logic.onIndexChanged,
        ),
      ),
    );
  }

  /// 构建标识
  Widget buildLogo() {
    return Align(
      alignment: Alignment.topRight,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, right: 16),
          child: Obx(() {
            if (logic.activeIndex.value == 0 || logic.activeIndex.value == 6) return Container();
            return BounceInDown(
              child: Column(
                children: [
                  Transform.rotate(
                    angle: pi / 8,
                    child: NeumorphicIcon(Icons.add_task_outlined, size: 40, style: const NeumorphicStyle(color: Colors.red)),
                  ),
                  // 文字
                  HgNeumorphicText("事计"),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  /// 构建介绍页面
  List<Widget> buildIntroPageList() {
    return [
      freeIntro(),
      Container(padding: const EdgeInsets.only(top: 100), child: freeTiming()),
      Container(padding: const EdgeInsets.only(top: 100), child: freeStatus()),
      Container(padding: const EdgeInsets.only(top: 100), child: freeTag()),
      Container(padding: const EdgeInsets.only(top: 100), child: freeRelation()),
      Container(padding: const EdgeInsets.only(top: 100), child: freeTheme()),
      Container(padding: const EdgeInsets.only(top: 100), child: buildFinish()),
    ];
  }

  /// 总体介绍
  Widget freeIntro() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 图标
        Hero(
          tag: "logo",
          child: Column(
            children: [
              Transform.rotate(
                angle: pi / 8,
                child: NeumorphicIcon(Icons.add_task_outlined, size: 100, style: const NeumorphicStyle(color: Colors.red)),
              ),
              // 文字
              HgNeumorphicText("事计", size: 25),
            ],
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 25)),
        // 介绍
        HgNeumorphicText("可能是一个自由的事件计划与管理应用"),
      ],
    );
  }

  /// 自由时间
  Widget freeTiming() {
    DateTime now = DateTime.now();
    OriginEvent study = OriginEvent();
    study.name.value = "学习";
    study.timingList.value = [
      RepeatableTiming()
        ..start.value = DateTime(now.year, now.month, now.day, 9)
        ..end.value = DateTime(now.year, now.month, now.day, 11),
      RepeatableTiming()
        ..start.value = DateTime(now.year, now.month, now.day, 2)
        ..end.value = DateTime(now.year, now.month, now.day, 5),
    ];

    OriginEvent eat = OriginEvent();
    eat.name.value = "用餐";
    eat.timingList.value = [
      RepeatableTiming()
        ..start.value = DateTime(now.year, now.month, now.day, 11, 30)
        ..end.value = DateTime(now.year, now.month, now.day, 12, 30),
      RepeatableTiming()
        ..start.value = DateTime(now.year, now.month, now.day, 6)
        ..end.value = DateTime(now.year, now.month, now.day, 7),
    ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        HgNeumorphicText("自由的时间", size: 30),
        HgNeumorphicText("事件可设置多个不同的独立时间"),
        const Padding(padding: EdgeInsets.only(top: 80)),
        Expanded(
          child: Neumorphic(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.only(top: 12),
            style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.roundRect(const BorderRadius.vertical(top: Radius.circular(12))),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: EventCard<OriginEvent>(
                    key: study.id.value,
                    args: const EventCardArgs(state: PageState.browse, isIntro: true),
                    dataSource: EventCardDataSource(event: study, config: EventConfig()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: EventCard<OriginEvent>(
                    key: eat.id.value,
                    args: const EventCardArgs(state: PageState.browse, isIntro: true),
                    dataSource: EventCardDataSource(event: eat, config: EventConfig()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// 自由状态
  Widget freeStatus() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        HgNeumorphicText("自由的状态", size: 30),
        HgNeumorphicText("事件状态自定义，按照自己喜好为事件定义状态"),
        const Padding(padding: EdgeInsets.only(top: 80)),
        Expanded(
          child: Neumorphic(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.only(top: 12),
            style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.roundRect(const BorderRadius.vertical(top: Radius.circular(12))),
            ),
            child: StatusList(
              key: "${logic.key}_status_list",
              args: AttributeListArgs(navigatorId: AppConfig.rootNavigatorId, isIntro: true),
            ),
          ),
        ),
      ],
    );
  }

  /// 自由标签
  Widget freeTag() {
    // 当前时间
    FilterDateTime dateTime = FilterDateTime(type: FilterDateTimeTypeEnum.custom, customDate: DateTime.now());
    // 用tag做过滤和排序
    Tag filterTag = Tag()
      ..name.value = "今天的事件"
      ..content.value = "查看包含该标签或者发生时间在今天的事件"
      ..filter.value = GroupFilterValue(
        op: GroupFilterOp.or,
        filters: [
          // 1. 开始时间在今天
          SingleFilterValue(filter: SingleFilter.equals(field: EventFilterField.startTiming.value, value: dateTime)),
          // 2. 开始时间小于今天，结束时间大于等于今天
          GroupFilterValue(
            filters: [
              SingleFilterValue(filter: SingleFilter.lessThan(field: EventFilterField.startTiming.value, value: dateTime)),
              SingleFilterValue(filter: SingleFilter.greaterThanOrEquals(field: EventFilterField.endTiming.value, value: dateTime)),
            ],
          ),
        ],
      );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        HgNeumorphicText("自由的标签", size: 30),
        HgNeumorphicText("标签自带检索功能，设置自定义的检索条件可快速筛选"),
        const Padding(padding: EdgeInsets.only(top: 80)),
        Expanded(
          child: Neumorphic(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.roundRect(const BorderRadius.vertical(top: Radius.circular(12))),
            ),
            child: TagDetail(
              key: filterTag.id.value,
              args: AttributeDetailArgs(
                navigatorId: filterTag.id.value.hashCode,
                parentNavigatorId: 0,
                state: PageState.browse,
                isIntro: true,
              ),
              dataSource: AttributeDetailDataSource(data: filterTag),
            ),
          ),
        ),
      ],
    );
  }

  /// 自由的关系
  Widget freeRelation() {
    OriginEvent study = OriginEvent();
    study.name.value = "高等数学";
    OriginEvent study2 = OriginEvent();
    study2.name.value = "大学物理";
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        HgNeumorphicText("自由的关系", size: 30),
        HgNeumorphicText("事件可以新增子事件或关联现有事件"),
        const Padding(padding: EdgeInsets.only(top: 80)),
        Expanded(
          child: HgNeumorphicScaffold(
            bodyPadding: EdgeInsets.zero,
            body: Neumorphic(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.only(top: 12),
              style: NeumorphicStyle(
                boxShape: NeumorphicBoxShape.roundRect(const BorderRadius.vertical(top: Radius.circular(12))),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: NeumorphicToggle(
                      padding: EdgeInsets.zero,
                      selectedIndex: 1,
                      displayForegroundOnlyIfSelected: true,
                      children: [
                        buildToggleElement("事件内容"),
                        buildToggleElement("子事件"),
                        buildToggleElement("日程"),
                        buildToggleElement("状态历史"),
                      ],
                      thumb: Container(),
                      style: const NeumorphicToggleStyle(border: NeumorphicBorder()),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 12),
                    child: EventCard<OriginEvent>(
                      key: study.id.value,
                      args: const EventCardArgs(state: PageState.browse, isIntro: true),
                      dataSource: EventCardDataSource(event: study, config: EventConfig()),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 12),
                    child: EventCard<OriginEvent>(
                      key: study2.id.value,
                      args: const EventCardArgs(state: PageState.browse, isIntro: true),
                      dataSource: EventCardDataSource(event: study2, config: EventConfig()),
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: Container(
              padding: const EdgeInsets.only(right: 32, bottom: 12),
              child: buildChildAddButton(),
            ),
          ),
        ),
      ],
    );
  }

  /// 构建页签导航项
  ToggleElement buildToggleElement(String name) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return ToggleElement(
      background: Center(child: HgNeumorphicText(name, color: themeData.disabledColor)),
      foreground: Center(child: HgNeumorphicText(name, color: themeData.accentColor)),
    );
  }

  Widget buildChildAddButton() {
    String expandableFabKey = logic.key;
    // 展开动画按钮
    return ExpandableFab(
      key: expandableFabKey,
      args: ExpandableFabArgs(
        initOpen: true,
        children: [
          ActionButton(
            child: HgNeumorphicIcon(Icons.link),
            title: "关联",
            onPressed: () {},
          ),
          ActionButton(
            child: HgNeumorphicIcon(Icons.add),
            title: "新增",
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  /// 自由主题
  Widget freeTheme() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        HgNeumorphicText("自由的视觉", size: 30),
        HgNeumorphicText("新拟态主题，大部分主题元素可自定义设置"),
        const Padding(padding: EdgeInsets.only(top: 80)),
        Expanded(
          child: Neumorphic(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.only(top: 12),
            style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.roundRect(const BorderRadius.vertical(top: Radius.circular(12))),
            ),
            child: buildNeumorphicTemplate(),
          ),
        ),
      ],
    );
  }

  /// 内部内容
  Widget buildNeumorphicTemplate() {
    NeumorphicThemeTemplateData templateData = NeumorphicThemeTemplateData();
    List<Attribute> attributeList = [
      templateData.baseColor,
      templateData.shadowLightColor,
      templateData.shadowDarkColor,
      templateData.shadowLightColorEmboss,
      templateData.shadowDarkColorEmboss,
      templateData.borderColor,
      templateData.defaultTextColor,
      templateData.defaultIconColor,
      templateData.disabledColor,
      templateData.accentColor,
      templateData.depth,
      templateData.borderWidth,
      templateData.intensity
    ];

    List<StairedGridTile> pattern = [];
    for (Attribute attribute in attributeList) {
      StairedGridTile tile;
      if (attribute is IntegerAttribute) {
        tile = const StairedGridTile(0.5, 2);
      } else {
        tile = const StairedGridTile(1, 4);
      }
      pattern.add(tile);
    }

    return GridView.builder(
      padding: EdgeInsets.only(bottom: Get.height * 0.2),
      clipBehavior: Clip.none,
      itemCount: attributeList.length,
      gridDelegate: SliverStairedGridDelegate(
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
        pattern: pattern,
      ),
      itemBuilder: (context, index) {
        Attribute attribute = attributeList[index];
        Widget child;
        if (attribute is IntegerAttribute) {
          child = buildColor(attribute as Attribute<int>);
        } else {
          double min;
          double max;
          if (attribute.name == templateData.intensity.name) {
            min = 0;
            max = 1;
          } else {
            min = 0;
            max = 4;
          }
          child = buildDouble(attribute as Attribute<double>, min, max);
        }
        return Neumorphic(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(8),
          child: child,
        );
      },
    );
  }

  /// 构建颜色类型属性
  Widget buildColor(Attribute<int> attribute) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(attribute.title),
        Expanded(
          child: HgNeumorphicButton(
            margin: const EdgeInsets.only(top: 8),
            style: NeumorphicStyle(color: Color(attribute.value)),
            child: Container(),
            // 修改颜色
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  /// 构建浮点类型属性
  Widget buildDouble(Attribute<double> attribute, double min, double max) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${attribute.title} : ${attribute.value.toStringAsFixed(2)}"),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: NeumorphicSlider(
                  value: attribute.value,
                  min: min,
                  max: max,
                  style: SliderStyle(depth: themeData.depth),
                ),
              ),
              const Padding(padding: EdgeInsets.only(left: 8)),
            ],
          ),
        ),
      ],
    );
  }

  /// 结束页面
  Widget buildFinish() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElasticIn(
          child: Column(
            children: [
              Transform.rotate(
                angle: pi / 8,
                child: NeumorphicIcon(Icons.add_task_outlined, size: 100, style: const NeumorphicStyle(color: Colors.red)),
              ),
              HgNeumorphicText("事计", size: 25),
            ],
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 25)),
        // 介绍
        HgNeumorphicButton(
          child: HgNeumorphicText("自由使用"),
          onPressed: logic.onIntroEnd,
        )
      ],
    );
  }
}
