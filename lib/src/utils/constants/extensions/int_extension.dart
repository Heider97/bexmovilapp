import 'dart:math';

extension IntUtil on Random {
  int rangeNumber(min, max) {
    var random = Random();
    return min + random.nextInt(max - min);
  }
}