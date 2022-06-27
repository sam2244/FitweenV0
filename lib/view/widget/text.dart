import 'package:fitween1/global/global.dart';
import 'package:fitween1/global/palette.dart';
import 'package:flutter/material.dart';

enum FWFontWeight { bold, normal, thin }

class FWText extends StatelessWidget {
  const FWText(this.data, {
    Key? key,
    this.color = Palette.dark,
    this.size = 14.0,
    this.weight = FWFontWeight.normal,
    this.textStyle
  }) : assert((
    color == null && size == null && weight == null
  ) || textStyle == null), super(key: key);

  final String data;
  final Color? color;
  final double? size;
  final FWFontWeight? weight;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    FontWeight fontWeight = FontWeight.w600;

    if (weight != FWFontWeight.normal) {
      fontWeight = weight == FWFontWeight.bold
          ? FontWeight.w800
          : FontWeight.w400;
    }

    return Text(
      data,
      style: textStyle ?? TextStyle(
        overflow: TextOverflow.ellipsis,
        fontSize: size,
        color: color,
        fontFamily: 'Noto_Sans_KR',
        fontWeight: fontWeight,
      ),
    );
  }
}

class FWInputField extends StatelessWidget {
  const FWInputField({
    Key? key,
    required this.controller,
    required this.theme,
    this.onSubmitted,
    this.width = 285.0,
    this.height = 45.0,
    this.hintText,
    this.hintTextColor = Palette.grey,
    this.invalid = true,
  }) : super(key: key);

  final TextEditingController controller;
  final FWTheme theme;
  final Function(String)? onSubmitted;
  final double width;
  final double height;
  final String? hintText;
  final Color hintTextColor;
  final bool invalid;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        controller: controller,
        onFieldSubmitted: onSubmitted ?? (_) {},
        cursorColor: theme.color,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: invalid ? Colors.red : theme.color,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: theme.color,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: hintText ?? '',
          hintStyle: TextStyle(color: hintTextColor),
        ),
        style: TextStyle(
          color: theme.color,
        ),
      ),
    );
  }
}
