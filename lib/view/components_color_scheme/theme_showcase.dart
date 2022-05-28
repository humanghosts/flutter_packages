import 'package:flutter/material.dart';

import 'switch_list_tile_adaptive.dart';

/// Theme showcase for the current theme.
///
/// Use this widget to review your theme's impact on [ThemeData] and see
/// how it looks with different Material widgets.
///
/// The sub widgets used in this theme show case can also be used on their
/// own, for example combined in smaller panels instead of in on big column
/// like here. Using the individual elements is done in example 5 where they
/// are put in separate cards.
///
/// These are all Flutter "Universal" Widgets that only depends on the SDK and
/// all the Widgets in this file be dropped into any application. They are
/// however not so useful, unless all you really want to do is to show what
/// Flutter Widgets look like.
class ThemeShowcase extends StatelessWidget {
  const ThemeShowcase({
    Key? key,
    this.useRailAssertWorkAround = true,
  }) : super(key: key);

  // Flag set to true to make a work around to avoid unnecessarily
  // eager assert in NavigationRail SDK API.
  //
  // Assertion: line 562 pos 7: 'useIndicator || indicatorColor == null'
  // A flag is used to do trickery with transparency for this
  // assertion that we cannot avoid since the theme controls the
  // setup and user it. User may enter combo that has no effect, and
  // triggers the assert.
  // It should be obvious that if you have no indicator color
  // you cannot use an indicator, why assert it? Just don't show one!
  final bool useRailAssertWorkAround;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const ElevatedButtonShowcase(),
        const SizedBox(height: 8),
        const OutlinedButtonShowcase(),
        const SizedBox(height: 8),
        const TextButtonShowcase(),
        const SizedBox(height: 8),
        const Divider(),
        const FabShowcase(),
        const SizedBox(height: 16),
        const ToggleButtonsShowcase(),
        const SwitchShowcase(),
        const CheckboxShowcase(),
        const RadioShowcase(),
        const PopupMenuShowcase(),
        const SizedBox(height: 8),
        const IconButtonCircleAvatarDropdownTooltipShowcase(),
        const SizedBox(height: 8),
        const ChipShowcase(),
        const Divider(),
        const TextInputField(),
        const Divider(),
        const ListTileShowcase(),
        const Divider(),
        const TabBarForAppBarShowcase(),
        const SizedBox(height: 8),
        const Divider(),
        const TabBarForBackgroundShowcase(),
        const SizedBox(height: 8),
        const Divider(),
        const BottomNavigationBarShowcase(),
        const SizedBox(height: 8),
        const Divider(),
        const NavigationBarShowcase(),
        const SizedBox(height: 8),
        const Divider(),
        NavigationRailShowcase(useAssertWorkAround: useRailAssertWorkAround),
        const SizedBox(height: 8),
        const Divider(),
        const AlertDialogShowcase(),
        const TimePickerDialogShowcase(),
        const DatePickerDialogShowcase(),
        const Divider(),
        const MaterialAndBottomSheetShowcase(),
        const Divider(height: 32),
        const CardShowcase(),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text('Normal TextTheme', style: Theme.of(context).textTheme.titleMedium),
                ),
                const TextThemeShowcase(),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Card(
          color: Theme.of(context).colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text('Primary TextTheme', style: Theme.of(context).primaryTextTheme.subtitle1),
                ),
                const PrimaryTextThemeShowcase(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ElevatedButtonShowcase extends StatelessWidget {
  const ElevatedButtonShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      runSpacing: 8,
      children: <Widget>[
        ElevatedButton(
          onPressed: () {},
          child: const Text('浮动按钮'),
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text('浮动图标'),
        ),
        const ElevatedButton(
          onPressed: null,
          child: Text('浮动按钮'),
        ),
      ],
    );
  }
}

class OutlinedButtonShowcase extends StatelessWidget {
  const OutlinedButtonShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      runSpacing: 8,
      children: <Widget>[
        OutlinedButton(
          onPressed: () {},
          child: const Text('Outlined button'),
        ),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text('Outlined icon'),
        ),
        const OutlinedButton(
          onPressed: null,
          child: Text('Outlined button'),
        ),
      ],
    );
  }
}

class TextButtonShowcase extends StatelessWidget {
  const TextButtonShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      runSpacing: 8,
      children: <Widget>[
        TextButton(
          onPressed: () {},
          child: const Text('Text button'),
        ),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text('Text icon'),
        ),
        const TextButton(
          onPressed: null,
          child: Text('Text button'),
        ),
      ],
    );
  }
}

class ToggleButtonsShowcase extends StatelessWidget {
  const ToggleButtonsShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      runSpacing: 4,
      children: <Widget>[
        ToggleButtons(
          isSelected: const <bool>[true, false, false],
          onPressed: (int newIndex) {},
          children: const <Widget>[
            Icon(Icons.adb),
            Icon(Icons.phone),
            Icon(Icons.account_circle),
          ],
        ),
        ToggleButtons(
          isSelected: const <bool>[true, false, false],
          onPressed: null,
          children: const <Widget>[
            Icon(Icons.adb),
            Icon(Icons.phone),
            Icon(Icons.account_circle),
          ],
        ),
      ],
    );
  }
}

class FabShowcase extends StatelessWidget {
  const FabShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      runSpacing: 4,
      children: <Widget>[
        FloatingActionButton(
          heroTag: null,
          onPressed: () {},
          mini: true,
          tooltip: '最小尺寸浮动操作按钮',
          child: const Icon(Icons.accessibility),
        ),
        FloatingActionButton.extended(
          heroTag: null,
          isExtended: false,
          onPressed: () {},
          tooltip: '无扩展浮动操作按钮',
          icon: const Icon(Icons.accessibility),
          label: const Text('扩展'),
        ),
        FloatingActionButton.extended(
          heroTag: null,
          isExtended: true,
          onPressed: () {},
          tooltip: '带扩展浮动操作按钮',
          icon: const Icon(Icons.accessibility),
          label: const Text('扩展'),
        ),
        FloatingActionButton(
          heroTag: null,
          onPressed: () {},
          tooltip: '默认浮动操作按钮',
          child: const Icon(Icons.accessibility),
        ),
      ],
    );
  }
}

class SwitchShowcase extends StatelessWidget {
  const SwitchShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      runSpacing: 4,
      children: <Widget>[
        Switch(
          value: true,
          onChanged: (bool value) {},
        ),
        Switch(
          value: false,
          onChanged: (bool value) {},
        ),
        const Switch(
          value: true,
          onChanged: null,
        ),
        const Switch(
          value: false,
          onChanged: null,
        ),
      ],
    );
  }
}

class CheckboxShowcase extends StatelessWidget {
  const CheckboxShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      runSpacing: 4,
      children: <Widget>[
        Checkbox(
          value: true,
          onChanged: (bool? value) {},
        ),
        Checkbox(
          value: false,
          onChanged: (bool? value) {},
        ),
        const Checkbox(
          value: true,
          onChanged: null,
        ),
        const Checkbox(
          value: false,
          onChanged: null,
        ),
      ],
    );
  }
}

class RadioShowcase extends StatelessWidget {
  const RadioShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      runSpacing: 4,
      children: <Widget>[
        Radio<bool>(
          value: true,
          groupValue: true,
          onChanged: (bool? value) {},
        ),
        Radio<bool>(
          value: false,
          groupValue: true,
          onChanged: (bool? value) {},
        ),
        const Radio<bool>(
          value: true,
          groupValue: true,
          onChanged: null,
        ),
        const Radio<bool>(
          value: false,
          groupValue: true,
          onChanged: null,
        ),
      ],
    );
  }
}

class PopupMenuShowcase extends StatelessWidget {
  const PopupMenuShowcase({
    Key? key,
    this.enabled = true,
    this.popupRadius,
  }) : super(key: key);
  final bool enabled;
  final double? popupRadius;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      runSpacing: 4,
      children: <Widget>[
        _PopupMenuButton(enabled: enabled, radius: popupRadius),
      ],
    );
  }
}

class _PopupMenuButton extends StatelessWidget {
  const _PopupMenuButton({
    Key? key,
    this.enabled = true,
    this.radius,
  }) : super(key: key);
  final bool enabled;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    return PopupMenuButton<int>(
      onSelected: (_) {},
      enabled: enabled,
      tooltip: enabled ? 'Show menu' : 'Menu disabled',
      itemBuilder: (BuildContext context) => const <PopupMenuItem<int>>[
        PopupMenuItem<int>(value: 1, child: Text('Option 1')),
        PopupMenuItem<int>(value: 2, child: Text('Option 2')),
        PopupMenuItem<int>(value: 3, child: Text('Option 3')),
        PopupMenuItem<int>(value: 4, child: Text('Option 4')),
        PopupMenuItem<int>(value: 5, child: Text('Option 5')),
      ],
      child: AbsorbPointer(
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: scheme.secondary,
            onPrimary: scheme.onSecondary,
            onSurface: scheme.onSurface,
            shape: radius != null
                ? RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(radius ?? 4)),
                  )
                : null,
          ),
          onPressed: enabled ? () {} : null,
          icon: const Icon(Icons.expand_more_outlined),
          label: const Text('PopupMenu'),
        ),
      ),
    );
  }
}

class _DropDownButton extends StatefulWidget {
  const _DropDownButton({Key? key}) : super(key: key);

  @override
  State<_DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<_DropDownButton> {
  String selectedItem = '下拉按钮 1';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedItem,
      onChanged: (String? value) {
        setState(() {
          selectedItem = value ?? '下拉按钮 1';
        });
      },
      items: <String>['下拉按钮 1', '下拉按钮 2', '下拉按钮 3', '下拉按钮 4', '下拉按钮 5'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class _DropDownButtonFormField extends StatefulWidget {
  const _DropDownButtonFormField({Key? key}) : super(key: key);

  @override
  State<_DropDownButtonFormField> createState() => _DropDownButtonFormFieldState();
}

class _DropDownButtonFormFieldState extends State<_DropDownButtonFormField> {
  String selectedItem = '下拉按钮 选项1';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedItem,
      onChanged: (String? value) {
        setState(() {
          selectedItem = value ?? '下拉按钮 选项1';
        });
      },
      items: <String>[
        '下拉按钮 选项1',
        '下拉按钮 选项2',
        '下拉按钮 选项3',
        '下拉按钮 选项4',
        '下拉按钮 选项5',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class IconButtonCircleAvatarDropdownTooltipShowcase extends StatelessWidget {
  const IconButtonCircleAvatarDropdownTooltipShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 16,
      runSpacing: 4,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: IconButton(
            icon: const Icon(Icons.accessibility),
            tooltip: '图标按钮',
            onPressed: () {},
          ),
        ),
        const Tooltip(
          message: '圆形头像',
          child: CircleAvatar(child: Text('头像')),
        ),
        const _DropDownButton(),
        const Tooltip(
          message: '提示',
          child: Text('带提示的文本'),
        ),
      ],
    );
  }
}

class ChipShowcase extends StatelessWidget {
  const ChipShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      runSpacing: 8,
      children: <Widget>[
        Chip(
          label: const Text('标签'),
          onDeleted: () {},
        ),
        const Chip(
          label: Text('图标标签'),
          avatar: FlutterLogo(),
        ),
        InputChip(
          label: const Text('可输入标签'),
          onSelected: (bool value) {},
        ),
        InputChip(
          showCheckmark: true,
          selected: true,
          label: const Text('选中可输入标签'),
          onSelected: (bool value) {},
        ),
        const InputChip(
          label: Text('禁用标签'),
          isEnabled: false,
        ),
        ChoiceChip(
          label: const Text('选中标签'),
          selected: true,
          onSelected: (bool value) {},
        ),
        ChoiceChip(
          label: const Text('未选中标签'),
          selected: false,
          onSelected: (bool value) {},
        ),
      ],
    );
  }
}

class TextInputField extends StatefulWidget {
  const TextInputField({Key? key}) : super(key: key);

  @override
  _TextInputFieldState createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  late TextEditingController _textController1;
  late TextEditingController _textController2;
  bool _errorState1 = false;
  bool _errorState2 = false;

  @override
  void initState() {
    super.initState();
    _textController1 = TextEditingController();
    _textController2 = TextEditingController();
  }

  @override
  void dispose() {
    _textController1.dispose();
    _textController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          onChanged: (String text) {
            setState(() {
              if (text.contains('a') | text.isEmpty) {
                _errorState1 = false;
              } else {
                _errorState1 = true;
              }
            });
          },
          key: const Key('TextField1'),
          controller: _textController1,
          decoration: InputDecoration(
            hintText: '写点什么...',
            labelText: '文本输入框',
            errorText: _errorState1 ? "没有字母 \"a\" 会报错" : null,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          onChanged: (String text) {
            setState(() {
              if (text.contains('a') | text.isEmpty) {
                _errorState2 = false;
              } else {
                _errorState2 = true;
              }
            });
          },
          key: const Key('TextField2'),
          controller: _textController2,
          decoration: InputDecoration(
            hintText: '写点什么...',
            labelText: '另一个文本输入框',
            errorText: _errorState2 ? "没有字母 \"a\" 会报错" : null,
          ),
        ),
        const SizedBox(height: 8),
        const TextField(
          enabled: false,
          decoration: InputDecoration(
            labelText: '禁用输入',
          ),
        ),
        const SizedBox(height: 8),
        const _DropDownButtonFormField(),
      ],
    );
  }
}

class TabBarForAppBarShowcase extends StatelessWidget {
  const TabBarForAppBarShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final ColorScheme colorScheme = theme.colorScheme;

    final Color effectiveTabBackground = Theme.of(context).appBarTheme.backgroundColor ?? (isDark ? colorScheme.surface : colorScheme.primary);
    final TextStyle denseHeader = theme.textTheme.titleMedium!.copyWith(
      fontSize: 13,
    );
    final TextStyle denseBody = theme.textTheme.bodyMedium!.copyWith(fontSize: 12, color: theme.textTheme.bodySmall!.color);

    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Material(
            color: effectiveTabBackground,
            child: const SizedBox(
              height: 70,
              child: TabBar(
                tabs: <Widget>[
                  Tab(text: '聊天', icon: Icon(Icons.chat_bubble)),
                  Tab(text: '任务', icon: Icon(Icons.beenhere)),
                  Tab(text: '文件', icon: Icon(Icons.create_new_folder)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TabBarForBackgroundShowcase extends StatelessWidget {
  const TabBarForBackgroundShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle denseHeader = theme.textTheme.titleMedium!.copyWith(
      fontSize: 13,
    );
    final TextStyle denseBody = theme.textTheme.bodyMedium!.copyWith(fontSize: 12, color: theme.textTheme.bodySmall!.color);
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 70,
            child: TabBar(
              tabs: <Widget>[
                Tab(text: '聊天', icon: Icon(Icons.chat_bubble)),
                Tab(text: '任务', icon: Icon(Icons.beenhere)),
                Tab(text: '文件', icon: Icon(Icons.create_new_folder)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavigationBarShowcase extends StatefulWidget {
  const BottomNavigationBarShowcase({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarShowcase> createState() => _BottomNavigationBarShowcaseState();
}

class _BottomNavigationBarShowcaseState extends State<BottomNavigationBarShowcase> {
  int buttonIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle denseHeader = theme.textTheme.titleMedium!.copyWith(
      fontSize: 13,
    );
    final TextStyle denseBody = theme.textTheme.bodyMedium!.copyWith(fontSize: 12, color: theme.textTheme.bodySmall!.color);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MediaQuery.removePadding(
          context: context,
          removeBottom: true,
          child: BottomNavigationBar(
            currentIndex: buttonIndex,
            onTap: (int value) {
              setState(() {
                buttonIndex = value;
              });
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.chat_bubble), label: '聊天'),
              BottomNavigationBarItem(icon: Icon(Icons.beenhere), label: '任务'),
              BottomNavigationBarItem(icon: Icon(Icons.create_new_folder), label: '文件'),
            ],
          ),
        ),
      ],
    );
  }
}

class NavigationBarShowcase extends StatefulWidget {
  const NavigationBarShowcase({Key? key}) : super(key: key);

  @override
  State<NavigationBarShowcase> createState() => _NavigationBarShowcaseState();
}

class _NavigationBarShowcaseState extends State<NavigationBarShowcase> {
  int buttonIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle denseHeader = theme.textTheme.titleMedium!.copyWith(
      fontSize: 13,
    );
    final TextStyle denseBody = theme.textTheme.bodyMedium!.copyWith(fontSize: 12, color: theme.textTheme.bodySmall!.color);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MediaQuery.removePadding(
          context: context,
          removeBottom: true,
          child: NavigationBar(
            selectedIndex: buttonIndex,
            onDestinationSelected: (int value) {
              setState(() {
                buttonIndex = value;
              });
            },
            destinations: const <NavigationDestination>[
              NavigationDestination(icon: Icon(Icons.chat_bubble), label: '聊天'),
              NavigationDestination(icon: Icon(Icons.beenhere), label: '任务'),
              NavigationDestination(icon: Icon(Icons.create_new_folder), label: 'Folder'),
            ],
          ),
        ),
      ],
    );
  }
}

class NavigationRailShowcase extends StatefulWidget {
  const NavigationRailShowcase({
    Key? key,
    this.child,
    this.height = 400,
    this.useAssertWorkAround = true,
  }) : super(key: key);

  /// A child widget that we can use to place controls on the
  /// side of the NavigationRail in the show case widget.
  final Widget? child;

  /// The vertical space for the navigation bar.
  final double height;

  // TODO(rydmike): Unnecessary assert, raise SDK issue explain why not needed.
  // Flag set to true to make a work around to avoid unnecessarily
  // eager assert in SDK.
  //
  // Assertion: line 562 pos 7: 'useIndicator || indicatorColor == null'
  // A flag is used to do trickery with transparency for this
  // assertion that we cannot avoid since the theme controls the
  // setup and user it. User may enter combo that has no effect, and
  // triggers the assert.
  // It should be obvious that if you have no indicator color
  // you cannot use an indicator, why assert it? Just don't show one!
  final bool useAssertWorkAround;

  @override
  State<NavigationRailShowcase> createState() => _NavigationRailShowcaseState();
}

class _NavigationRailShowcaseState extends State<NavigationRailShowcase> {
  int buttonIndex = 0;
  bool isExtended = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle denseHeader = theme.textTheme.titleMedium!.copyWith(
      fontSize: 13,
    );
    final TextStyle denseBody = theme.textTheme.bodyMedium!.copyWith(fontSize: 12, color: theme.textTheme.bodySmall!.color);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Text('侧导航栏', style: denseHeader),
        ),
        const Divider(height: 1),
        SizedBox(
          height: widget.height,
          child: ClipRect(
            child: OverflowBox(
              alignment: AlignmentDirectional.topStart,
              maxHeight: 1200,
              child: Row(
                children: <Widget>[
                  NavigationRail(
                    extended: isExtended,
                    useIndicator: widget.useAssertWorkAround ? true : null,
                    minExtendedWidth: 150,
                    indicatorColor: widget.useAssertWorkAround ? Colors.transparent : null,
                    labelType: isExtended ? NavigationRailLabelType.none : null,
                    selectedIndex: buttonIndex,
                    onDestinationSelected: (int value) {
                      setState(() {
                        buttonIndex = value;
                      });
                    },
                    destinations: const <NavigationRailDestination>[
                      NavigationRailDestination(icon: Icon(Icons.chat_bubble), label: Text('聊天')),
                      NavigationRailDestination(icon: Icon(Icons.beenhere), label: Text('任务')),
                      NavigationRailDestination(icon: Icon(Icons.create_new_folder), label: Text('文件')),
                      NavigationRailDestination(icon: Icon(Icons.logout), label: Text('退出')),
                    ],
                  ),
                  const VerticalDivider(width: 1),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        SwitchListTileAdaptive(
                          title: const Text('收缩/展开'),
                          value: isExtended,
                          onChanged: (bool value) {
                            setState(() {
                              isExtended = value;
                            });
                          },
                        ),
                        widget.child ?? const SizedBox.shrink(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ListTileShowcase extends StatelessWidget {
  const ListTileShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('列表项'),
          subtitle: const Text('列表项子标题'),
          trailing: const Text('列表项尾'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('选中列表项'),
          subtitle: const Text('选中列表项子标题'),
          trailing: const Text('选中列表项尾'),
          selected: true,
          onTap: () {},
        ),
        const Divider(height: 1),
        SwitchListTile(
          secondary: const Icon(Icons.info),
          title: const Text('开关列表项'),
          subtitle: const Text('关闭'),
          value: false,
          onChanged: (bool value) {},
        ),
        SwitchListTile(
          secondary: const Icon(Icons.info),
          title: const Text('开关列表项'),
          subtitle: const Text('打开'),
          value: true,
          onChanged: (bool value) {},
        ),
        const Divider(height: 1),
        CheckboxListTile(
          secondary: const Icon(Icons.info),
          title: const Text('复选框列表项'),
          subtitle: const Text('未选中'),
          value: false,
          onChanged: (bool? value) {},
        ),
        CheckboxListTile(
          secondary: const Icon(Icons.info),
          title: const Text('复选框列表项'),
          subtitle: const Text('选中'),
          value: true,
          onChanged: (bool? value) {},
        ),
        CheckboxListTile(
          secondary: const Icon(Icons.info),
          title: const Text('复选框列表项'),
          subtitle: const Text('空选，既不是选中，也不是未选中'),
          tristate: true,
          value: null,
          onChanged: (bool? value) {},
        ),
        const Divider(height: 1),
        RadioListTile<int>(
          secondary: const Icon(Icons.info),
          title: const Text('单选框列表项'),
          subtitle: const Text('未选中'),
          value: 0,
          onChanged: (_) {},
          groupValue: 1,
        ),
        RadioListTile<int>(
          secondary: const Icon(Icons.info),
          title: const Text('单选框列表项'),
          subtitle: const Text('选中'),
          value: 1,
          onChanged: (_) {},
          groupValue: 1,
        ),
        RadioListTile<int>(
          secondary: const Icon(Icons.info),
          title: const Text('单选框列表项'),
          subtitle: const Text('选中且高亮'),
          value: 1,
          selected: true,
          onChanged: (_) {},
          groupValue: 1,
        ),
      ],
    );
  }
}

class TimePickerDialogShowcase extends StatelessWidget {
  const TimePickerDialogShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // The TimePickerDialog pops the context with its buttons, clicking them
    // pops the page when not used in a showDialog. We just need to see it, no
    // need to use it to visually see what it looks like, so absorbing pointers.
    return AbsorbPointer(
      child: TimePickerDialog(
        initialTime: TimeOfDay.now(),
      ),
    );
  }
}

class DatePickerDialogShowcase extends StatelessWidget {
  const DatePickerDialogShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // The DatePickerDialog pops the context with its buttons, clicking them
    // pops the page when not used in a showDialog. We just need to see it, no
    // need to use it to visually see what it looks like, so absorbing pointers.
    return AbsorbPointer(
      child: DatePickerDialog(
        initialDate: DateTime.now(),
        firstDate: DateTime(1930),
        lastDate: DateTime(2050),
      ),
    );
  }
}

class AlertDialogShowcase extends StatelessWidget {
  const AlertDialogShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('启动位置服务'),
      content: const Text('帮助确定位置，需要发送匿名位置信息'),
      actions: <Widget>[
        TextButton(onPressed: () {}, child: const Text('取消')),
        TextButton(onPressed: () {}, child: const Text('允许')),
      ],
      actionsPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}

class MaterialAndBottomSheetShowcase extends StatelessWidget {
  const MaterialAndBottomSheetShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final bool isLight = theme.brightness == Brightness.light;

    final Color defaultBackgroundColor = isLight ? Color.alphaBlend(colorScheme.onSurface.withOpacity(0.80), colorScheme.surface) : colorScheme.onSurface;
    final Color snackBackground = theme.snackBarTheme.backgroundColor ?? defaultBackgroundColor;
    final Color snackForeground = ThemeData.estimateBrightnessForColor(snackBackground) == Brightness.light ? Colors.black : Colors.white;
    final TextStyle snackStyle =
        theme.snackBarTheme.contentTextStyle ?? ThemeData(brightness: Brightness.light).textTheme.titleMedium!.copyWith(color: snackForeground);
    final TextStyle denseHeader = theme.textTheme.titleMedium!.copyWith(
      fontSize: 13,
    );
    final TextStyle denseBody = theme.textTheme.bodyMedium!.copyWith(fontSize: 12, color: theme.textTheme.bodySmall!.color);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MaterialBanner(
          padding: const EdgeInsets.all(20),
          content: const Text('提示横幅'),
          leading: const Icon(Icons.notifications),
          actions: <Widget>[
            TextButton(
              child: const Text('打开'),
              onPressed: () {},
            ),
            TextButton(
              child: const Text('忽略'),
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text('Material type canvas', style: denseHeader),
        Text(
          'Default background color is theme canvasColor, and '
          'theme canvasColor is set to theme colorScheme background. The '
          'color canvasColor is going to be deprecated in Flutter SDK',
          style: denseBody,
        ),
        const Material(
          type: MaterialType.canvas,
          elevation: 0,
          child: SizedBox(
            height: 50,
            child: Center(child: Text('Material type canvas, elevation 0')),
          ),
        ),
        const SizedBox(height: 10),
        const Material(
          type: MaterialType.canvas,
          elevation: 1,
          child: SizedBox(
            height: 50,
            child: Center(child: Text('Material type canvas, elevation 1')),
          ),
        ),
        const SizedBox(height: 10),
        const Material(
          type: MaterialType.canvas,
          elevation: 4,
          child: SizedBox(
            height: 50,
            child: Center(child: Text('Material type canvas, elevation 4')),
          ),
        ),
        const SizedBox(height: 32),
        Text('Material type card', style: denseHeader),
        Text(
          'Default background color is theme cardColor, and '
          'theme cardColor is set to theme colorScheme surface. The '
          'color cardColor is going to be deprecated in Flutter SDK',
          style: denseBody,
        ),
        const Material(
          elevation: 0,
          type: MaterialType.card,
          child: SizedBox(
            height: 50,
            child: Center(child: Text('Material type card, elevation 0')),
          ),
        ),
        const SizedBox(height: 10),
        const Material(
          elevation: 1,
          type: MaterialType.card,
          child: SizedBox(
            height: 50,
            child: Center(child: Text('Material type card, elevation 1')),
          ),
        ),
        const SizedBox(height: 10),
        const Material(
          elevation: 4,
          type: MaterialType.card,
          child: SizedBox(
            height: 50,
            child: Center(child: Text('Material type card, elevation 4')),
          ),
        ),
        const SizedBox(height: 24),
        AbsorbPointer(
          child: BottomSheet(
            enableDrag: false,
            onClosing: () {},
            builder: (final BuildContext context) => SizedBox(
              height: 150,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 20),
                    Text(
                      '底部弹框',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      'Like Drawer it uses Material of type canvas as '
                      'background.',
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    Material(
                      color: snackBackground,
                      elevation: 0,
                      child: SizedBox(
                        height: 40,
                        child: Center(
                          child: Text('底部提示横幅', style: snackStyle),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CardShowcase extends StatelessWidget {
  const CardShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle denseHeader = theme.textTheme.titleMedium!.copyWith(
      fontSize: 13,
    );
    final TextStyle denseBody = theme.textTheme.bodyMedium!.copyWith(fontSize: 12, color: theme.textTheme.bodySmall!.color);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text('卡片', style: denseHeader),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Default background color comes from Material of type card',
            style: denseBody,
          ),
        ),
        const Card(
          elevation: 0,
          child: SizedBox(
            height: 50,
            child: Center(child: Text('卡片, 海拔 0')),
          ),
        ),
        const SizedBox(height: 10),
        const Card(
          elevation: 1,
          child: SizedBox(
            height: 50,
            child: Center(child: Text('卡片, 海拔 1')),
          ),
        ),
        const SizedBox(height: 10),
        const Card(
          elevation: 4,
          child: SizedBox(
            height: 50,
            child: Center(child: Text('卡片, 海拔 4')),
          ),
        ),
        const SizedBox(height: 10),
        const Card(
          elevation: 8,
          child: SizedBox(
            height: 50,
            child: Center(child: Text('卡片, 海拔 8')),
          ),
        ),
      ],
    );
  }
}

class TextThemeShowcase extends StatelessWidget {
  const TextThemeShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextThemeColumnShowcase(textTheme: Theme.of(context).textTheme);
  }
}

class PrimaryTextThemeShowcase extends StatelessWidget {
  const PrimaryTextThemeShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextThemeColumnShowcase(textTheme: Theme.of(context).primaryTextTheme);
  }
}

class TextThemeColumnShowcase extends StatelessWidget {
  const TextThemeColumnShowcase({Key? key, required this.textTheme}) : super(key: key);
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('字体: ${textTheme.titleSmall!.fontFamily}', style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600)),
        Text(
          'Display Large '
          '(${textTheme.displayLarge!.fontSize!.toStringAsFixed(0)})',
          style: textTheme.displayLarge,
        ),
        Text(
          'Display Medium '
          '(${textTheme.displayMedium!.fontSize!.toStringAsFixed(0)})',
          style: textTheme.displayMedium,
        ),
        Text(
          'Display Small '
          '(${textTheme.displaySmall!.fontSize!.toStringAsFixed(0)})',
          style: textTheme.displaySmall,
        ),
        const SizedBox(height: 12),
        Text(
          'Headline Large '
          '(${textTheme.headlineLarge!.fontSize!.toStringAsFixed(0)})',
          style: textTheme.headlineLarge,
        ),
        Text(
          'Headline Medium '
          '(${textTheme.headlineMedium!.fontSize!.toStringAsFixed(0)})',
          style: textTheme.headlineMedium,
        ),
        Text(
          'Headline Small '
          '(${textTheme.headlineSmall!.fontSize!.toStringAsFixed(0)})',
          style: textTheme.headlineSmall,
        ),
        const SizedBox(height: 12),
        Text(
          'Title Large '
          '(${textTheme.titleLarge!.fontSize!.toStringAsFixed(0)})',
          style: textTheme.titleLarge,
        ),
        Text(
          'Title Medium '
          '(${textTheme.titleMedium!.fontSize!.toStringAsFixed(0)})',
          style: textTheme.titleMedium,
        ),
        Text(
          'Title Small '
          '(${textTheme.titleSmall!.fontSize!.toStringAsFixed(0)})',
          style: textTheme.titleSmall,
        ),
        const SizedBox(height: 12),
        Text(
          'Body Large '
          '(${textTheme.bodyLarge!.fontSize!.toStringAsFixed(0)})',
          style: textTheme.bodyLarge,
        ),
        Text(
          'Body Medium '
          '(${textTheme.bodyMedium!.fontSize!.toStringAsFixed(0)})',
          style: textTheme.bodyMedium,
        ),
        Text(
          'Body Small '
          '(${textTheme.bodySmall!.fontSize!.toStringAsFixed(0)})',
          style: textTheme.bodySmall,
        ),
        const SizedBox(height: 12),
        Text(
          'Label Large '
          '(${textTheme.labelLarge!.fontSize!.toStringAsFixed(0)})',
          style: textTheme.labelLarge,
        ),
        Text(
          'Label Medium '
          '(${textTheme.labelMedium!.fontSize!.toStringAsFixed(0)})',
          style: textTheme.labelMedium,
        ),
        Text(
          'Label Small '
          '(${textTheme.labelSmall!.fontSize!.toStringAsFixed(0)})',
          style: textTheme.labelSmall,
        ),
      ],
    );
  }
}
