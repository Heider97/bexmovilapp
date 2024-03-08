import 'dart:math';

import 'package:flutter/material.dart';

class AppSize {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;
  static TextScaler? textScaler;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    orientation = _mediaQueryData!.orientation;
    textScaler = _mediaQueryData!.textScaler;
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  final screenHeight = AppSize.screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight!;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  final screenWidth = AppSize.screenWidth;
  // 375 is the layout width that designer use

  return (inputWidth / 375.0) * screenWidth!;
}

double? getFullScreenHeight() {
  return AppSize.screenHeight;
}

double? getFullScreenWidth() {
  return AppSize.screenWidth;
}

TextScaler? getTextScaleFactor() {
  return AppSize.textScaler;
}

double textScaleFactor(BuildContext context, {double maxTextScaleFactor = 2}) {
  final width = AppSize.screenWidth;
  final height = AppSize.screenHeight;
  var val = (width! / height!) * maxTextScaleFactor;
  return max(1, min(val, maxTextScaleFactor));
}
