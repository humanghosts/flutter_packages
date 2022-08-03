import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hg_framework/hg_framework.dart';

/// 外部参数
@immutable
class DialogViewArgs extends ViewArgs {
  final Widget? title;
  final List<Widget> content;
  final Widget? buttonBar;
  final VoidCallback? onCancel;
  final VoidCallback? onDone;
  final bool max;
  final bool scrollable;

  const DialogViewArgs({
    this.title,
    this.content = const [],
    this.buttonBar,
    this.onDone,
    this.onCancel,
    this.max = false,
    this.scrollable = true,
  });
}

/// 外部数据
@immutable
class DialogViewDataSource extends ViewDataSource {
  const DialogViewDataSource();
}

/// 逻辑
class DialogViewLogic<A extends DialogViewArgs, D extends DialogViewDataSource> extends ViewLogic<A, D> {
  /// 取消
  void cancel() {
    (args.onCancel ?? RouteHelper.back)();
  }

  /// 确认
  void done() {
    (args.onDone ?? RouteHelper.back)();
  }
}

/// 页面
class DialogView<L extends DialogViewLogic> extends View<L> {
  DialogView({
    required String key,
    required DialogViewArgs args,
    DialogViewDataSource? dataSource,
    L? logic,
  }) : super(key: key, args: args, dataSource: dataSource ?? const DialogViewDataSource(), logic: (logic ?? DialogViewLogic()) as L);

  @override
  Widget buildView(BuildContext context) {
    Widget widget = Dialog(
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      insetPadding: EdgeInsets.zero,
      child: buildDialog(context),
    );
    if (!logic.args.max) widget = IntrinsicHeight(child: IntrinsicWidth(child: widget));

    if (DeviceInfoHelper.isMobile) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
          child: Container(
            alignment: Alignment.center,
            constraints: BoxConstraints(
              maxHeight: Get.height * 0.8,
              maxWidth: Get.width,
              minWidth: Get.width,
              minHeight: 0,
            ),
            child: widget,
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
        child: DraggableWidget(
          key: getChildKey(DraggableWidget),
          args: DraggableArgs(
            child: widget,
            isLimitInParent: false,
            constraints: BoxConstraints(
              maxHeight: Get.height * 0.8,
              maxWidth: Get.width * 0.8,
              minWidth: Get.width * 0.3,
              minHeight: Get.width * 0.2,
            ),
            resizeAreaSize: const Size(20, 20),
            resizeable: false,
          ),
        ),
      ),
    );
  }

  Widget buildDialog(BuildContext context) {
    ThemeData theme = logic.theme;
    // 标题
    Widget title = DefaultTextStyle(
      style: theme.appBarTheme.titleTextStyle ?? DialogTheme.of(context).titleTextStyle ?? theme.textTheme.headline6!,
      child: buildTitle(context) ?? const SizedBox.shrink(),
    );

    // 内容
    Widget content = logic.args.scrollable
        ? SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: buildContents(context)))
        : Column(crossAxisAlignment: CrossAxisAlignment.start, children: buildContents(context));
    // 对话框主题
    Widget child = Container(
      clipBehavior: Clip.hardEdge,
      constraints: BoxConstraints(
        maxHeight: DeviceInfoHelper.isDesktop ? Get.height * 0.8 : Get.height * 0.9,
        maxWidth: DeviceInfoHelper.isDesktop ? Get.width * 0.8 : Get.width * 0.9,
        minWidth: DeviceInfoHelper.isDesktop ? Get.width * 0.3 : Get.width * 0.9,
        minHeight: 0,
      ),
      decoration: BoxDecoration(color: theme.colorScheme.primaryContainer.withOpacity(0.5)),
      child: Stack(
        children: [
          // 毛玻璃效果
          BackdropFilter(filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10), child: const SizedBox()),
          Container(color: theme.dialogBackgroundColor.withOpacity(0.5)),
          // 实际内容
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 48),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                title,
                const SizedBox(height: 16),
                Expanded(
                  // 控制只能通过上下左右来拖动窗口
                  child: DeviceInfoHelper.isDesktop ? Draggable(feedback: const SizedBox.shrink(), child: content) : content,
                ),
              ],
            ),
          ),
          // 操作栏
          Positioned(bottom: 8, right: 16, child: buildButtonBar(context)),
        ],
      ),
    );
    return AnimatedSize(duration: logic.fastAnimationDuration, child: child);
  }

  /// 按钮行
  Widget buildButtonBar(BuildContext context) {
    if (null != logic.args.buttonBar) return logic.args.buttonBar!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(onPressed: logic.cancel, child: const Text("取消")),
        TextButton(onPressed: logic.done, child: const Text("确定")),
      ],
    );
  }

  /// 标题
  Widget? buildTitle(BuildContext context) => logic.args.title;

  /// 内容
  List<Widget> buildContents(BuildContext context) => logic.args.content;
}
