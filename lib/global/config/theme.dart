import 'package:flutter/material.dart';

class FWTheme {
  FWTheme._();

  static const Color black = Colors.black;
  static const Color dark = Color(0xFF1F1F1F);
  static const Color grey = Color(0xFF929292);
  static const Color light = Color(0xFFF5F5F5);
  static const Color white = Colors.white;

  static const fontFamily = 'Noto_Sans_KR';

  static TextTheme textTheme = const TextTheme(
    headlineLarge: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w700,
      fontSize: 32.0,
      height: 40 / 32,
    ),
    headlineMedium: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w700,
      fontSize: 24.0,
      height: 36 / 24,
    ),
    headlineSmall: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w700,
      fontSize: 16.0,
      height: 32 / 16,
    ),
    titleLarge: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 22.0,
      height: 32 / 22,
    ),
    titleMedium: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 16,
      height: 24 / 16,
    ),
    titleSmall: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 14.0,
      height: 20 / 14,
    ),
    labelLarge: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 14.0,
      height: 20 / 14,
    ),
    labelMedium: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 12.0,
      height: 16 / 12,
    ),
    labelSmall: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 11.0,
      height: 16 / 11,
    ),
    bodyLarge: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 16.0,
      height: 24 / 16,
    ),
    bodyMedium: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
      height: 20 / 14,
    ),
    bodySmall: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 12.0,
      height: 16 / 12,
    ),
  );

  static const ColorScheme lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF005EB4),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFD6E3FF),
    onPrimaryContainer: Color(0xFF001B3C),
    secondary: Color(0xFF00687A),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFACEDFF),
    onSecondaryContainer: Color(0xFF001F26),
    tertiary: Color(0xFF785A00),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFFFDF9C),
    onTertiaryContainer: Color(0xFF251A00),
    error: Color(0xFFBA1A1A),
    errorContainer: Color(0xFFFFDAD6),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFF6FEFF),
    onBackground: Color(0xFF001F24),
    surface: Color(0xFFFBFFFF),
    onSurface: Color(0xFF001F24),
    surfaceVariant: Color(0xFFE0E2EC),
    onSurfaceVariant: Color(0xFF43474E),
    outline: Color(0xFF74777F),
    onInverseSurface: Color(0xFFD0F8FF),
    inverseSurface: Color(0xFF00363D),
    inversePrimary: Color(0xFFA8C8FF),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF005EB4),
  );

  static const ColorScheme darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFA8C8FF),
    onPrimary: Color(0xFF003062),
    primaryContainer: Color(0xFF00468A),
    onPrimaryContainer: Color(0xFFD6E3FF),
    secondary: Color(0xFF00D9FD),
    onSecondary: Color(0xFF003640),
    secondaryContainer: Color(0xFF004E5C),
    onSecondaryContainer: Color(0xFFACEDFF),
    tertiary: Color(0xFFF9BD00),
    onTertiary: Color(0xFF3F2E00),
    tertiaryContainer: Color(0xFF5B4300),
    onTertiaryContainer: Color(0xFFFFDF9C),
    error: Color(0xFFFFB4AB),
    errorContainer: Color(0xFF93000A),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color(0xFF001F24),
    onBackground: Color(0xFF97F0FF),
    surface: Color(0xFF001F24),
    onSurface: Color(0xFF97F0FF),
    surfaceVariant: Color(0xFF43474E),
    onSurfaceVariant: Color(0xFFC4C6CF),
    outline: Color(0xFF8E9099),
    onInverseSurface: Color(0xFF001F24),
    inverseSurface: Color(0xFF97F0FF),
    inversePrimary: Color(0xFF005EB4),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFFA8C8FF),
  );
}