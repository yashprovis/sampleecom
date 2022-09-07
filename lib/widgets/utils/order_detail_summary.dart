import 'package:flutter/material.dart';
import 'package:sampleecom/models/product_model.dart';
import 'package:sampleecom/widgets/ecom_text.dart';

import '../../models/order_model.dart';

class OrderDetailSummary extends StatelessWidget {
  final Order order;
  final List<Product> products;
  const OrderDetailSummary(
      {Key? key, required this.products, required this.order})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 20, left: 15, right: 20),
      child: Card(
        elevation: 2,
        child: ExpansionTile(
          initiallyExpanded: true,
          title: const EcomText("Order Summary"),
          iconColor: Colors.black,
          childrenPadding:
              const EdgeInsets.only(bottom: 16, right: 16, left: 16),
          children: [
            ListView.builder(
              itemCount: products.length,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                    leading: SizedBox(
                        width: 60, child: Image.network(products[index].image)),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: EcomText(
                          "Price: ₹${products[index].price}.00, Size: ${order.cartItems![index].size}",
                          size: 12),
                    ),
                    title: EcomText(
                        "${order.cartItems![index].qty} x ${products[index].title}",
                        size: 14));
              },
            )
          ],
        ),
      ),
    );
  }
}
