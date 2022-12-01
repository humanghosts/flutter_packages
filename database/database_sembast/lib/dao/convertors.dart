import 'package:hgs_database_api/database_api.dart' as api;
import 'package:sembast/sembast.dart';

/// sembast转换器
class SembastConvertors extends api.Convertors {
  SembastConvertors._();

  static SembastConvertors? _instance;

  static SembastConvertors get instance {
    _instance ??= SembastConvertors._();
    return _instance!;
  }

  @override
  SembastFilterConvertors get filterConvertor => SembastFilterConvertors.instance;

  @override
  SembastSortConvertors get sortConvertor => SembastSortConvertors.instance;
}

/// sembast数据库的过滤转换器
class SembastFilterConvertors extends api.FilterConvertor<Filter> {
  SembastFilterConvertors._();

  static SembastFilterConvertors? _instance;

  static SembastFilterConvertors get instance => _instance ??= SembastFilterConvertors._();

  @override
  Future<api.Filter?> from(Filter? value) async {
    throw UnimplementedError();
  }

  @override
  Future<Filter?> to(api.Filter? value) async {
    if (null == value) return null;
    return filterConvert(value);
  }

  /// 过滤器转换
  Filter filterConvert(api.Filter filter) {
    if (filter is api.SingleFilter) {
      return convertSingleFilter(filter);
    } else {
      return convertGroupFilter(filter as api.GroupFilter);
    }
  }

  /// 转换单个过滤条件
  Filter convertSingleFilter(api.SingleFilter filter) {
    return Filter.custom((record) => filter.isMatch(record.value));
  }

  /// 转换多个多虑题哦啊金
  Filter convertGroupFilter(api.GroupFilter filter) {
    List<api.Filter> children = filter.children;
    List<Filter> filters = [];
    for (api.Filter child in children) {
      filters.add(filterConvert(child));
    }
    if (filter.op == api.GroupFilterOp.and) {
      return Filter.and(filters);
    } else {
      return Filter.or(filters);
    }
  }
}

/// sembast数据库的排序转换器
class SembastSortConvertors extends api.SortConvertor<SortOrder> {
  SembastSortConvertors._();

  static SembastSortConvertors? _instance;

  static SembastSortConvertors get instance {
    _instance ??= SembastSortConvertors._();
    return _instance!;
  }

  @override
  Future<api.Sort?> from(SortOrder? value) async {
    if (null == value) return null;
    // SortOrder实际上是SembastSorOrder，但是SembastSorOrder不可见，无法获取数据
    throw UnimplementedError();
  }

  @override
  Future<SortOrder?> to(api.Sort? value) async {
    if (null == value) return null;
    return SortOrder(value.field, value.op == api.SortOp.asc);
  }
}
