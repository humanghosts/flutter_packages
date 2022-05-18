import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hg_logger/entity/data/tag.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/view/export.dart';

/// 界面参数
@immutable
class TagRowItemArgs extends ViewArgs {
  /// 是否是被选中标签
  final bool isActive;

  /// 标签点击操作
  final VoidCallback? onTap;

  final bool canTap;
  final NeumorphicStyle? style;

  const TagRowItemArgs({
    this.isActive = false,
    this.onTap,
    this.canTap = true,
    this.style,
  });
}

/// 数据源
class TagRowItemDataSource extends ViewDataSource {
  /// 标签
  final Tag tag;

  const TagRowItemDataSource({required this.tag});
}

/// 组件逻辑操作
class TagRowItemLogic extends ViewLogic<TagRowItemArgs, TagRowItemDataSource> {}

class TagRowItem extends View<TagRowItemLogic> {
  TagRowItem({
    required String key,
    TagRowItemArgs? args,
    required TagRowItemDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: TagRowItemLogic());

  @override
  Widget buildView(BuildContext context) {
    return Column(
      children: [
        // 标签图标
        Expanded(
          flex: 1,
          child: logic.args.canTap ? buildCanTap() : buildCannotTap(),
        ),
        // 标签名称
        Expanded(
          flex: 0,
          child: Container(
            padding: const EdgeInsets.only(top: 4),
            alignment: Alignment.center,
            child: Text(logic.dataSource.tag.toString()),
          ),
        ),
      ],
    );
  }

  Widget buildCanTap() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;

    return HgNeumorphicButton(
      padding: EdgeInsets.zero,
      style: NeumorphicStyle(
        depth: logic.args.isActive ? -themeData.depth : themeData.depth,
        border: NeumorphicBorder(width: logic.args.isActive ? themeData.borderWidth : 0),
      ),
      child: Logo.expand(iconValue: logic.dataSource.tag.icon.value),
      onPressed: () => logic.args.onTap?.call(),
    );
  }

  Widget buildCannotTap() {
    return Neumorphic(
      padding: EdgeInsets.zero,
      style: logic.args.style,
      child: Logo.expand(iconValue: logic.dataSource.tag.icon.value),
    );
  }
}
