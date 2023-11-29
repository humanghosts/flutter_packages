part of 'state.dart';

class RxSet<T> extends Rx<Set<T>> with SetMixin<T> {
  RxSet([Set<T> initial = const {}]) : super(Set.from(initial));

  /// Special override to push() element(s) in a reactive way
  /// inside the List,
  RxSet<T> operator +(Set<T> val) {
    addAll(val);
    react();
    return this;
  }

  void update(void Function(Iterable<T>? value) fn) {
    fn(value);
    react();
  }

  @override
  @protected
  set value(Set<T> val) {
    if (_value == val) return;
    _value = val;
    react();
  }

  @override
  bool add(T value) {
    final val = _value.add(value);
    react();
    return val;
  }

  @override
  bool contains(Object? element) {
    return value.contains(element);
  }

  @override
  Iterator<T> get iterator => value.iterator;

  @override
  int get length => value.length;

  @override
  T? lookup(Object? element) {
    return value.lookup(element);
  }

  @override
  bool remove(Object? value) {
    var hasRemoved = _value.remove(value);
    if (hasRemoved) {
      react();
    }
    return hasRemoved;
  }

  @override
  Set<T> toSet() {
    return value.toSet();
  }

  @override
  void addAll(Iterable<T> elements) {
    _value.addAll(elements);
    react();
  }

  @override
  void clear() {
    _value.clear();
    react();
  }

  @override
  void removeAll(Iterable<Object?> elements) {
    _value.removeAll(elements);
    react();
  }

  @override
  void retainAll(Iterable<Object?> elements) {
    _value.retainAll(elements);
    react();
  }

  @override
  void retainWhere(bool Function(T) E) {
    _value.retainWhere(E);
    react();
  }
}
