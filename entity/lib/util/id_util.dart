import 'package:uuid/uuid.dart';

/// id生成器
abstract class IDGenerator {
  String get id;
}

/// uuid生成器
class UUIDGenerator extends IDGenerator {
  UUIDGenerator._();

  static UUIDGenerator? _instance;

  factory UUIDGenerator() => _instance ??= UUIDGenerator._();

  final Uuid _uuid = const Uuid();

  @override
  String get id => _uuid.v1();
}
