import 'package:fitween1/global/palette.dart';
import 'package:flutter/material.dart';

// 사용되는 범위가 광범위 하여 종속관계가 모호한 변수

/// pages
enum FWTheme {
  dark, light, primaryDark, primaryLight;

  Color get color {
    switch (name) {
      case 'dark': return Palette.light;
      case 'light': return Palette.dark;
      default: return Palette.primary;
    }
  }

  Color get backgroundColor {
    switch (name) {
      case 'dark': return Palette.dark;
      case 'light': return Palette.light;
      case 'primaryDark': return Palette.dark;
      case 'primaryLight': return Palette.light;
    }
    return Colors.transparent;
  }

  Color get inverseColor {
    switch (name) {
      case 'dark': return Palette.light;
      case 'light': return Palette.dark;
      case 'primaryDark': return Palette.light;
      case 'primaryLight': return Palette.dark;
    }
    return Colors.transparent;
  }

  FWTheme get grayScale {
    switch (name) {
      case 'dark': return FWTheme.dark;
      case 'light': return FWTheme.light;
      case 'primaryDark': return FWTheme.dark;
      case 'primaryLight': return FWTheme.light;
    }
    return FWTheme.dark;
  }
}

const Size defaultMargin = Size(30.0, 15.0);

/// appbar
const double appbarHeight = 60.0;