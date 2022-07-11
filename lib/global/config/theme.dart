import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FWTheme {
  // FWTheme._();

  ThemeMode mode = ThemeMode.light;

  /// colors
  // simple
  static const Color black = Colors.black;
  static const Color dark = Color(0xFF1F1F1F);
  static const Color grey = Color(0xFF929292);
  static const Color light = Color(0xFFF5F5F5);
  static const Color white = Colors.white;
  static const Color fitween1 = Color(0xFF0086FF);
  static const Color fitween2 = Color(0xFF00DBFF);
  static const Color fitween3 = Color(0xFFA5C8FF);
  static const Color fitween4 = Color(0xFFD4E3FF);
  static const LinearGradient fitweenGradient = LinearGradient(
    colors: [fitween1, fitween2],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const LinearGradient cardGradient = LinearGradient(
    colors: [fitween4, fitween3],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );


  // materialColor
  static const MaterialColor primary = MaterialColor(0xFF018DFF, {
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

  static const MaterialColor secondary = MaterialColor(0xFF01BDFF, {
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

  static const MaterialColor tertiary = MaterialColor(0xFF7179DE, {
    100: Color(0xFFFFFFFF),
    99: Color(0xFFFFFBFF),
    95: Color(0xFFF1EFFF),
    90: Color(0xFFE0E0FF),
    80: Color(0xFFBEC2FF),
    70: Color(0xFF9DA4FF),
    60: Color(0xFF7F87EE),
    50: Color(0xFF656DD1),
    40: Color(0xFF4C54B7),
    30: Color(0xFF333B9D),
    20: Color(0xFF1A2087),
    10: Color(0xFF00026C),
    0: Color(0xFF000000),
  });

  static const MaterialColor error = MaterialColor(0xFFBA1A1A, {
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

  static const MaterialColor neutral = MaterialColor(0xFF5D5E62, {
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

  static const MaterialColor neutralVariant = MaterialColor(0xFF5B5E66, {
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
    primary: Color(0xFF0059A3),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFD4E3FF),
    onPrimaryContainer: Color(0xFF001C3A),
    secondary: Color(0xFF005F83),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFC4E7FF),
    onSecondaryContainer: Color(0xFF001E2D),
    tertiary: Color(0xFF4C54B7),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFE0E0FF),
    onTertiaryContainer: Color(0xFF00026C),
    error: Color(0xFFB01919),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFFDFCFF),
    onBackground: Color(0xFF1A1C1E),
    surface: Color(0xFFFDFCFF),
    onSurface: Color(0xFF1A1C1E),
    surfaceVariant: Color(0xFFF3F5FF),
    onSurfaceVariant: Color(0xFF43474E),
    outline: Color(0xFF74777F),
    onInverseSurface: Color(0xFFF1F0F4),
    inverseSurface: Color(0xFF2F3033),
    inversePrimary: Color(0xFFA5C8FF),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFFFDFCFF),
  );

  static const ColorScheme darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFA5C8FF),
    onPrimary: Color(0xFF00315F),
    primaryContainer: Color(0xFF004786),
    onPrimaryContainer: Color(0xFFD4E3FF),
    secondary: Color(0xFF7DD0FF),
    onSecondary: Color(0xFF00344A),
    secondaryContainer: Color(0xFF004C69),
    onSecondaryContainer: Color(0xFFC4E7FF),
    tertiary: Color(0xFFBEC2FF),
    onTertiary: Color(0xFF1A2087),
    tertiaryContainer: Color(0xFF333B9D),
    onTertiaryContainer: Color(0xFFE0E0FF),
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color(0xFF1F1F1F),
    onBackground: Color(0xFFE3E2E6),
    surface: Color(0xFF1A1C1E),
    onSurface: Color(0xFFE3E2E6),
    surfaceVariant: Color(0xFF43474E),
    onSurfaceVariant: Color(0xFFC3C6CF),
    outline: Color(0xFF8D9199),
    onInverseSurface: Color(0xFF1A1C1E),
    inverseSurface: Color(0xFFE3E2E6),
    inversePrimary: Color(0xFF005FAF),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFFA5C8FF),
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

  static TextTheme textTheme = TextTheme(

    //Headline
    headlineLarge: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w700,
      fontSize: 32.0.sp,
      height: (40 / 32).h,
    ),
    headlineMedium: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w700,
      fontSize: 24.0.sp,
      height: (36 / 24).h,
    ),
    headlineSmall: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w700,
      fontSize: 16.0.sp,
      height: (32 / 16).h,
    ),

    //Title
    titleLarge: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 22.0.sp,
      height: (28 / 22).h,
    ),
    titleMedium: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 18.0.sp,
      height: (24 / 18).h,
    ),
    titleSmall: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 14.0.sp,
      height: (20 / 14).h,
    ),

    //Label
    labelLarge: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 16.0.sp,
      height: (20 / 16).h,
    ),
    labelMedium: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 12.0.sp,
      height: (16 / 12).h,
    ),
    labelSmall: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 11.0.sp,
      height: (16 / 11).h,
    ),

    //Body
    bodyLarge: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 16.0.sp,
      height: (24 / 16).h,
    ),
    bodyMedium: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 14.0.sp,
      height: (20 / 14).h,
    ),
    bodySmall: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 12.0.sp,
      height: (16 / 12).h,
    ),
  );
}
