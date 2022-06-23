import 'package:fitween1/config/palette.dart';
import 'package:fitween1/widget/text.dart';
import 'package:flutter/material.dart';

// Fitween 에 커스터마이징된 버튼 위젯
class FitweenButton extends StatelessWidget {
  const FitweenButton({
    Key? key,
    this.text,
    this.child,
    this.fontSize = 15.0,
    required this.onPressed,
    this.width = 285.0,
    this.height = 45.0,
    this.darkTheme = false,
    this.fill = false,
  }) : assert(text == null || child == null), super(key: key);

  final String? text;
  final Widget? child;
  final double fontSize;
  final double width;
  final double height;
  final VoidCallback onPressed;
  final bool darkTheme;
  final bool fill;

  @override
  Widget build(BuildContext context) {
    late List<Color> outlineColor;
    late List<Color> backgroundColor;

    // parameter 에 따라 버튼 색상 변경
    const List<Color> buttonColor = [Palette.light, Palette.dark];

    outlineColor = (darkTheme ? buttonColor : buttonColor.reversed).toList();
    backgroundColor = outlineColor;
    if (!fill) backgroundColor = outlineColor.reversed.toList();

    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          primary: backgroundColor.last,
          backgroundColor: backgroundColor.first,
          elevation: 0.0,
          side: BorderSide(color: outlineColor.first),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: child ?? FitweenText(text!, color: backgroundColor.last, size: fontSize),
      ),
    );
  }
}
