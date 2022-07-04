import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FWTheme extends GetxController {
  // FWTheme._();

  ThemeMode mode = ThemeMode.light;

  void toggleMode() {
    mode = ThemeMode.values.lastWhere((value) => value != mode);
    update();
  }

  /// colors
  // simple
  static const Color black = Colors.black;
  static const Color dark = Color(0xFF1F1F1F);
  static const Color grey = Color(0xFF929292);
  static const Color light = Color(0xFFF5F5F5);
  static const Color white = Colors.white;

  // materialColor
  static const MaterialColor primary = MaterialColor(0xFF2692FF, {
    100: Color(0xFFFFFFFF),
    99: Color(0xFFFDFCFF),
    95: Color(0xFFEBF1FF),
    90: Color(0xFFD4E3FF),
    80: Color(0xFFA5C8FF),
    70: Color(0xFF72ADFF),
    60: Color(0xFF2692FF),
    50: Color(0xFF0078DA),
    40: Color(0xFF005FAF),
    30: Color(0xFF004786),
    20: Color(0xFF00315F),
    10: Color(0xFF001C3A),
    0: Color(0xFF000000),
  });

  static const MaterialColor secondary = MaterialColor(0xFF009BD2, {
    100: Color(0xFFFFFFFF),
    99: Color(0xFFFBFCFF),
    95: Color(0xFFE3F3FF),
    90: Color(0xFFC4E7FF),
    80: Color(0xFF7DD0FF),
    70: Color(0xFF00B7F8),
    60: Color(0xFF009BD2),
    50: Color(0xFF0080AE),
    40: Color(0xFF00658B),
    30: Color(0xFF004C69),
    20: Color(0xFF00344A),
    10: Color(0xFF001E2D),
    0: Color(0xFF000000),
  });

  static const MaterialColor tertiary = MaterialColor(0xFF00A0B0, {
    100: Color(0xFFFFFFFF),
    99: Color(0xFFF6FEFF),
    95: Color(0xFFD0F8FF),
    90: Color(0xFF97F0FF),
    80: Color(0xFF4FD8EB),
    70: Color(0xFF22BCCF),
    60: Color(0xFF00A0B0),
    50: Color(0xFF008391),
    40: Color(0xFF006874),
    30: Color(0xFF004F58),
    20: Color(0xFF00363D),
    10: Color(0xFF001F24),
    0: Color(0xFF000000),
  });

  static const MaterialColor error = MaterialColor(0xFFFF5449, {
    100: Color(0xFFFFFFFF),
    99: Color(0xFFFFFBFF),
    95: Color(0xFFFFEDEA),
    90: Color(0xFFFFDAD6),
    80: Color(0xFFFFB4AB),
    70: Color(0xFFFF897D),
    60: Color(0xFFFF5449),
    50: Color(0xFFDE3730),
    40: Color(0xFFBA1A1A),
    30: Color(0xFF93000A),
    20: Color(0xFF690005),
    10: Color(0xFF410002),
    0: Color(0xFF000000),
  });

  static const MaterialColor neutral = MaterialColor(0xFF909094, {
    100: Color(0xFFFFFFFF),
    99: Color(0xFFFDFCFF),
    95: Color(0xFFF1F0F4),
    90: Color(0xFFE3E2E6),
    80: Color(0xFFC7C6CA),
    70: Color(0xFFABABAE),
    60: Color(0xFF909094),
    50: Color(0xFF76777A),
    40: Color(0xFF5D5E62),
    30: Color(0xFF46474A),
    20: Color(0xFF2F3033),
    10: Color(0xFF1A1C1E),
    0: Color(0xFF000000),
  });

  static const MaterialColor neutralVariant = MaterialColor(0xFF8D9199, {
    100: Color(0xFFFFFFFF),
    99: Color(0xFFFDFCFF),
    95: Color(0xFFEEF0FA),
    90: Color(0xFFE0E2EC),
    80: Color(0xFFC3C6CF),
    70: Color(0xFFA8ABB4),
    60: Color(0xFF8D9199),
    50: Color(0xFF74777F),
    40: Color(0xFF5B5E66),
    30: Color(0xFF43474E),
    20: Color(0xFF2D3138),
    10: Color(0xFF181C22),
    0: Color(0xFF000000),
  });

  // colorScheme
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

  // surface
  static Map<int, Color> get surface => {
    Brightness.light: {
      1: Color.alphaBlend(
        primary[40]!.withOpacity(.05),
        Theme.of(Get.context!).colorScheme.surface,
      ),
      2: Color.alphaBlend(
        primary[40]!.withOpacity(.08),
        Theme.of(Get.context!).colorScheme.surface,
      ),
      3: Color.alphaBlend(
        primary[40]!.withOpacity(.11),
        Theme.of(Get.context!).colorScheme.surface,
      ),
      4: Color.alphaBlend(
        primary[40]!.withOpacity(.12),
        Theme.of(Get.context!).colorScheme.surface,
      ),
      5: Color.alphaBlend(
        primary[40]!.withOpacity(.14),
        Theme.of(Get.context!).colorScheme.surface,
      ),
    },
    Brightness.dark: {
      1: Color.alphaBlend(
        primary[80]!.withOpacity(.05),
        Theme.of(Get.context!).colorScheme.surface,
      ),
      2: Color.alphaBlend(
        primary[80]!.withOpacity(.08),
        Theme.of(Get.context!).colorScheme.surface,
      ),
      3: Color.alphaBlend(
        primary[80]!.withOpacity(.11),
        Theme.of(Get.context!).colorScheme.surface,
      ),
      4: Color.alphaBlend(
        primary[80]!.withOpacity(.12),
        Theme.of(Get.context!).colorScheme.surface,
      ),
      5: Color.alphaBlend(
        primary[80]!.withOpacity(.14),
        Theme.of(Get.context!).colorScheme.surface,
      ),
    },
  }[Theme.of(Get.context!).brightness]!;

  /// typography
  static const fontFamily = 'Noto_Sans_KR';

  static TextTheme textTheme = const TextTheme(

    //Headline
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

    //Title
    titleLarge: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 22.0,
      height: 28 / 22,
    ),
    titleMedium: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 18.0,
      height: 24 / 18,
    ),
    titleSmall: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 14.0,
      height: 20 / 14,
    ),

    //Label
    labelLarge: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 16.0,
      height: 20 / 16,
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

    //Body
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
}
