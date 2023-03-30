import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      // appBarTheme: const AppBarTheme(
      //   elevation: 4,
      //   color: Colors.white,
      // ),
      // scaffoldBackgroundColor: Colors.white,
      // // primaryColor: Colors.black,
      // splashColor: Colors.transparent,
      fontFamily: 'IBM',
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFFAF3100),
        onPrimary: Color(0xFFFFFFFF),
        primaryContainer: Color(0xFFFFDBD1),
        onPrimaryContainer: Color(0xFF3A0A00),
        secondary: Color(0xFF77574D),
        onSecondary: Color(0xFFFFFFFF),
        secondaryContainer: Color(0xFFFFDBD1),
        onSecondaryContainer: Color(0xFF2C150F),
        tertiary: Color(0xFF6B5D2F),
        onTertiary: Color(0xFFFFFFFF),
        tertiaryContainer: Color(0xFFF5E2A7),
        onTertiaryContainer: Color(0xFF231B00),
        error: Color(0xFFBA1A1A),
        errorContainer: Color(0xFFFFDAD6),
        onError: Color(0xFFFFFFFF),
        onErrorContainer: Color(0xFF410002),
        background: Color(0xFFFFFBFF),
        onBackground: Color(0xFF201A18),
        surface: Color(0xFFFFFBFF),
        onSurface: Color(0xFF201A18),
        surfaceVariant: Color(0xFFF5DED7),
        onSurfaceVariant: Color(0xFF53433F),
        outline: Color(0xFF85736E),
        onInverseSurface: Color(0xFFFBEEEA),
        inverseSurface: Color(0xFF362F2D),
        inversePrimary: Color(0xFFFFB59F),
        shadow: Color(0xFF000000),
        surfaceTint: Color(0xFFAF3100),
        outlineVariant: Color(0xFFD8C2BC),
        scrim: Color(0xFF000000),
      ),
      // colorSchemeSeed: Colors.orange[700]
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'IBM',
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFFFFB59F),
        onPrimary: Color(0xFF5F1600),
        primaryContainer: Color(0xFF862300),
        onPrimaryContainer: Color(0xFFFFDBD1),
        secondary: Color(0xFFE7BDB1),
        onSecondary: Color(0xFF442A22),
        secondaryContainer: Color(0xFF5D4037),
        onSecondaryContainer: Color(0xFFFFDBD1),
        tertiary: Color(0xFFD8C68D),
        onTertiary: Color(0xFF3A2F05),
        tertiaryContainer: Color(0xFF524619),
        onTertiaryContainer: Color(0xFFF5E2A7),
        error: Color(0xFFFFB4AB),
        errorContainer: Color(0xFF93000A),
        onError: Color(0xFF690005),
        onErrorContainer: Color(0xFFFFDAD6),
        background: Color(0xFF201A18),
        onBackground: Color(0xFFEDE0DC),
        surface: Color(0xFF201A18),
        onSurface: Color(0xFFEDE0DC),
        surfaceVariant: Color(0xFF53433F),
        onSurfaceVariant: Color(0xFFD8C2BC),
        outline: Color(0xFFA08C87),
        onInverseSurface: Color(0xFF201A18),
        inverseSurface: Color(0xFFEDE0DC),
        inversePrimary: Color(0xFFAF3100),
        shadow: Color(0xFF000000),
        surfaceTint: Color(0xFFFFB59F),
        outlineVariant: Color(0xFF53433F),
        scrim: Color(0xFF000000),
      )
    );
  }
}
