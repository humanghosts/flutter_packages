part of '../orm.dart';

/// 事务
class Transaction {
  Object transaction;

  Transaction(this.transaction);

  static T getOr<T>(Transaction? tx, T defaultTx) {
    if (null == tx) {
      return defaultTx;
    }
    return tx.transaction as T;
  }

  T getTx<T>() => transaction as T;
}

RepositoryCache repositoryCache = RepositoryCache();

class RepositoryCache {
  RepositoryCache._();

  factory RepositoryCache() => instanceUtil.singleton(RepositoryCache._);

  final Map<String, BaseRepository> _cache = {};

  void put<T>(Type type, BaseRepository repository) {
    String typeStr = type.toString();
    String realTypeStr;
    if (type.toString().endsWith("?")) {
      realTypeStr = typeStr.substring(0, typeStr.length - 1);
    } else {
      realTypeStr = typeStr;
    }
    String realTypeStrNullable = "$realTypeStr?";
    _cache[realTypeStr] = repository;
    _cache[realTypeStrNullable] = repository;
  }

  T? get<T extends BaseRepository>(Type type) => _cache[type.toString()] as T?;
}

/// 仓储基类
abstract class BaseRepository<T extends Model> {
  /// 存储库名字
  String get name;

  T newModel();

  BaseRepository() {
    repositoryCache.put(T, this);
  }

  /// 构建表
  void create({ifNotExists = true}) {
    Database? database = dbUtil.database;
    if (null == database) return;
    CreateScheme createScheme = name.createScheme.ifNotExists(ifNotExists).columns(newModel().attributes.list.map((e) {
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
    Database? database = dbUtil.database;
    if (null == database) return;
    InsertScheme insertScheme = InsertScheme().into(name).values(data.toValues());
    String sql = insertScheme.sql;
    logUtil.debug(sql);
    database.execute(sql);
  }

  /// 查询
  /// [id] id
  /// [tx] 事务
  T? findById(String id, {Transaction? tx}) {
    T model = newModel();
    QueryScheme scheme = QueryScheme().selectAll().from(name.from).where((group) {
      group.append(model.id.equals(id));
    });
    return find(scheme, tx: tx)?.firstOrNull;
  }

  List<T>? findAll({Transaction? tx}) {
    QueryScheme scheme = QueryScheme().selectAll().from(name.from);
    return find(scheme, tx: tx);
  }

  /// 通过查询方案查询数据
  /// [scheme] 查询方案
  /// [tx] 事务
  List<T>? find(QueryScheme scheme, {Transaction? tx}) {
    Database? database = dbUtil.database;
    if (null == database) return null;
    String sql = scheme.preparedSql;
    List<dynamic> parameters = scheme.parameters;
    // 使用方法返回日志信息，防止不能输出日志的时候可以空耗性能
    logUtil.debug(() => [sql, parameters.map((e) => '${e.toString()}(${e.runtimeType})').toList()]);
    PreparedStatement stmt = database.prepare(sql);
    ResultSet resultSet = stmt.select(parameters);
    return resultSet.map(rowToModel).toList();
  }

  /// 数据库数据转换为实体
  /// [row] 数据库行数据
  T rowToModel(Row row) => newModel().fromRow(row) as T;
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
        this.value = repositoryCache.get(type)?.findById(value);
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
        this.value = _decode(value, (e) => repositoryCache.get(type)?.findById(value));
        break;
      case StringListAttribute():
      case IntegerListAttribute():
      case FloatListAttribute():
        this.value = _decode(value, (e) => e);
    }
  }
}

/// BaseModel的扩展
extension _ModelRowEx on Model {
  Model fromRow(Row row) {
    row.forEach((key, value) {
      if (null == value) return;
      Attribute? attribute = attributes.get(key);
      if (null == attribute) return;
      attribute.fromRaw(value);
    });
    return this;
  }

  List<dynamic> toValues() {
    return attributes.list.map((attribute) => attribute.raw).toList();
  }
}
