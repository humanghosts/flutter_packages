part of 'state.dart';

class RxMap<K, V> extends Rx<Map<K, V>> with MapMixin<K, V> {
  RxMap([Map<K, V> initial = const {}]) : super(Map.from(initial));

  factory RxMap.from(Map<K, V> other) {
    return RxMap(Map.from(other));
  }

  factory RxMap.of(Map<K, V> other) {
    return RxMap(Map.of(other));
  }

  factory RxMap.unmodifiable(Map<dynamic, dynamic> other) {
    return RxMap(Map.unmodifiable(other));
  }

  factory RxMap.identity() {
    return RxMap(Map.identity());
  }

  @override
  V? operator [](Object? key) {
    return value[key as K];
  }

  @override
  void operator []=(K key, V value) {
    _value[key] = value;
    react();
  }

  @override
  void clear() {
    _value.clear();
    react();
  }

  @override
  Iterable<K> get keys => value.keys;

  @override
  V? remove(Object? key) {
    final val = _value.remove(key);
    react();
    return val;
  }
}
