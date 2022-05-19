import 'package:flutter/material.dart';
import 'package:hg_logger/view/export.dart';

/// 外部参数
@immutable
class SampleArgs extends ViewArgs {}

/// 外部数据
@immutable
class SampleDataSource extends ViewDataSource {}

/// 逻辑
class SampleLogic extends ViewLogic<SampleArgs, SampleDataSource> {}

/// 页面
class Sample extends View<SampleLogic> {
  Sample({
    required String key,
    required SampleArgs args,
    required SampleDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: SampleLogic());

  @override
  Widget buildView(BuildContext context) {
    return Container();
  }
}
