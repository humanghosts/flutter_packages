part of 'state.dart';

extension RxString on String {
  Rx<String> get obs => Rx<String>(this);
}

extension RxIntEx on int {
  RxInt get obs => RxInt(this);
}

extension RxDoubleEx on double {
  Rx<double> get obs => Rx<double>(this);
}

extension RxBool on bool {
  Rx<bool> get obs => Rx<bool>(this);
}

extension ListTxtension<T> on List<T> {
  RxList<T> get obs => RxList<T>(this);
}

extension MapExtension<K, V> on Map<K, V> {
  RxMap<K, V> get obs => RxMap<K, V>(this);
}

extension SetExtension<E> on Set<E> {
  RxSet<E> get obs {
    return RxSet<E>(<E>{})..addAll(this);
  }
}

extension RxT<T> on T {
  Rx<T> get obs => Rx<T>(this);
}
