import 'package:fitween1/config/palette.dart';
import 'package:flutter/material.dart';

// Fitween 에 커스터마이징된 버튼 위젯
class FitweenButton extends StatelessWidget {
  const FitweenButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.width = 285.0,
    this.height = 45.0,
    this.darkTheme = false,
    this.fill = false,
  }) : super(key: key);

  final Widget child;
  final double width;
  final double height;
  final VoidCallback onPressed;
  final bool darkTheme;
  final bool fill;

  @override
  Widget build(BuildContext context) {
    // parameter 에 따라 버튼 색상 변경
    Color outlineColor = darkTheme ? Palette.light : Palette.dark;
    Color backgroundColor = outlineColor;
    if (!fill) backgroundColor = darkTheme ? Palette.dark : Palette.light;

    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          primary: outlineColor,
          backgroundColor: backgroundColor,
          elevation: 0.0,
          side: BorderSide(color: outlineColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: child,
      ),
    );
  }
}
