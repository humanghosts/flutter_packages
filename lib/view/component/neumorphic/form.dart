import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/main.dart';

import 'button.dart';
import 'icon.dart';

class NeumorphicFormField extends StatelessWidget {
  final Widget? title;
  final String? initValue;
  final void Function()? onTap;
  final String? hintText;
  final void Function()? onClear;
  final Widget? child;
  final NeumorphicStyle? fieldStyle;
  final bool readOnly;
  final String? comment;
  final Widget? commentWidget;
  final bool noChild;
  final GlobalKey? commentKey;

  const NeumorphicFormField(
      {Key? key,
      this.title,
      this.initValue,
      this.onTap,
      this.hintText,
      this.onClear,
      this.child,
      this.fieldStyle,
      this.readOnly = false,
      this.comment,
      this.commentWidget,
      this.noChild = false,
      this.commentKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Neumorphic(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              title ?? Container(),
              buildComment(),
            ],
          ),
          Padding(padding: EdgeInsets.only(top: title == null ? 0 : 8)),
          noChild
              ? Container()
              : Neumorphic(
                  style: fieldStyle ?? NeumorphicStyle(depth: -themeData.depth),
                  child: buildChild(),
                ),
        ],
      ),
    );
  }

  Widget buildChild() {
    if (null != child) return child!;
    return Neumorphic(
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              key: ValueKey(hashCode),
              initialValue: initValue,
              onTap: readOnly ? null : onTap,
              maxLines: 1,
              decoration: InputDecoration(hintText: hintText),
              readOnly: true,
            ),
          ),
          (readOnly || onClear == null)
              ? Container()
              : HgNeumorphicButton(
                  padding: const EdgeInsets.all(4),
                  margin: const EdgeInsets.only(right: 16),
                  style: const NeumorphicStyle(boxShape: NeumorphicBoxShape.circle()),
                  child: HgNeumorphicIcon(Icons.clear),
                  onPressed: onClear,
                ),
        ],
      ),
    );
  }

  Widget buildComment() {
    if (null == comment && commentWidget == null) return Container();
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return GestureDetector(
      child: HgNeumorphicIcon(Icons.help, key: commentKey, color: themeData.disabledColor, size: 25),
      onTap: showTooltip,
    );
  }

  void showTooltip() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    HapticFeedback.lightImpact();
    RouteHelper.overlay(SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Center(
          child: commentWidget ??
              Text(
                comment!,
                style: TextStyle(
                  overflow: TextOverflow.visible,
                  color: themeData.defaultTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
        ),
      ),
    ));
  }
}
