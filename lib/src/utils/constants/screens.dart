import 'package:flutter/material.dart';

class Screens {
  static double heigth(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
