import 'package:fitween1/config/palette.dart';
import 'package:flutter/material.dart';

class FitweenText extends StatelessWidget {
  const FitweenText({
    Key? key,
    this.color = Palette.light,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Continue with Google',
      style: TextStyle(
        color: Palette.light,
        fontFamily: 'Noto_Sans_KR',
      ),
    );
  }
}
