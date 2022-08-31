import 'package:flutter/material.dart';

class EcomText extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? weight;
  final Color? color;
  final TextAlign? align;
  final int? maxLines;
  final double? spacing;

  const EcomText(this.text,
      {Key? key,
      this.size,
      this.weight,
      this.color,
      this.align,
      this.maxLines,
      this.spacing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
          letterSpacing: spacing ?? 1.3,
          color: color ?? Colors.black,
          fontWeight: weight ?? FontWeight.w400,
          fontSize: size ?? 17),
    );
  }
}
