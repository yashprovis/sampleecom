import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampleecom/models/product_model.dart';
import 'package:sampleecom/provider/user_provider.dart';
import 'package:sampleecom/widgets/ecom_text.dart';

class CheckoutOrderSummary extends StatelessWidget {
  final List<Product> products;
  const CheckoutOrderSummary({Key? key, required this.products})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 20, left: 15, right: 20),
      child: Card(
        elevation: 2,
        child: ExpansionTile(
          title: EcomText("Order Summary"),
          iconColor: Colors.black,
          childrenPadding: EdgeInsets.only(bottom: 16, right: 16, left: 16),
          children: [
            ListView.builder(
              itemCount: products.length,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 4),
                    leading: SizedBox(
                        width: 60, child: Image.network(products[index].image)),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: EcomText(
                          "Price: ₹${products[index].price}.00, Size: ${userProvider.fetchCartItem(id: products[index].id).size}",
                          size: 12),
                    ),
                    title: EcomText(
                        "${userProvider.fetchCartItem(id: products[index].id).qty} x ${products[index].title}",
                        size: 14));
              },
            )
          ],
        ),
      ),
    );
  }
}
