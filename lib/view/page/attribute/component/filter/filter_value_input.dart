import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/view/export.dart';
import 'package:hg_orm/hg_orm.dart';

@immutable
class FilterValueInputEditorArgs extends ViewArgs {}

@immutable
class FilterValueInputEditorDataSource extends ViewDataSource {
  final SingleFilter singleFilter;

  const FilterValueInputEditorDataSource({required this.singleFilter});
}

class FilterValueInputEditorLogic extends ViewLogic<FilterValueInputEditorArgs, FilterValueInputEditorDataSource> {
  /// 设置文本类型的值
  void setText(String text) {
    dataSource.singleFilter.clear();
    if (text.isEmpty) return;
    dataSource.singleFilter.append(text);
  }
}

/// 输入类型的值
class FilterValueInputEditor extends View<FilterValueInputEditorLogic> {
  FilterValueInputEditor({
    required String key,
    required FilterValueInputEditorArgs args,
    required FilterValueInputEditorDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: FilterValueInputEditorLogic());

  @override
  Widget buildView(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 12, bottom: Get.width * 0.5),
      clipBehavior: Clip.none,
      children: [buildInputValue()],
    );
  }

  /// 普通输入框
  Widget buildInputValue() {
    SingleFilter singleFilter = logic.dataSource.singleFilter;
    // 初始字符串，如果是新增为空，显示placeholder，否则显示名称
    String? initText = singleFilter.value.isEmpty ? null : singleFilter.value.first.toString();
    // 返回名称录入组件
    return NeumorphicFormField(
      title: const Text("文本类型", style: TextStyle(fontWeight: FontWeight.bold)),
      child: TextFormField(
        initialValue: initText,
        decoration: const InputDecoration(hintText: "请输入过滤值"),
        minLines: 1,
        maxLines: 10,
        onChanged: logic.setText,
      ),
    );
  }
}
