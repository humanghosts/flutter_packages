import 'dart:collection';

import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/log/log.dart';
import 'package:hg_logger/view/export.dart';
import 'package:hg_logger/view/page/log/ansi_parser.dart';
import 'package:logger/logger.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RenderedEvent {
  final int id;
  final Level level;
  final TextSpan span;
  final String lowerCaseText;

  RenderedEvent(this.id, this.level, this.span, this.lowerCaseText);
}

/// 逻辑
class LogHomeLogic extends HomePageLogic {
  /// 下拉刷新控制器
  RefreshController refreshController = RefreshController();

  ListQueue<OutputEvent> loggerList = ListQueue();

  Rx<int> outputListUpdateFlag = 0.obs;

  @override
  void afterArgsUpdate() {
    outputListUpdateFlag.value = 0;
    loggerList = LogHelper.output;
    super.afterArgsUpdate();
  }

  void refreshList() {
    loggerList = LogHelper.output;
    refreshController.refreshCompleted();
    outputListUpdateFlag.value++;
  }

  @override
  void buildTutorial() {}

  @override
  HomePages get homePage => HomePages.log;
}

/// 页面
class LogHome extends HomePage<LogHomeLogic> {
  LogHome({required String key, required HomePageArgs args}) : super(key: key, args: args, newLogic: LogHomeLogic());

  @override
  Widget buildView(BuildContext context) {
    return HgNeumorphicScaffold(
      title: HgNeumorphicText("日志"),
      bodyPadding: EdgeInsets.zero,
      body: SafeArea(
        bottom: false,
        child: SmartRefresher(
          key: ValueKey(logic.key),
          controller: logic.refreshController,
          child: Obx(() {
            int updateFlag = logic.outputListUpdateFlag.value;
            debugPrint("日志列表更新次数:$updateFlag");
            return buildLogList();
          }),
          onRefresh: () {
            HapticFeedback.lightImpact();
            logic.refreshList();
          },
        ),
      ),
    );
  }

  Widget buildLogList() {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        OutputEvent outputEvent = logic.loggerList.elementAt(index);
        RenderedEvent renderedEvent = _renderEvent(outputEvent, index);
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text.rich(
            renderedEvent.span,
            key: Key(renderedEvent.id.toString()),
            style: const TextStyle(overflow: TextOverflow.visible),
          ),
        );
      },
      itemCount: logic.loggerList.length,
    );
  }

  RenderedEvent _renderEvent(OutputEvent event, int id) {
    var parser = AnsiParser(Get.isDarkMode);
    var text = event.lines.join('\n');
    parser.parse(text);
    return RenderedEvent(
      id,
      event.level,
      TextSpan(children: parser.spans),
      text.toLowerCase(),
    );
  }
}
