part of 'state.dart';

extension RxNumExt<T extends num> on Rx<T> {
  num operator *(num other) => value * other;

  num operator %(num other) => value % other;

  double operator /(num other) => value / other;

  int operator ~/(num other) => value ~/ other;

  num operator -() => -value;

  num remainder(num other) => value.remainder(other);

  bool operator <(num other) => value < other;

  bool operator <=(num other) => value <= other;

  bool operator >(num other) => value > other;

  bool operator >=(num other) => value >= other;

  bool get isNaN => value.isNaN;

  bool get isNegative => value.isNegative;

  bool get isInfinite => value.isInfinite;

  bool get isFinite => value.isFinite;

  num abs() => value.abs();

  num get sign => value.sign;

  int round() => value.round();

  int floor() => value.floor();

  int ceil() => value.ceil();

  int truncate() => value.truncate();

  double roundToDouble() => value.roundToDouble();

  double floorToDouble() => value.floorToDouble();

  double ceilToDouble() => value.ceilToDouble();

  double truncateToDouble() => value.truncateToDouble();

  num clamp(num lowerLimit, num upperLimit) =>
      value.clamp(lowerLimit, upperLimit);

  int toInt() => value.toInt();

  double toDouble() => value.toDouble();

  String toStringAsFixed(int fractionDigits) =>
      value.toStringAsFixed(fractionDigits);

  String toStringAsExponential([int? fractionDigits]) =>
      value.toStringAsExponential(fractionDigits);

  String toStringAsPrecision(int precision) =>
      value.toStringAsPrecision(precision);
}

extension RxnNumExt<T extends num> on Rx<T?> {
  num? operator *(num other) {
    if (value != null) {
      return value! * other;
    }
    return null;
  }

  num? operator %(num other) {
    if (value != null) {
      return value! % other;
    }
    return null;
  }

  double? operator /(num other) {
    if (value != null) {
      return value! / other;
    }
    return null;
  }

  int? operator ~/(num other) {
    if (value != null) {
      return value! ~/ other;
    }
    return null;
  }

  num? operator -() {
    if (value != null) {
      return -value!;
    }
    return null;
  }

  num? remainder(num other) => value?.remainder(other);

  bool? operator <(num other) {
    if (value != null) {
      return value! < other;
    }
    return null;
  }

  bool? operator <=(num other) {
    if (value != null) {
      return value! <= other;
    }
    return null;
  }

  bool? operator >(num other) {
    if (value != null) {
      return value! > other;
    }
    return null;
  }

  bool? operator >=(num other) {
    if (value != null) {
      return value! >= other;
    }
    return null;
  }

  bool? get isNaN => value?.isNaN;

  bool? get isNegative => value?.isNegative;

  bool? get isInfinite => value?.isInfinite;

  bool? get isFinite => value?.isFinite;

  num? abs() => value?.abs();

  num? get sign => value?.sign;

  int? round() => value?.round();

  int? floor() => value?.floor();

  int? ceil() => value?.ceil();

  int? truncate() => value?.truncate();

  double? roundToDouble() => value?.roundToDouble();

  double? floorToDouble() => value?.floorToDouble();

  double? ceilToDouble() => value?.ceilToDouble();

  double? truncateToDouble() => value?.truncateToDouble();

  num? clamp(num lowerLimit, num upperLimit) =>
      value?.clamp(lowerLimit, upperLimit);

  int? toInt() => value?.toInt();

  double? toDouble() => value?.toDouble();

  String? toStringAsFixed(int fractionDigits) =>
      value?.toStringAsFixed(fractionDigits);

  String? toStringAsExponential([int? fractionDigits]) =>
      value?.toStringAsExponential(fractionDigits);

  String? toStringAsPrecision(int precision) =>
      value?.toStringAsPrecision(precision);
}

class RxNum extends Rx<num> {
  RxNum(num initial) : super(initial);

  num operator +(num other) {
    value += other;
    return value;
  }

  num operator -(num other) {
    value -= other;
    return value;
  }
}

class RxnNum extends Rx<num?> {
  RxnNum([num? initial]) : super(initial);

  num? operator +(num other) {
    if (value != null) {
      value = value! + other;
      return value;
    }
    return null;
  }

  num? operator -(num other) {
    if (value != null) {
      value = value! - other;
      return value;
    }
    return null;
  }
}

extension RxDoubleExt on Rx<double> {
  Rx<double> operator +(num other) {
    value = value + other;
    return this;
  }

  Rx<double> operator -(num other) {
    value = value - other;
    return this;
  }

  double operator *(num other) => value * other;

  double operator %(num other) => value % other;

  double operator /(num other) => value / other;

  int operator ~/(num other) => value ~/ other;

  double operator -() => -value;

  double abs() => value.abs();

  double get sign => value.sign;

  int round() => value.round();

  int floor() => value.floor();

  int ceil() => value.ceil();

  int truncate() => value.truncate();

  double roundToDouble() => value.roundToDouble();

  double floorToDouble() => value.floorToDouble();

  double ceilToDouble() => value.ceilToDouble();

  double truncateToDouble() => value.truncateToDouble();
}

extension RxnDoubleExt on Rx<double?> {
  Rx<double?>? operator +(num other) {
    if (value != null) {
      value = value! + other;
      return this;
    }
    return null;
  }

  Rx<double?>? operator -(num other) {
    if (value != null) {
      value = value! + other;
      return this;
    }
    return null;
  }

  double? operator *(num other) {
    if (value != null) {
      return value! * other;
    }
    return null;
  }

  double? operator %(num other) {
    if (value != null) {
      return value! % other;
    }
    return null;
  }

  double? operator /(num other) {
    if (value != null) {
      return value! / other;
    }
    return null;
  }

  int? operator ~/(num other) {
    if (value != null) {
      return value! ~/ other;
    }
    return null;
  }

  double? operator -() {
    if (value != null) {
      return -value!;
    }
    return null;
  }

  double? abs() {
    return value?.abs();
  }

  double? get sign => value?.sign;

  int? round() => value?.round();

  int? floor() => value?.floor();

  int? ceil() => value?.ceil();

  int? truncate() => value?.truncate();

  double? roundToDouble() => value?.roundToDouble();

  double? floorToDouble() => value?.floorToDouble();

  double? ceilToDouble() => value?.ceilToDouble();

  double? truncateToDouble() => value?.truncateToDouble();
}

class RxDouble extends Rx<double> {
  RxDouble(double initial) : super(initial);
}

class RxnDouble extends Rx<double?> {
  RxnDouble([double? initial]) : super(initial);
}

class RxInt extends Rx<int> {
  RxInt(int initial) : super(initial);

  RxInt operator +(int other) {
    value = value + other;
    return this;
  }

  RxInt operator -(int other) {
    value = value - other;
    return this;
  }
}

class RxnInt extends Rx<int?> {
  RxnInt([int? initial]) : super(initial);

  RxnInt operator +(int other) {
    if (value != null) {
      value = value! + other;
    }
    return this;
  }

  RxnInt operator -(int other) {
    if (value != null) {
      value = value! - other;
    }
    return this;
  }
}

extension RxIntExt on Rx<int> {
  int operator &(int other) => value & other;

  int operator |(int other) => value | other;

  int operator ^(int other) => value ^ other;

  int operator ~() => ~value;

  int operator <<(int shiftAmount) => value << shiftAmount;

  int operator >>(int shiftAmount) => value >> shiftAmount;

  int modPow(int exponent, int modulus) => value.modPow(exponent, modulus);

  int modInverse(int modulus) => value.modInverse(modulus);

  int gcd(int other) => value.gcd(other);

  bool get isEven => value.isEven;

  bool get isOdd => value.isOdd;

  int get bitLength => value.bitLength;

  int toUnsigned(int width) => value.toUnsigned(width);

  int toSigned(int width) => value.toSigned(width);

  int operator -() => -value;

  int abs() => value.abs();

  int get sign => value.sign;

  int round() => value.round();

  int floor() => value.floor();

  int ceil() => value.ceil();

  int truncate() => value.truncate();

  double roundToDouble() => value.roundToDouble();

  double floorToDouble() => value.floorToDouble();

  double ceilToDouble() => value.ceilToDouble();

  double truncateToDouble() => value.truncateToDouble();
}

extension RxnIntExt on Rx<int?> {
  int? operator &(int other) {
    if (value != null) {
      return value! & other;
    }
    return null;
  }

  int? operator |(int other) {
    if (value != null) {
      return value! | other;
    }
    return null;
  }

  int? operator ^(int other) {
    if (value != null) {
      return value! ^ other;
    }
    return null;
  }

  int? operator ~() {
    if (value != null) {
      return ~value!;
    }
    return null;
  }

  int? operator <<(int shiftAmount) {
    if (value != null) {
      return value! << shiftAmount;
    }
    return null;
  }

  int? operator >>(int shiftAmount) {
    if (value != null) {
      return value! >> shiftAmount;
    }
    return null;
  }

  int? modPow(int exponent, int modulus) => value?.modPow(exponent, modulus);

  int? modInverse(int modulus) => value?.modInverse(modulus);

  int? gcd(int other) => value?.gcd(other);

  bool? get isEven => value?.isEven;

  bool? get isOdd => value?.isOdd;

  int? get bitLength => value?.bitLength;

  int? toUnsigned(int width) => value?.toUnsigned(width);

  int? toSigned(int width) => value?.toSigned(width);

  int? operator -() {
    if (value != null) {
      return -value!;
    }
    return null;
  }

  int? abs() => value?.abs();

  int? get sign => value?.sign;

  int? round() => value?.round();

  int? floor() => value?.floor();

  int? ceil() => value?.ceil();

  int? truncate() => value?.truncate();

  double? roundToDouble() => value?.roundToDouble();

  double? floorToDouble() => value?.floorToDouble();

  double? ceilToDouble() => value?.ceilToDouble();

  double? truncateToDouble() => value?.truncateToDouble();
}
