part of 'orm.dart';

/// 存储库
class Repository<T extends Model> {
  /// 存储库名字
  final String name;

  Repository._(this.name);

  factory Repository(String name) => instanceUtil.factory(name, () => Repository._(name));

  /// 构造一个新模型
  T get model => modelRegistry.getByType(T) as T;

  /// 构建表
  /// [ifNotExists] 为true表示表不存在才创建表
  void create({ifNotExists = true}) {
    CommonDatabase? database = dbUtil.database;
    if (null == database) return;
    CreateScheme createScheme = name.createScheme.ifNotExists(ifNotExists).columns(model.attributes.list.map((e) {
          Column col = e.column;
          if (e.name == 'id') col.isPrimary = true;
          return col;
        }).toList());
    String sql = createScheme.sql;
    logUtil.debug(sql);
    database.execute(sql);
  }

  /// 插入数据
  void insert(T data, {Transaction? tx}) {
    CommonDatabase? database = dbUtil.database;
    if (null == database) return;
    InsertScheme insertScheme = InsertScheme().into(name).values(data.attributes.list.map((attribute) => attribute.raw).toList());
    String sql = insertScheme.sql;
    logUtil.debug(sql);
    database.execute(sql);
  }

  /// 查询
  /// [id] id
  /// [tx] 事务
  T? findById(String id, {Transaction? tx, clear = true}) {
    T model = this.model;
    QueryScheme scheme = QueryScheme().selectAll().from(name.from).where((group) {
      group.append(model.id.equals(id));
    });
    return find(scheme, tx: tx, clear: clear)?.firstOrNull;
  }

  /// 查询
  /// [id] id
  /// [tx] 事务
  T? findByIdList(List<String> idList, {Transaction? tx, clear = true}) {
    T model = this.model;
    QueryScheme scheme = QueryScheme().selectAll().from(name.from).where((group) {
      group.append(model.id.inList(idList));
    });
    return find(scheme, tx: tx, clear: clear)?.firstOrNull;
  }

  List<T>? findAll({Transaction? tx, clear = true}) {
    QueryScheme scheme = QueryScheme().selectAll().from(name.from);
    return find(scheme, tx: tx, clear: clear);
  }

  /// 通过查询方案查询数据
  /// [scheme] 查询方案
  /// [tx] 事务
  List<T>? find(QueryScheme scheme, {Transaction? tx, clear = true}) {
    CommonDatabase? database = dbUtil.database;
    if (null == database) return null;
    String sql = scheme.preparedSql;
    List<dynamic> parameters = scheme.parameters;
    // 使用方法返回日志信息，防止不能输出日志的时候可以空耗性能
    logUtil.debug(() => [sql, parameters.map((e) => '${e.toString()}(${e.runtimeType})').toList()]);
    CommonPreparedStatement stmt = database.prepare(sql);
    // 结果集
    ResultSet resultSet = stmt.select(parameters);
    // 处理关联查询的数据
    Map<Type, Set<String>> subModelIdList = {};
    // 处理结果集
    List<T> resultModel = resultSet.map((row) {
      T t;
      T tempT = model;
      String id = row[tempT.id.name];
      if (_ModelCache.has(id)) {
        t = _ModelCache.get(id) as T;
      } else {
        t = tempT;
        _ModelCache.put(t);
      }
      // 按列处理单行数据
      row.forEach((key, value) {
        if (null == value) return;
        Attribute? attribute = t.attributes.get(key);
        if (null == attribute) return;
        // 数据库数据转换为模型数据
        attribute.fromRaw(value);
        Type type = attribute.type;
        // 关联模型获取
        if (attribute is ModelAttribute) {
          Set<String> idList = subModelIdList.putIfAbsent(type, () => {});
          String? subId = attribute.value?.id.value;
          if (null == subId) return;
          if (_ModelCache.has(subId)) return;
          idList.add(subId);
        }
        if (attribute is ModelListAttribute) {
          Set<String> idList = subModelIdList.putIfAbsent(type, () => {});
          for (Model sub in attribute.value) {
            String? subId = sub.id.value;
            if (null == subId) continue;
            if (_ModelCache.has(subId)) continue;
            idList.add(subId);
          }
        }
      });
      return t;
    }).toList();
    // 关联查询
    subModelIdList.forEach((key, value) {
      Repository? repository = repoRegistry.getByType(key)?.call();
      repository?.findByIdList(value.toList(), clear: false);
    });
    // 清空查询缓存
    if (clear) _ModelCache.clear();
    return resultModel;
  }
}

/// 数据缓存，用于处理模型循环引用
class _ModelCache {
  static final Map<String, Model> _cache = {};

  /// 清空缓存
  static void clear() => _cache.clear();

  /// 放置缓存
  static void put(Model model) {
    String? id = model.id.value;
    if (id == null) return;
    _cache[id] = model;
  }

  /// 缓存是否存在
  static bool has(String id) => _cache.containsKey(id);

  /// 获取缓存
  static Model? get<T extends Model>(String id) => _cache[id];
}

extension _ListAttributeEx on ListAttribute {}

extension _AttributeEx on Attribute {
  dynamic get raw {
    if (null == value) return null;
    return switch (this) {
      BooleanAttribute() => value ? 1 : 0,
      DateTimeAttribute() => (value as DateTime).millisecondsSinceEpoch,
      StringAttribute() => value,
      ModelAttribute() => (value as Model).id.raw,
      IntegerAttribute() => value,
      FloatAttribute() => value,
      BooleanListAttribute() => _encode((e) => e ? 1 : 0),
      DateTimeListAttribute() => _encode((e) => (e as DateTime).millisecondsSinceEpoch),
      StringListAttribute() => _encode((e) => e),
      ModelListAttribute() => _encode((e) => (e as Model).id.raw),
      IntegerListAttribute() => _encode((e) => e),
      FloatListAttribute() => _encode((e) => e),
    };
  }

  String _encode(dynamic Function(dynamic e) action) => jsonEncode((value as List).map(action).toList());

  dynamic _decode(dynamic value, dynamic Function(dynamic e) action) => (jsonDecode(value) as List).map(action).toList();

  void fromRaw(dynamic value) {
    if (value == null) {
      this.value = null;
      return;
    }
    switch (this) {
      case BooleanAttribute():
        this.value = value == 0 ? false : true;
        break;
      case DateTimeAttribute():
        this.value = DateTime.fromMillisecondsSinceEpoch(value);
        break;
      case ModelAttribute():
        Model? model = modelRegistry.getByType(type)?.call();
        model?.id.value = value;
        this.value = model;
        break;
      case StringAttribute():
      case IntegerAttribute():
      case FloatAttribute():
        this.value = value;
        break;
      case BooleanListAttribute():
        this.value = _decode(value, (e) => e == 0 ? false : true);
        break;
      case DateTimeListAttribute():
        this.value = _decode(value, (e) => DateTime.fromMillisecondsSinceEpoch(e));
        break;
      case ModelListAttribute():
        this.value = _decode(value, (e) {
          Model? model = modelRegistry.getByType(type)?.call();
          model?.id.value = e;
          return model;
        });
        break;
      case StringListAttribute():
      case IntegerListAttribute():
      case FloatListAttribute():
        this.value = _decode(value, (e) => e);
    }
  }
}
