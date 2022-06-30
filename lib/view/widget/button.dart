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
    this.fill = true,
    this.borderRadius = 1.0,
  }) : assert(text == null || child == null), super(key: key);

  final String? text;
  final Widget? child;
  final double fontSize;
  final double width;
  final double height;
  final VoidCallback onPressed;
  final bool fill;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    double radius = width < height ? width : height;

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          primary: fill
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.primary,
          backgroundColor: fill
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onPrimary,
          elevation: 0.0,
          side: BorderSide(color: Theme.of(context).colorScheme.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius * 0.5 * borderRadius),
          ),
        ),
        child: child ?? FWText(
          text!,
          color: fill
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.primary,
          size: fontSize,
        ),
      ),
    );
  }
}
