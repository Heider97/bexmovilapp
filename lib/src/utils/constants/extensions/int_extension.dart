import 'dart:math';

extension IntUtil on int {
  int rangeNumber(min, max) {
    var random = Random();
    return min + random.nextInt(max - min);
  }
}