import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/service/services.dart';
import 'package:hg_logger/view/page/event/detail/select/base_select_list.dart';

class OriginSelectListLogic extends EventSelectListLogic<OriginEvent> {
  @override
  OriginEventService get service => OriginEventService.instance;
}

class OriginSelectList extends EventSelectList<OriginEvent, OriginSelectListLogic> {
  OriginSelectList({
    required String key,
    required EventSelectListArgs<OriginEvent> args,
    required EventSelectListDataSource<OriginEvent> dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: OriginSelectListLogic());
}
