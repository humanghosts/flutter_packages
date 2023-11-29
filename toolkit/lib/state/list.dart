part of 'state.dart';

class RxList<T> extends Rx<List<T>> with ListMixin<T> {
  RxList([List<T> initial = const []]) : super(List.from(initial));

  factory RxList.filled(int length, T fill, {bool growable = false}) {
    return RxList(List.filled(length, fill, growable: growable));
  }

  factory RxList.empty({bool growable = false}) {
    return RxList(List.empty(growable: growable));
  }

  factory RxList.from(Iterable elements, {bool growable = true}) {
    return RxList(List.from(elements, growable: growable));
  }

  factory RxList.of(Iterable<T> elements, {bool growable = true}) {
    return RxList(List.of(elements, growable: growable));
  }

  factory RxList.generate(int length, T Function(int index) generator,
      {bool growable = true}) {
    return RxList(List.generate(length, generator, growable: growable));
  }

  factory RxList.unmodifiable(Iterable elements) {
    return RxList(List.unmodifiable(elements));
  }

  @override
  Iterator<T> get iterator => value.iterator;

  @override
  void operator []=(int index, T val) {
    _value[index] = val;
    react();
  }

  /// Special override to push() element(s) in a reactive way
  /// inside the List,
  @override
  RxList<T> operator +(Iterable<T> val) {
    addAll(val);
    react();
    return this;
  }

  @override
  T operator [](int index) {
    return value[index];
  }

  @override
  void add(T element) {
    _value.add(element);
    react();
  }

  @override
  void addAll(Iterable<T> iterable) {
    _value.addAll(iterable);
    react();
  }

  @override
  void removeWhere(bool Function(T element) test) {
    _value.removeWhere(test);
    react();
  }

  @override
  void retainWhere(bool Function(T element) test) {
    _value.retainWhere(test);
    react();
  }

  @override
  int get length => value.length;

  @override
  set length(int newLength) {
    _value.length = newLength;
    react();
  }

  @override
  void insertAll(int index, Iterable<T> iterable) {
    _value.insertAll(index, iterable);
    react();
  }

  @override
  Iterable<T> get reversed => value.reversed;

  @override
  Iterable<T> where(bool Function(T) test) {
    return value.where(test);
  }

  @override
  Iterable<T> whereType<T>() {
    return value.whereType<T>();
  }

  @override
  void sort([int Function(T a, T b)? compare]) {
    _value.sort(compare);
    react();
  }
}
