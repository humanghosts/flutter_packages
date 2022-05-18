import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/service/services.dart';
import 'package:hg_logger/view/page/event/detail/select/base_select_list.dart';

class DeriveSelectListLogic extends EventSelectListLogic<DeriveEvent> {
  @override
  DeriveEventService get service => DeriveEventService.instance;
}

class DeriveSelectList extends EventSelectList<DeriveEvent, DeriveSelectListLogic> {
  DeriveSelectList({
    required String key,
    required EventSelectListArgs<DeriveEvent> args,
    required EventSelectListDataSource<DeriveEvent> dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: DeriveSelectListLogic());
}
