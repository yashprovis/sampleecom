import 'package:flutter/material.dart';
import 'package:sampleecom/widgets/ecom_text.dart';

class CartOrderItem extends StatelessWidget {
  final String title;
  final String value;
  const CartOrderItem({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [EcomText(title, size: 13), EcomText(value, size: 13)],
      ),
    );
  }
}
