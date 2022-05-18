import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/route/route.dart';
import 'package:hg_logger/entity/data/event_attribute.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/export.dart';
import 'package:hg_logger/view/page/attribute/component/logo_picker.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

/// 参数
@immutable
class AttributeDetailArgs<M extends EventAttribute> extends ViewArgs {
  /// 点击确定操作
  final Function(M newModel)? onDone;

  /// 页面状态
  final PageState state;

  /// 子路由的id
  final int navigatorId;

  /// 上级路由id，用于返回
  final int parentNavigatorId;

  /// 是否启用，作用于介绍页 介绍页为false
  final bool isIntro;

  const AttributeDetailArgs({
    this.onDone,
    required this.state,
    required this.navigatorId,
    required this.parentNavigatorId,
    this.isIntro = false,
  });
}

/// 数据
@immutable
class AttributeDetailDataSource<M extends EventAttribute> extends ViewDataSource {
  final M data;

  const AttributeDetailDataSource({required this.data});
}

/// 逻辑
class AttributeDetailLogic<M extends EventAttribute> extends TutorialViewLogic<AttributeDetailArgs<M>, AttributeDetailDataSource<M>> {
  /// 返回
  void back() {
    RouteHelper.back(id: args.parentNavigatorId);
  }

  /// 确定
  void done() {
    args.onDone?.call(dataSource.data);
    back();
  }

  /// 设置名称
  void setName(String name) {
    dataSource.data.name.value = name;
  }

  /// 设置描述
  void setContent(String content) {
    dataSource.data.content.value = content;
  }

  @override
  HomePages get homePage => HomePages.attribute;

  @override
  void buildTutorial() {
    buildAndAddTargetFocus(
      "logo_and_name",
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("${(widget as AttributeDetail).title}图标与名称设置"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "logo",
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("${(widget as AttributeDetail).title}图标，\n点击后进入图标选择页面"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "name",
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("${(widget as AttributeDetail).title}名称，\n点击可录入"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "content",
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("${(widget as AttributeDetail).title}描述，\n点击可录入属性详细信息"),
        ),
      ],
    );
  }
}

/// 属性详情页面
abstract class AttributeDetail<M extends EventAttribute, L extends AttributeDetailLogic<M>> extends View<L> {
  AttributeDetail({
    required String key,
    required AttributeDetailArgs<M> args,
    required AttributeDetailDataSource<M> dataSource,
    required L newLogic,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: newLogic);

  /// 不同属性特有的内容
  List<Widget> get content;

  /// 页面标题
  String get title;

  @override
  Widget buildView(BuildContext context) {
    return HgNeumorphicScaffold(
      resizeToAvoidBottomInset: true,
      leading: HgNeumorphicBackButton(onPressed: logic.back),
      trailing: buildDoneAction(),
      title: HgNeumorphicText("$title${getPageStatesName(logic.args.state)}"),
      body: ListView(
        clipBehavior: Clip.none,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(bottom: Get.width * 0.5),
        children: [
          buildNameLogo(),
          const Padding(padding: EdgeInsets.only(bottom: 16)),
          buildContent(),
          const Padding(padding: EdgeInsets.only(bottom: 16)),
          ...content,
        ],
      ),
    );
  }

  /// 构建确认按钮,浏览时不显示
  Widget buildDoneAction() {
    if (logic.args.state == PageState.browse) return Container();
    return HgNeumorphicDoneButton(onPressed: logic.done);
  }

  /// 构建图标名称
  Widget buildNameLogo() {
    return NeumorphicFormField(
      key: logic.addTutorialTargetKey(0, "logo_and_name"),
      title: const Text("图标&名称", style: TextStyle(fontWeight: FontWeight.bold)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [buildName(), buildLogo()],
        ),
      ),
    );
  }

  /// 标签图标
  Widget buildLogo() {
    return HgNeumorphicButton(
      key: logic.addTutorialTargetKey(2, "logo"),
      padding: EdgeInsets.zero,
      child: Logo(iconValue: logic.dataSource.data.icon.value),
      onPressed: toLogoSelect,
    );
  }

  /// 前往选择图标页面
  void toLogoSelect() {
    // 浏览状态不可编辑
    if (logic.args.state == PageState.browse) return;
    M data = logic.dataSource.data;
    RouteHelper.to(
      page: LogoPicker(
        key: data.id.value,
        args: LogoPickerArgs(navigatorId: logic.args.navigatorId, onBack: logic.update),
        dataSource: LogoPickerDataSource(iconValue: data.icon.value),
      ),
      id: logic.args.navigatorId,
    );
  }

  /// 名称
  Widget buildName() {
    M data = logic.dataSource.data;
    // 初始字符串，如果是新增为空，显示placeholder，否则显示名称
    PageState state = logic.args.state;
    String? initText = state == PageState.add ? null : data.name.value;
    bool autoFocus = state == PageState.add && !logic.isTutorial;
    bool readOnly = state == PageState.browse;
    // 返回名称录入组件
    return TextFormField(
      key: logic.addTutorialTargetKey(1, "name"),
      initialValue: initText,
      readOnly: readOnly,
      autofocus: autoFocus,
      decoration: InputDecoration(
        hintText: data.name.comment,
        // 错开图标的距离
        contentPadding: const EdgeInsets.only(left: 50),
      ),
      maxLines: 1,
      onChanged: logic.setName,
    );
  }

  /// 标签描述
  Widget buildContent() {
    M data = logic.dataSource.data;
    bool readOnly = logic.args.state == PageState.browse;
    return NeumorphicFormField(
      key: logic.addTutorialTargetKey(3, "content"),
      title: Text(data.content.title, style: const TextStyle(fontWeight: FontWeight.bold)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: TextFormField(
          readOnly: readOnly,
          initialValue: data.content.value,
          decoration: InputDecoration(hintText: data.content.comment),
          minLines: 1,
          maxLines: 10,
          onChanged: logic.setContent,
        ),
      ),
    );
  }
}
