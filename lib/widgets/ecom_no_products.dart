import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:sampleecom/widgets/ecom_text.dart';

class EcomNoProducts extends StatelessWidget {
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final String? title;
  const EcomNoProducts(
      {Key? key, this.height, this.width, this.title, this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width ?? 300,
      margin: margin ?? const EdgeInsets.only(top: 60),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset("assets/lottie/no_products.json", repeat: true),
          const SizedBox(height: 30),
          EcomText(
            title ?? "No Products in the matching Caetgory",
            size: 18,
            align: TextAlign.center,
          )
        ],
      ),
    );
  }
}
