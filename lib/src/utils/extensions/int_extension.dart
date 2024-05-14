import 'dart:math' as math;

extension IntUtil on int {
  int rangeNumber(min, max) {
    var random = math.Random();
    return min + random.nextInt(max - min);
  }

  double degreeToRadian(double degree) {
    return degree * math.pi / 180;
  }

  double radianToDegree(double radian) {
    return radian * 180 / math.pi;
  }
}