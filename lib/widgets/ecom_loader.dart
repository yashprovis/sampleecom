import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EcomLoader extends StatelessWidget {
  final double? height;
  final double? width;
  const EcomLoader({Key? key, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 150,
      width: width ?? 150,
      alignment: Alignment.center,
      child: Lottie.asset("assets/lottie/loader.json", repeat: true),
    );
  }
}
