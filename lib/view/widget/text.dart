import 'package:fitween1/global/config/theme.dart';
import 'package:flutter/material.dart';

enum FWFontWeight { bold, normal, thin }

class FWText extends StatelessWidget {
  FWText(this.data, {
    Key? key,
    this.style,
    this.color,
    this.size,
    this.weight,
    this.family,
    this.align,
    this.overflow = false,
  }) : super(key: key);

  final String data;
  TextStyle? style;
  Color? color;
  final double? size;
  final FWFontWeight? weight;
  final String? family;
  final TextAlign? align;
  final bool overflow;

  @override
  Widget build(BuildContext context) {
    style ??= Theme.of(context).textTheme.labelMedium;
    color ??= Theme.of(context).colorScheme.primary;
    FontWeight? fontWeight = <FWFontWeight, FontWeight>{
      FWFontWeight.thin: FontWeight.w400,
      FWFontWeight.normal: FontWeight.w600,
      FWFontWeight.bold: FontWeight.w800,
    }[weight];

    TextStyle textStyle = TextStyle(
      overflow: overflow
          ? TextOverflow.ellipsis
          : TextOverflow.visible,
      fontSize: size,
      color: color,
      fontWeight: fontWeight,
      fontFamily: family,
    );

    return Text(data,
      textAlign: align,
      maxLines: overflow ? 1 : 2,
      style: style?.merge(textStyle) ?? textStyle.merge(style),
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
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
          border: const OutlineInputBorder(),
          hintText: hintText,
          hintStyle: TextStyle(color: hintTextColor),
        ),
        enabled: enabled,
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }
}
