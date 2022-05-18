import 'package:flutter/material.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/export.dart';

import '../../card/card.dart';

/// 外部参数
@immutable
class DeriveDetailOriginEditorArgs extends ViewArgs {
  final void Function(OriginEvent origin)? onTap;

  final PageState state;

  const DeriveDetailOriginEditorArgs({
    this.onTap,
    required this.state,
  });
}

/// 外部数据
@immutable
class DeriveDetailOriginEditorDataSource extends ViewDataSource {
  final OriginEvent origin;
  final EventConfig config;

  const DeriveDetailOriginEditorDataSource({required this.origin, required this.config});
}

/// 逻辑
class DeriveDetailOriginEditorLogic extends ViewLogic<DeriveDetailOriginEditorArgs, DeriveDetailOriginEditorDataSource> {}

/// 页面
class DeriveDetailOriginEditor extends View<DeriveDetailOriginEditorLogic> {
  DeriveDetailOriginEditor({
    required String key,
    required DeriveDetailOriginEditorArgs args,
    required DeriveDetailOriginEditorDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: DeriveDetailOriginEditorLogic());

  @override
  Widget buildView(BuildContext context) {
    OriginEvent origin = logic.dataSource.origin;
    return EventCard<OriginEvent>(
      key: "${logic.key}_event_detail_origin_${origin.id.value}",
      dataSource: EventCardDataSource(event: origin, config: logic.dataSource.config),
      args: EventCardArgs(onTap: logic.args.onTap, state: logic.args.state),
    );
  }
}
