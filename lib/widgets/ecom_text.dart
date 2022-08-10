import 'package:flutter/material.dart';

class EcomText extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? weight;
  final Color? color;
  final TextAlign? align;
  final int? maxLines;

  const EcomText(this.text,
      {Key? key, this.size, this.weight, this.color, this.align, this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
          letterSpacing: 1.5,
          color: color ?? Colors.black,
          fontWeight: weight ?? FontWeight.w400,
          fontSize: size ?? 17),
    );
  }
}
