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
        padding: const EdgeInsets.only(bottom: 20, left: 15, right: 20),
        child: Card(
          elevation: 2,
          child: ExpansionTile(
            initiallyExpanded: true,
            title: const EcomText("Order Details"),
            iconColor: Color(0xFF080808),
            childrenPadding:
                const EdgeInsets.only(bottom: 16, right: 16, left: 16),
            children: [
              CartOrderItem(
                  isOrder: true,
                  title: "Bag Total",
                  value: " ₹${formatNumber(order.subtotalAmount)}.00"),
              CartOrderItem(
                  isOrder: true,
                  title: "Bag Savings",
                  value: "- ₹${formatNumber(order.savingsAmount)}.00"),
              order.couponAmount == 0
                  ? const SizedBox()
                  : CartOrderItem(
                      isOrder: true,
                      title: "Coupon Savings",
                      value: "- ₹${formatNumber(order.couponAmount)}.00"),
              const CartOrderItem(
                  isOrder: true, title: "Delivery", value: " Free"),
              CartOrderItem(
                  isOrder: true,
                  title: "Total Amount",
                  value: " ₹${formatNumber(order.totalAmount)}.00")
            ],
          ),
        ));
  }
}
