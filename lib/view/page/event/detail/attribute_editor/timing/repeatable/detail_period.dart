import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_logger/ability/route/route.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/export.dart';

import '../base/detail_period.dart';
import 'repeat_detail.dart';

class RepeatableTimingDetailPeriodLogic extends TimingDetailPeriodLogic<RepeatableTiming> {
  /// 重复规则更新标识
  Rx<int> repeatUpdateFlag = 0.obs;

  @override
  void afterArgsUpdate() {
    repeatUpdateFlag.value = 0;
    super.afterArgsUpdate();
  }

  /// 清空重复
  void clearRepeat() {
    dataSource.timing.repeatRule.clear();
    repeatUpdateFlag.value++;
  }

  /// 重复规则修改
  void onRepeatChanged() {
    repeatUpdateFlag.value++;
  }
}

class RepeatableTimingDetailPeriod extends TimingDetailPeriod<RepeatableTiming, RepeatableTimingDetailPeriodLogic> {
  RepeatableTimingDetailPeriod({
    required String key,
    required TimingDetailPeriodArgs args,
    required TimingDetailPeriodDataSource<RepeatableTiming> dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: RepeatableTimingDetailPeriodLogic());

  /// 额外组件
  @override
  List<Widget> buildExtend() => [buildRepeat()];

  /// 构建重复行
  Widget buildRepeat() {
    CustomAttribute<RepeatRule> repeatRule = logic.dataSource.timing.repeatRule;
    return Obx(() {
      int repeatUpdateFlag = logic.repeatUpdateFlag.value;
      debugPrint("时间重复规则更新次数:$repeatUpdateFlag");
      return NeumorphicFormField(
        title: Row(children: [HgNeumorphicIcon(Icons.repeat), Text(repeatRule.title)]),
        hintText: "重复选择",
        initValue: repeatRule.value.toString(),
        readOnly: logic.args.state == PageState.browse,
        onTap: toRepeat,
        onClear: repeatRule.isNull ? null : logic.clearRepeat,
      );
    });
  }

  /// 打开重复界面
  void toRepeat() {
    if (null == logic.args.navigatorId) {
      RouteHelper.cupertinoBottomSheet(sheet: buildRepeatPage());
    } else {
      RouteHelper.to(page: buildRepeatPage(), id: logic.args.navigatorId);
    }
  }

  /// 重复界面组件
  Widget buildRepeatPage() {
    CustomAttribute<RepeatRule> repeatRule = logic.dataSource.timing.repeatRule;
    return RepeatDetail(
      key: repeatRule.hashCode.toString(),
      dataSource: RepeatDetailDataSource(repeatRule: repeatRule.value),
      args: RepeatDetailArgs(onBack: logic.onRepeatChanged, navigatorId: logic.args.navigatorId),
    );
  }
}
