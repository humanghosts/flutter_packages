import 'package:flutter/material.dart';
import 'package:hg_framework/hg_framework.dart';

Widget buildContextMenuItem({
  Widget? icon,
  required Widget text,
}) {
  ThemeData theme = AppLogic.instance.themeData;
  return IconTheme(
    data: theme.iconTheme.copyWith(color: theme.colorScheme.onPrimaryContainer, size: 18),
    child: DefaultTextStyle(
      style: TextStyle(color: theme.colorScheme.onPrimaryContainer),
      child: Row(
        mainAxisAlignment: DeviceInfoHelper.isDesktop ? MainAxisAlignment.start : MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: DeviceInfoHelper.isDesktop
            ? [
                if (icon != null) icon,
                if (icon != null) const SizedBox(width: 6),
                text,
              ]
            : [
                const Spacer(),
                if (icon != null) Expanded(child: icon),
                // if (icon != null) const SizedBox(width: 12),
                Expanded(child: text),
                const Spacer(),
              ],
      ),
    ),
  );
}
