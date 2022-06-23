import 'package:fitween1/config/palette.dart';
import 'package:flutter/material.dart';

class FitweenText extends StatelessWidget {
  const FitweenText(this.data, {
    Key? key,
    this.color = Palette.dark,
    this.size = 14.0,
  }) : super(key: key);

  final String data;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        color: color,
        fontFamily: 'Noto_Sans_KR',
      ),
    );
  }
}

class FitweenInputField extends StatelessWidget {
  const FitweenInputField({
    Key? key,
    required this.controller,
    this.onSubmitted,
    this.width = 285.0,
    this.height = 45.0,
    this.hintText,
    this.darkTheme = false,
  }) : super(key: key);

  final TextEditingController controller;
  final Function(String)? onSubmitted;
  final double width;
  final double height;
  final String? hintText;
  final bool darkTheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        controller: controller,
        onFieldSubmitted: onSubmitted ?? (_) {},
        cursorColor: darkTheme ? Palette.light : Palette.dark,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: darkTheme ? Palette.light : Palette.dark,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: darkTheme ? Palette.light : Palette.dark,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: hintText ?? '',
        ),
        style: TextStyle(
          color: darkTheme ? Palette.light : Palette.dark,
        ),
      ),
    );
  }
}
