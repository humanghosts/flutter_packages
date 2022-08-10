import 'package:flutter/material.dart';
import 'package:hg_framework/hg_framework.dart';

Widget buildContextMenuItem({
  Widget? icon,
  required Widget text,
}) {
  ThemeData theme = AppLogic.instance.themeData;
  return Material(
    color: Colors.transparent,
    child: ListTile(
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      leading: DeviceInfoHelper.isDesktop ? icon : null,
      title: text,
      trailing: DeviceInfoHelper.isDesktop ? null : icon,
      iconColor: theme.colorScheme.onPrimaryContainer,
      textColor: theme.colorScheme.onPrimaryContainer,
      minLeadingWidth: 0,
    ),
  );
}
