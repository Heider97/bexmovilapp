// import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';

import '../utils/constants/colors.dart';

class AppColors {
  static Color primarySeedColor = const Color(0xFF192256);
  static Color secondarySeedColor = const Color(0xFF9C254D);

  static const ColorScheme schemeLight = ColorScheme(
    brightness: Brightness.light,
    primary: ColorLight.primary,
    onPrimary: ColorLight.onPrimary,
    secondary: ColorLight.secondary,
    onSecondary: ColorLight.onSecondary,
    tertiary: ColorLight.tertiary,
    background: ColorLight.background,
    error: ColorLight.error,
    onError: ColorLight.onError,
    onBackground: ColorLight.onBackground,
    surface: ColorLight.surface,
    onSurface: ColorLight.onSurface,
  );

  static const ColorScheme schemeDark = ColorScheme(
    brightness: Brightness.dark,
    primary: ColorDark.primary,
    onPrimary: ColorDark.onPrimary,
    secondary: ColorDark.onPrimary,
    onSecondary: ColorDark.onSecondary,
    background: ColorDark.background,
    error: ColorDark.error,
    onError: ColorDark.onError,
    onBackground: ColorDark.onBackground,
    surface: ColorDark.surface,
    onSurface: ColorDark.onSurface,
  );

  // static final ColorScheme schemeLight = SeedColorScheme.fromSeeds(
  //   brightness: Brightness.light,
  //   primaryKey: primarySeedColor,
  //   secondaryKey: secondarySeedColor,
  //   // tones: FlexTones.vivid(Brightness.light),
  // );

  // static final ColorScheme schemeDark = SeedColorScheme.fromSeeds(
  //   brightness: Brightness.dark,
  //   primaryKey: primarySeedColor,
  //   secondaryKey: secondarySeedColor,
  //   tones: FlexTones.vivid(Brightness.dark),
  // );

  static const appColorSchemeLight = schemeLight;
  static const appColorSchemeDark = schemeDark;

  static Color getShade(Color color, {bool darker = false, double value = .1}) {
    assert(value >= 0 && value <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness(
        (darker ? (hsl.lightness - value) : (hsl.lightness + value))
            .clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  static MaterialColor getMaterialColorFromColor(Color color) {
    Map<int, Color> colorShades = {
      50: getShade(color, value: 0.5),
      100: getShade(color, value: 0.4),
      200: getShade(color, value: 0.3),
      300: getShade(color, value: 0.2),
      400: getShade(color, value: 0.1),
      500: color,
      600: getShade(color, value: 0.1, darker: true),
      700: getShade(color, value: 0.15, darker: true),
      800: getShade(color, value: 0.2, darker: true),
      900: getShade(color, value: 0.25, darker: true),
    };
    return MaterialColor(color.value, colorShades);
  }
}
