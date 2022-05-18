import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hg_logger/ability/route/route.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/view/export.dart';
import 'package:hg_logger/view/page/event/settings/settings_base.dart';
import 'package:hg_logger/view/page/event/settings/settings_tree.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'settings_detail.dart';

/// 外部参数
@immutable
class EventSettingsArgs extends ViewArgs {
  /// 导航id
  final int navigatorId;

  /// 上级导航id
  final int parentNavigatorId;

  /// 保存回调
  final Function(EventConfig config)? onDone;

  const EventSettingsArgs({
    required this.navigatorId,
    required this.parentNavigatorId,
    this.onDone,
  });
}

/// 外部数据源
@immutable
class EventSettingsDataSource extends ViewDataSource {
  final EventConfig config;

  const EventSettingsDataSource({required this.config});
}

/// 逻辑控制器
class EventSettingsLogic extends TutorialViewLogic<EventSettingsArgs, EventSettingsDataSource> {
  /// 返回按钮
  void back() {
    RouteHelper.back(id: args.parentNavigatorId);
  }

  /// 确定按钮
  void done() {
    args.onDone?.call(dataSource.config);
    RouteHelper.back(id: args.parentNavigatorId);
  }

  @override
  void buildTutorial() {
    buildAndAddTargetFocus(
      "settings_item",
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("分类设置项，\n点击可进入下一页面进行详细设置"),
        ),
      ],
    );
  }

  @override
  String? get tutorialSubKey => "settings";

  @override
  HomePages get homePage => HomePages.event;
}

/// 页面
class EventSettings extends View<EventSettingsLogic> {
  EventSettings({
    required String key,
    required EventSettingsArgs args,
    required EventSettingsDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: EventSettingsLogic());

  @override
  Widget buildView(BuildContext context) {
    return HgNeumorphicScaffold(
      leading: HgNeumorphicBackButton(onPressed: logic.back),
      trailing: HgNeumorphicDoneButton(onPressed: logic.done),
      title: HgNeumorphicText("事件设置"),
      body: buildSettings(),
    );
  }

  Widget buildSettings() {
    return Column(
      children: [
        HgNeumorphicButton(
          key: logic.addTutorialTargetKey(0, "settings_item"),
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("事件列表设置"),
              HgNeumorphicNextButton(onPressed: toTreeSettings),
            ],
          ),
          onPressed: toTreeSettings,
        ),
        HgNeumorphicButton(
          margin: const EdgeInsets.only(top: 16),
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("事件详细设置"),
              HgNeumorphicNextButton(onPressed: toDetailSettings),
            ],
          ),
          onPressed: toDetailSettings,
        ),
      ],
    );
  }

  /// 打开列表设置
  void toTreeSettings() {
    RouteHelper.to(
      id: logic.args.navigatorId,
      page: EventTreeSettings(
        key: "event_tree_settings",
        args: EventSettingsBuilderArgs(navigatorId: logic.args.navigatorId),
        dataSource: EventSettingsBuilderDataSource(config: logic.dataSource.config),
      ),
    );
  }

  /// 打开详情设置
  void toDetailSettings() {
    RouteHelper.to(
      id: logic.args.navigatorId,
      page: EventDetailSettings(
        key: "event_detail_settings",
        args: EventSettingsBuilderArgs(navigatorId: logic.args.navigatorId),
        dataSource: EventSettingsBuilderDataSource(config: logic.dataSource.config),
      ),
    );
  }
}
