import 'package:flutter/material.dart';

// 테마 색상 관리

class Palette {
  static const Color dark = Color(0xFF1F1F1F);
  static const Color grey = Color(0xFFB6B5B5);
  static const Color light = Color(0xFFF5F5F5);
  static const Color white = Colors.white;

  // static const Color primary = Color(0xFF0187FF);
  // static const Color secondary = Color(0xFF01DBFF);
  // static const Color accent = Color(0xFFFFC200);

  static const MaterialColor primary = MaterialColor(
    0xFF0187FF,
    { 0: Color(0xFFFFFFFF)} ,
  );
}