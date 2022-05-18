import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/route/observer.dart';
import 'package:hg_logger/ability/route/route.dart';
import 'package:hg_logger/entity/data/notice.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/export.dart';

import 'notice_detail.dart';

@immutable
class NoticeListArgs extends ViewArgs {
  /// 导航id
  final int? navigatorId;

  /// 返回回调
  final Function(List<Notice> noticeList) onBack;

  /// 状态变化
  final PageState state;

  const NoticeListArgs({
    required this.onBack,
    this.navigatorId,
    required this.state,
  });
}

@immutable
class NoticeListDataSource extends ViewDataSource {
  /// 属性
  final List<Notice> noticeList;

  const NoticeListDataSource({required this.noticeList});
}

/// 逻辑
class NoticeListLogic extends ViewLogic<NoticeListArgs, NoticeListDataSource> {
  /// 临时存储变量
  List<Notice> noticeList = [];

  Rx<int> updateFlag = 0.obs;

  /// 打开回调 自动跳转到详情页面
  @override
  void afterArgsUpdate() {
    updateFlag.value = 0;
    if (args.state == PageState.browse) return;
    // 复制提醒
    noticeList = dataSource.noticeList.map((e) => e.clone() as Notice).toList();
    // 列表为空自动新增一个空提醒
    if (noticeList.isEmpty) {
      Notice notice = Notice();
      noticeList.add(notice);
      updateFlag.value++;
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        (widget as NoticeList).toDetail(notice);
      });
    }
  }

  /// 返回
  void back() {
    RouteHelper.back(id: args.navigatorId);
  }

  /// 返回
  void onBack() {
    clearEmpty();
    args.onBack.call(noticeList);
  }

  /// 清空无效提醒和相同提醒
  void clearEmpty() {
    List<Notice> finalList = [];
    Set<int> uniqueCodeSet = {};
    for (Notice notice in noticeList) {
      if (notice.isNull) {
        return;
      }
      int uniqueCode = notice.uniqueCode;
      if (uniqueCodeSet.contains(uniqueCode)) {
        return;
      }
      uniqueCodeSet.add(uniqueCode);
      finalList.add(notice);
    }
    if (noticeList.length != finalList.length) {
      RouteHelper.toast(msg: "已清空无效和相同提醒");
      noticeList = finalList;
    }
  }

  ///  新增提醒 自动跳转到详情页面
  void add() {
    Notice notice = Notice();
    noticeList.add(notice);
    updateFlag.value++;
    (widget as NoticeList).toDetail(notice);
  }

  /// 删除提醒
  void remove(int index) {
    noticeList.removeAt(index);
    updateFlag.value++;
  }
}

/// 提醒列表
class NoticeList extends View<NoticeListLogic> with ObserverWidget {
  NoticeList({
    required String key,
    required NoticeListArgs args,
    required NoticeListDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: NoticeListLogic());

  @override
  void observe(ObserverRouting? routing) {
    if (routing?.isBack == true) {
      logic.onBack();
    }
  }

  @override
  Widget buildView(BuildContext context) {
    return HgNeumorphicScaffold(
      leading: HgNeumorphicBackButton(onPressed: logic.back),
      title: HgNeumorphicText("提醒列表"),
      body: buildNoticeList(),
      bodyPadding: EdgeInsets.zero,
      onAdd: logic.args.state == PageState.browse ? null : logic.add,
    );
  }

  /// 构建已选提醒的列表 已选+新增
  Widget buildNoticeList() {
    return Obx(() {
      // 构建列表
      int updateFlagValue = logic.updateFlag.value;
      debugPrint("提醒列表更新次数:$updateFlagValue");
      List<Notice> noticeList = logic.noticeList;
      return ListView.builder(
        padding: EdgeInsets.only(bottom: Get.height * 0.5),
        clipBehavior: Clip.none,
        itemBuilder: (context, index) {
          Notice notice = noticeList[index];
          return HgNeumorphicButton(
            padding: EdgeInsets.zero,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Removeable(
              key: 'notice_list_$index',
              child: ListTile(
                title: Row(
                  children: [HgNeumorphicIcon(Icons.notifications), Text(notice.toString())],
                ),
                trailing: logic.args.state == PageState.browse ? null : HgNeumorphicNextButton(onPressed: () => toDetail(notice)),
              ),
              onRemove: logic.args.state == PageState.browse ? null : () => logic.remove(index),
            ),
            onPressed: () => toDetail(notice),
          );
        },
        itemCount: noticeList.length,
      );
    });
  }

  /// 提醒详情
  void toDetail(Notice notice) {
    if (logic.args.state == PageState.browse) return;
    if (null == logic.args.navigatorId) {
      RouteHelper.cupertinoBottomSheet(sheet: buildDetail(notice));
    } else {
      RouteHelper.to(page: buildDetail(notice), id: logic.args.navigatorId);
    }
  }

  Widget buildDetail(Notice notice) {
    return NoticeDetail(
      key: notice.hashCode.toString(),
      dataSource: NoticeDetailDataSource(notice: notice),
      args: NoticeDetailArgs(onBack: logic.update, navigatorId: logic.args.navigatorId),
    );
  }
}
