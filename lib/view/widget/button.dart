import 'package:fitween1/global/global.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:flutter/material.dart';

// Fitween 맞춤 버튼
class FWButton extends StatelessWidget {
  const FWButton({
    Key? key,
    this.text,
    this.child,
    this.fontSize = 15.0,
    required this.onPressed,
    this.width = 285.0,
    this.height = 45.0,
    this.theme = FWTheme.light,
    this.fill = false,
    this.borderRadius = 0.5,
  }) : assert(text == null || child == null), super(key: key);

  final String? text;
  final Widget? child;
  final double fontSize;
  final double width;
  final double height;
  final VoidCallback onPressed;
  final FWTheme theme;
  final bool fill;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    double radius = width < height ? width : height;

    late Color fillColor;
    late Color inverseColor;

    // parameter 에 따라 버튼 색상 변경
    fillColor = fill ? theme.color : theme.backgroundColor;
    inverseColor = fill ? theme.backgroundColor : theme.color;

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          primary: inverseColor,
          backgroundColor: fillColor,
          elevation: 0.0,
          side: BorderSide(color: theme.color),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius * 0.5 * borderRadius),
          ),
        ),
        child: child ?? FWText(
          text!,
          color: inverseColor,
          size: fontSize,
        ),
      ),
    );
  }
}
