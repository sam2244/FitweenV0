import 'package:fitween1/global/config/theme.dart';
import 'package:flutter/material.dart';

enum FWFontWeight { bold, normal, thin }

class FWText extends StatelessWidget {
  FWText(this.data, {
    Key? key,
    this.color,
    this.size = 14.0,
    this.weight = FWFontWeight.normal,
    this.textStyle,
  }) : assert(color == null || textStyle == null), super(key: key);

  final String data;
  Color? color;
  double size;
  FWFontWeight weight;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    FontWeight fontWeight = FontWeight.w600;
    color ??= Theme.of(context).colorScheme.primary;

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
    this.onSubmitted,
    this.onChanged,
    this.width = 285.0,
    this.height = 45.0,
    this.hintText,
    this.hintTextColor = FWTheme.grey,
    this.invalid = true,
    this.enabled = true,
  }) : super(key: key);

  final TextEditingController controller;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final double width;
  final double height;
  final String? hintText;
  final Color? hintTextColor;
  final bool invalid;
  final bool enabled;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: height,
      child: TextFormField(
        controller: controller,
        onFieldSubmitted: onSubmitted ?? (_) {},
        onChanged: onChanged ?? (_) {},
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
          border: const OutlineInputBorder(),
          hintText: hintText,
          hintStyle: TextStyle(
            color: hintTextColor,
          )
        ),
        enabled: enabled,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
