import 'package:database_api/database_api.dart';
import 'package:entity/entity.dart';

/// 过滤条件的custom_value类型，用于model的attribute的value
abstract class FilterValue implements CustomValue {
  Filter? asFilter();
}

/// 单个过滤条件
class SingleFilterValue implements FilterValue {
  SingleFilter? filter;

  SingleFilterValue({this.filter});

  @override
  bool get isNull => null == filter;

  @override
  SingleFilterValue merge(CustomValue value) {
    if (value is SingleFilterValue) {
      filter = value.filter;
    }
    return this;
  }

  @override
  Future<Object?> toMap({Map<String, Object?>? args}) async {
    // 参数
    Transaction? tx = args?["tx"] as Transaction?;
    bool? isLogicDelete = args?["isLogicDelete"] as bool?;
    // 过滤器
    SingleFilter? filter = this.filter;
    if (null == filter) return null;
    List<Object> filterValueList = filter.value;
    List<Object> value = filterValueList;
    // 注册过构造器的类型需要转换一下值
    if (ConstructorCache.containsKey(filter.valueType)) {
      // 获取转换器
      ValueConvertors convertors = ValueConvertors.instance;
      // 新建一个对象
      Object obj = ConstructorCache.get(filter.valueType);
      value = <Object>[];
      // 遍历过滤器的值
      for (Object filterValue in filterValueList) {
        // 数据模型类型
        if (obj is DataModel?) {
          // 列表类型
          if (filterValue is List) {
            value.add(filterValue.map((e) => convertors.attributeConvertors.dataModel.getValue(e)).toList());
          }
          // 单值类型
          else {
            value.add(convertors.attributeConvertors.dataModel.getValue(filterValue as DataModel));
          }
        }
        // 简单模型类型
        else if (obj is SimpleModel?) {
          // 列表类型
          if (filterValue is List) {
            List<Object> innerValueList = [];
            for (Object one in filterValue) {
              Object? innerValue = await convertors.modelConvertors.getValue(
                one as SimpleModel,
                tx: tx,
                isLogicDelete: isLogicDelete,
              );
              if (null == innerValue) continue;
              innerValueList.add(innerValue);
            }
            value.add(innerValueList);
          }
          // 单值类型
          else {
            Object? innerValue = await convertors.modelConvertors.getValue(
              filterValue as SimpleModel,
              tx: tx,
              isLogicDelete: isLogicDelete,
            );
            value.add(innerValue!);
          }
        }
        // 自定义值类型
        else if (obj is CustomValue?) {
          // 列表类型
          if (filterValue is List) {
            List customValueList = [];
            for (CustomValue customValue in filterValue) {
              Object? mapValue = await customValue.toMap(args: args);
              if (null == mapValue) continue;
              customValueList.add(mapValue);
            }
            value.add(customValueList);
          }
          // 单值类型
          else {
            Object? mapValue = await (filterValue as CustomValue).toMap(args: args);
            if (null == mapValue) continue;
            value.add(mapValue);
          }
        }
      }
    }

    return {
      "field": filter.field,
      "op": filter.op.value,
      "value": value,
      "valueType": filter.valueType.toString(),
    };
  }

  @override
  Future<SingleFilterValue> fromMap(Object? value, {Map<String, Object?>? args}) async {
    if (value is! Map) {
      return this;
    }
    // 参数
    Transaction? tx = args?["tx"] as Transaction?;
    bool? isLogicDelete = args?["isLogicDelete"] as bool?;

    // 字段
    String field = value["field"];
    // 操作符
    String opSymbol = value["op"];
    SingleFilterOp op = SingleFilterOp.map[opSymbol]!;
    // 过滤器
    SingleFilter filter = SingleFilter(field: field, op: op);
    this.filter = filter;
    // 值列表
    List mapValueList = value["value"];
    if (mapValueList.isEmpty) {
      return this;
    }
    // 值类型
    String valueType = value["valueType"];
    // 实体类型
    if (ConstructorCache.containsKeyStr(valueType)) {
      // 获取转换器
      ValueConvertors convertors = ValueConvertors.instance;
      // 原始值类型
      Object obj = ConstructorCache.getByStr(valueType);
      // 遍历所有值
      for (Object mapValue in mapValueList) {
        // 数据模型
        if (obj is DataModel?) {
          DataDao<DataModel> dao = DaoCache.getByStr(valueType) as DataDao<DataModel>;
          if (mapValue is List) {
            List<String> idList = mapValue.map((e) => e.toString()).toList();
            filter.appendList(await dao.findByIDList(idList, tx: tx, isLogicDelete: isLogicDelete));
          } else {
            Object? result = await dao.findByID(mapValue as String, tx: tx, isLogicDelete: isLogicDelete);
            if (null != result) {
              // result为空，说明这个id的数据被删除了，不用管了，相当于惰性删除
              filter.append(result);
            }
          }
        }
        // 简单模型
        else if (obj is SimpleModel?) {
          Type type = ConstructorCache.getType(valueType);
          if (mapValue is List) {
            List<SimpleModel> oneValueAsList = [];
            for (Object oneMapValue in mapValue) {
              oneValueAsList.add(await convertors.modelConvertors.getModelByType(
                type,
                oneMapValue,
                tx: tx,
                isLogicDelete: isLogicDelete,
              ) as SimpleModel);
            }
            filter.appendList(oneValueAsList);
          } else {
            filter.append(await convertors.modelConvertors.getModelByType(
              type,
              mapValue,
              tx: tx,
              isLogicDelete: isLogicDelete,
            ) as SimpleModel);
          }
        }
        // 自定义值类型
        else if (obj is CustomValue?) {
          if (mapValue is List) {
            List<CustomValue> oneValueAsList = [];
            for (Object oneMapValue in mapValue) {
              CustomValue customValue = ConstructorCache.getByStr(valueType);
              await customValue.fromMap(oneMapValue, args: args);
              oneValueAsList.add(customValue);
            }
            filter.appendList(oneValueAsList);
          } else {
            CustomValue customValue = ConstructorCache.getByStr(valueType);
            await customValue.fromMap(mapValue, args: args);
            filter.append(customValue);
          }
        }
        // 其它实体类型
        else {
          if (mapValue is List) {
            filter.appendList(mapValue);
          } else {
            filter.append(mapValue);
          }
        }
      }
    }
    // 其它类型
    else {
      for (Object oneValue in mapValueList) {
        if (oneValue is List) {
          filter.appendList(oneValue);
        } else {
          filter.append(oneValue);
        }
      }
    }
    return this;
  }

  @override
  SingleFilterValue clone() => SingleFilterValue(filter: filter?.clone());

  @override
  SingleFilter? asFilter() => filter;

  @override
  String toString() {
    if (null == filter) {
      return "";
    }
    return filter.toString();
  }
}

/// 多个过滤条件
class GroupFilterValue implements FilterValue {
  GroupFilterOp op = GroupFilterOp.and;
  late List<FilterValue> filters;

  GroupFilterValue({this.op = GroupFilterOp.and, List<FilterValue>? filters}) {
    this.filters = filters ?? [];
  }

  @override
  bool get isNull => filters.isEmpty;

  @override
  GroupFilterValue merge(CustomValue value) {
    if (value is GroupFilterValue) {
      op = value.op;
      filters.clear();
      filters.addAll(value.filters);
    }
    return this;
  }

  @override
  Future<Object?> toMap({Map<String, Object?>? args}) async {
    if (filters.isEmpty) return null;
    List<Map> childrenMap = [];
    for (FilterValue child in filters) {
      String type = child.runtimeType.toString();
      Object? value = await child.toMap(args: args);
      if (value == null) {
        continue;
      }
      childrenMap.add({
        "type": type,
        "value": value,
      });
    }
    return {
      "op": op.value,
      "children": childrenMap,
    };
  }

  @override
  Future<GroupFilterValue> fromMap(Object? value, {Map<String, Object?>? args}) async {
    if (value is! Map) {
      return this;
    }
    String opSymbol = value["op"];
    op = GroupFilterOp.map[opSymbol]!;
    List children = value["children"];
    filters.clear();
    for (Map child in children) {
      String type = child["type"];
      Map value = child["value"] as Map;
      FilterValue customValue = ConstructorCache.getByStr(type);
      await customValue.fromMap(value, args: args);
      filters.add(customValue);
    }
    return this;
  }

  @override
  GroupFilterValue clone() {
    GroupFilterValue newFilterValue = GroupFilterValue();
    newFilterValue.op = op;
    for (FilterValue filter in filters) {
      newFilterValue.filters.add(filter.clone() as FilterValue);
    }
    return newFilterValue;
  }

  @override
  GroupFilter? asFilter() {
    GroupFilter groupFilter = GroupFilter(op: op);
    for (FilterValue child in filters) {
      Filter? filter = child.asFilter();
      if (null != filter) {
        groupFilter.children.add(filter);
      }
    }
    return groupFilter;
  }

  @override
  String toString() {
    if (filters.isEmpty) {
      return "${op.name}:[]";
    }
    StringBuffer sb = StringBuffer();
    sb.writeln("${op.name}:[");
    for (var child in filters) {
      sb.writeln("  ${child.toString()},");
    }
    sb.write("]");
    return sb.toString();
  }
}
