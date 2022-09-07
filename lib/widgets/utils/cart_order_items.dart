import 'package:flutter/material.dart';
import 'package:sampleecom/widgets/ecom_text.dart';

class CartOrderItem extends StatelessWidget {
  final String title;
  final bool? isOrder;
  final String value;
  const CartOrderItem(
      {Key? key, required this.title, this.isOrder, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 4, left: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          EcomText(title, size: isOrder != null ? 14 : 13, spacing: 1.3),
          EcomText(value, size: isOrder != null ? 14 : 13)
        ],
      ),
    );
  }
}
