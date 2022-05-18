import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/service/services.dart';
import 'package:hg_logger/view/export.dart';
import 'package:hg_orm/hg_orm.dart';

@immutable
class FilterValueModelEditorArgs extends ViewArgs {}

@immutable
class FilterValueModelEditorDataSource extends ViewDataSource {
  final SingleFilter singleFilter;

  const FilterValueModelEditorDataSource({required this.singleFilter});
}

class FilterValueModelEditorLogic extends ViewLogic<FilterValueModelEditorArgs, FilterValueModelEditorDataSource> {
  /// 模型服务
  final TagService _tagService = TagService.instance;
  final StatusService _statusService = StatusService.instance;
  final PriorityService _priorityService = PriorityService.instance;

  /// 可选模型列表
  final List<EventAttribute> modelList = [];

  /// 每次退出会重新构建，所以类似于onOpen的操作，没什么问题
  @override
  void onReady() {
    super.onReady();
    findAllByFiled(dataSource.singleFilter.field);
  }

  void findAllByFiled(String field) async {
    List<EventAttribute>? resultList;
    modelList.clear();
    if (field == EventFilterField.tag.value) {
      resultList = await _tagService.find();
    } else if (field == EventFilterField.status.value) {
      resultList = await _statusService.find();
    } else if (field == EventFilterField.priority.value) {
      resultList = await _priorityService.find();
    }
    if (null != resultList) {
      modelList.addAll(resultList);
    }
    update();
  }

  /// 选择或取消选择
  void select(int index, bool isSelect) {
    EventAttribute eventAttribute = modelList[index];
    if (dataSource.singleFilter.value.isEmpty) {
      if (isSelect) {
        dataSource.singleFilter.append([eventAttribute]);
      }
    } else {
      List<EventAttribute> selectList = dataSource.singleFilter.get(0);
      if (isSelect) {
        selectList.add(eventAttribute);
      } else {
        selectList.removeWhere((e) => e.id.value == eventAttribute.id.value);
        if (selectList.isEmpty) {
          dataSource.singleFilter.clear();
        }
      }
    }
  }
}

class FilterValueModelEditor extends View<FilterValueModelEditorLogic> {
  /// 同一个页面内只可能生成一个，不会相互影响，所以可以不用给key
  FilterValueModelEditor({
    required String key,
    required FilterValueModelEditorArgs args,
    required FilterValueModelEditorDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: FilterValueModelEditorLogic());

  @override
  Widget buildView(BuildContext context) {
    SingleFilter singleFilter = logic.dataSource.singleFilter;
    List<int> selected = [];
    if (singleFilter.value.isNotEmpty) {
      List<EventAttribute> valueList = singleFilter.get(0);
      for (EventAttribute value in valueList) {
        int index = logic.modelList.indexWhere((e) => e.id.value == value.id.value);
        selected.add(index);
      }
    }
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return MultiSelect(
      key: "filter_value_modelList",
      args: MultiSelectArgs(
        isMulti: true,
        mode: MultiSelectMode.widget,
        itemCount: logic.modelList.length,
        itemBuilder: (context, index, isSelect, action) {
          EventAttribute model = logic.modelList[index];
          // 名称
          Widget mainTitle = Text(model.toString());
          // 描述
          Widget? subTitle = model.content.isNull ? null : Text(model.content.value!, style: TextStyle(color: themeData.disabledColor));
          List<Widget> columnChildren = [mainTitle];
          if (null != subTitle) columnChildren.add(subTitle);
          // 图标
          Widget leading = Neumorphic(child: Logo(iconValue: model.icon.value));
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
        onSelect: (index) => logic.select(index, true),
        onUnSelect: (index) => logic.select(index, false),
      ),
      dataSource: MultiSelectDataSource(
        selected: selected,
      ),
    );
  }
}
