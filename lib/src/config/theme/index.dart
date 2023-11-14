import 'package:bexmovil/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData get light {
    return ThemeData(
        useMaterial3: true,
        fontFamily: 'Benton',
        colorScheme: const ColorScheme(
          primary: ColorLight.primary,
          onPrimary: ColorLight.onPrimary,
          secondary: ColorLight.secondary,
          onSecondary: ColorLight.onSecondary,
          tertiary: ColorLight.tertiary,
          brightness: Brightness.light,
          background: ColorLight.background,
          error: ColorLight.error,
          onError: ColorLight.onError,
          onBackground: ColorLight.onBackground,
          surface: ColorLight.surface,
          onSurface: ColorLight.onSurface,
        ),
        disabledColor: ColorLight.disabledButton,
        buttonTheme: const ButtonThemeData(
          disabledColor: ColorLight.disabledButton,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF201A18),
          ),
          bodyLarge: TextStyle(
            fontSize: 16.0,
            color: Color(0xFF201A18),
          ),
          bodyMedium: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.normal,
            color: Color(0xFF201A18),
          ),
          bodySmall: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.normal,
            color: Color(0xFF201A18),
          ),
          displayMedium: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF201A18),
          ),
          displaySmall: TextStyle(
            fontSize: 10.0,
            color: Color(0xFF201A18),
          ),
          labelSmall: TextStyle(
              fontSize: 8.0,
              color: Color(0xFF201A18),
              fontWeight: FontWeight.w300),
          labelMedium: TextStyle(
              fontSize: 12.0,
              color: Color(0xFF201A18),
              fontWeight: FontWeight.w300),
        ));
  }

  static ThemeData get dark {
    return ThemeData(
        useMaterial3: true,
        fontFamily: 'Benton',
        colorScheme: const ColorScheme(
          primary: ColorDark.primary,
          onPrimary: ColorDark.onPrimary,
          secondary: ColorDark.secondary,
          onSecondary: ColorDark.onSecondary,
          brightness: Brightness.light,
          background: ColorDark.background,
          error: ColorDark.error,
          onError: ColorDark.onError,
          onBackground: ColorDark.onBackground,
          surface: ColorDark.surface,
          onSurface: ColorDark.onSurface,
        ),
        textTheme: const TextTheme(
            displayLarge: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF201A18),
            ),
            bodyLarge: TextStyle(
              fontSize: 16.0,
              color: Color(0xFF201A18),
            ),
            bodyMedium: TextStyle(
              fontSize: 10.0,
              color: Color(0xFF201A18),
            )));
  }
}
