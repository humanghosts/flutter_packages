import 'dart:math';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hg_logger/ability/route/route.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/service/services.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/export.dart';

@immutable
class TagPickerArgs extends ViewArgs {
  /// 导航id
  final int? navigatorId;

  /// 页面状态
  final PageState state;

  const TagPickerArgs({
    this.navigatorId,
    required this.state,
  });
}

@immutable
class TagPickerDataSource extends ViewDataSource {
  final Event event;

  const TagPickerDataSource({required this.event});
}

/// 逻辑
class TagPickerLogic extends ViewLogic<TagPickerArgs, TagPickerDataSource> {
  final TagService _tagService = TagService.instance;

  /// 查询所有标签
  Future<List<Tag>> findAllTag() async {
    return await _tagService.find();
  }

  /// 标签变化
  void setTag(List<Tag> tagList) {
    dataSource.event.tagList.value.clear();
    dataSource.event.tagList.addAll(tagList);
    update();
  }
}

/// 时间选择器
/// 分为开始时间和结束时间
class TagPicker extends View<TagPickerLogic> {
  TagPicker({
    required String key,
    required TagPickerArgs args,
    required TagPickerDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: TagPickerLogic());

  @override
  Widget buildView(BuildContext context) {
    Event event = logic.dataSource.event;
    Widget label;
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    double depth = min(1, themeData.depth);
    String tooltip = "";
    bool fullScreenTooltip;
    if (event.tagList.isNull) {
      label = Column(
        children: [
          // 图标
          Neumorphic(
            style: NeumorphicStyle(depth: depth),
            child: Logo(iconValue: IconValue.fontIcon(iconData: Icons.label, iconColor: Colors.black54, backgroundColor: Colors.white), size: 30),
          ),
          // 文字
          Container(
            width: 40,
            alignment: Alignment.center,
            child: Text(logic.dataSource.event.tagList.title, style: TextStyle(color: themeData.disabledColor)),
          ),
        ],
      );
      tooltip = logic.dataSource.event.tagList.title;
      fullScreenTooltip = false;
    } else {
      List<Widget> children = [];
      for (int i = 0; i < event.tagList.value.length; i++) {
        Tag tag = event.tagList.value[i];
        // 图标问题
        children.add(Column(
          children: [
            Neumorphic(style: NeumorphicStyle(depth: depth), child: Logo(iconValue: tag.icon.value, size: 30)),
            const Padding(padding: EdgeInsets.only(top: 2)),
            Container(alignment: Alignment.center, child: Text(tag.toString()), width: 50),
          ],
        ));
        tooltip += tag.toString();
        if (i != event.tagList.value.length - 1) {
          tooltip += " , ";
        }
      }
      label = Row(children: children);
      fullScreenTooltip = true;
    }
    return HgNeumorphicChip(
      label: label,
      getTooltip: () => tooltip,
      style: NeumorphicStyle(depth: fullScreenTooltip ? -themeData.depth : themeData.depth),
      fullScreenTooltip: fullScreenTooltip,
      onTap: toTagSelect,
    );
  }

  /// 打开标签选择
  void toTagSelect() async {
    // 浏览状态不可编辑
    if (logic.args.state == PageState.browse) return;
    // 当前事件
    Event event = logic.dataSource.event;
    // 查询所有的标签
    List<Tag> allTagList = await logic.findAllTag();
    // 已选的标签
    List<int> selected = [];
    for (Tag selectedTag in event.tagList.value) {
      // 通过id判断是否相等
      selected.add(allTagList.indexWhere((findTag) => selectedTag.id.value == findTag.id.value));
    }
    // 打开
    if (logic.args.navigatorId == null) {
      // 打开弹框
      RouteHelper.cupertinoBottomSheet(sheet: tagSelect(selected, allTagList));
    } else {
      // 打开 页面
      RouteHelper.to(page: tagSelect(selected, allTagList), id: logic.args.navigatorId);
    }
  }

  /// 标签选择页
  Widget tagSelect(List<int> selected, List<Tag> tagList) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return MultiSelect(
      key: "event_tag_select",
      args: MultiSelectArgs(
          title: "标签选择",
          isMulti: true,
          navigatorId: logic.args.navigatorId,
          itemCount: tagList.length,
          itemBuilder: (context, index, isSelect, action) {
            Tag model = tagList[index];
            // 名称
            Widget mainTitle = Text(model.toString());
            // 描述
            Widget? subTitle = model.content.isNull ? null : Text(model.content.value!, style: TextStyle(color: themeData.disabledColor));
            List<Widget> columnChildren = [mainTitle];
            if (null != subTitle) columnChildren.add(subTitle);
            // 图标
            Widget leading = Neumorphic(style: NeumorphicStyle(depth: -themeData.depth), child: Logo(iconValue: model.icon.value));
            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: leading,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: columnChildren,
              ),
            );
          },
          onBack: (List<int> indexList) {
            List<Tag> selectedTagList = indexList.map((e) => tagList[e]).toList();
            logic.setTag(selectedTagList);
          }),
      dataSource: MultiSelectDataSource(selected: selected),
    );
  }
}
