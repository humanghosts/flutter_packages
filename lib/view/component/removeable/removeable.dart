import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hg_logger/ability/route/route.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/view/component/export.dart';

/// 列表项
@immutable
class Removeable extends StatelessWidget {
  final Widget child;
  final VoidCallback? onRemove;
  final String text;
  final bool Function()? isShowHint;
  final String? groupTag;

  Removeable({
    required String key,
    required this.child,
    this.groupTag,
    this.onRemove,
    this.text = "确定删除吗?",
    this.isShowHint,
  }) : super(key: ValueKey(key));

  @override
  Widget build(BuildContext context) {
    List<Widget> actions = buildActions();
    ActionPane? endActionPane;
    if (actions.isNotEmpty) {
      endActionPane = ActionPane(
        dismissible: DismissiblePane(
          closeOnCancel: true,
          onDismissed: () => onRemove?.call(),
          confirmDismiss: () async {
            HapticFeedback.lightImpact();
            bool isShow = isShowHint?.call() ?? true;
            if (!isShow) return true;
            bool? canRemove = await RouteHelper.showOneChoiceRequest(msg: text);
            return canRemove == true;
          },
        ),
        extentRatio: 0.25,
        motion: const ScrollMotion(),
        children: actions,
      );
    }
    return Slidable(
      key: key,
      closeOnScroll: true,
      child: child,
      groupTag: groupTag,
      endActionPane: endActionPane,
    );
  }

  /// 删除按钮
  List<Widget> buildActions() {
    if (onRemove == null) return [];
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return [
      Expanded(
        child: SizedBox.expand(
          child: HgNeumorphicButton(
            child: Center(child: HgNeumorphicIcon(Icons.delete_forever, color: Colors.white)),
            style: NeumorphicStyle(
              depth: -themeData.depth,
              color: Colors.red,
              boxShape: const NeumorphicBoxShape.rect(),
            ),
            onPressed: () async {
              bool isShow = isShowHint?.call() ?? true;
              if (isShow) {
                bool? canRemove = await RouteHelper.showOneChoiceRequest(msg: text);
                if (canRemove != true) return;
              }
              onRemove?.call();
            },
          ),
        ),
      ),
    ];
  }
}
