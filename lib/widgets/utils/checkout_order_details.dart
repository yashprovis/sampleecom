import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../helpers/methods.dart';
import '../../models/product_model.dart';
import '../../provider/user_provider.dart';
import '../ecom_text.dart';
import 'cart_order_items.dart';

class CheckoutOrderDetails extends StatelessWidget {
  final List<Product> products;
  const CheckoutOrderDetails({Key? key, required this.products})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
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
                  value:
                      " ₹${formatNumber(userProvider.fetchCartTotal(products)["subtotal"]!)}.00"),
              CartOrderItem(
                  title: "Bag Savings",
                  value:
                      "- ₹${formatNumber(userProvider.fetchCartTotal(products)["savings"]!)}.00"),
              userProvider.fetchCartTotal(products)["coupon_savings"] == 0
                  ? const SizedBox()
                  : CartOrderItem(
                      title:
                          "Coupon Savings ${userProvider.cartCoupon != null ? ("(${userProvider.cartCoupon!.id})") : ""}",
                      value:
                          "- ₹${formatNumber(userProvider.fetchCartTotal(products)["coupon_savings"]!)}.00"),
              const CartOrderItem(title: "Delivery", value: " Free"),
              CartOrderItem(
                  title: "Total Amount",
                  value:
                      " ₹${formatNumber(userProvider.fetchCartTotal(products)["total"]!)}.00")
            ],
          ),
        ));
  }
}
