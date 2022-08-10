import 'package:flutter/material.dart';

import '../../helpers/methods.dart';
import '../../models/order_model.dart';

import '../ecom_text.dart';
import 'cart_order_items.dart';

class OrderDetailBill extends StatelessWidget {
  final Order order;
  const OrderDetailBill({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 30, left: 15, right: 20),
        child: Card(
          elevation: 2,
          child: ExpansionTile(
            title: EcomText("Order Details"),
            iconColor: Colors.black,
            childrenPadding: EdgeInsets.only(bottom: 16, right: 16, left: 16),
            children: [
              CartOrderItem(
                  title: "Bag Total",
                  value: " ₹${formatNumber(order.subtotalAmount)}.00"),
              CartOrderItem(
                  title: "Bag Savings",
                  value: "- ₹${formatNumber(order.savingsAmount)}.00"),
              order.couponAmount == 0
                  ? const SizedBox()
                  : CartOrderItem(
                      title: "Coupon Savings",
                      value: "- ₹${formatNumber(order.couponAmount)}.00"),
              const CartOrderItem(title: "Delivery", value: " Free"),
              CartOrderItem(
                  title: "Total Amount",
                  value: " ₹${formatNumber(order.totalAmount)}.00")
            ],
          ),
        ));
  }
}
