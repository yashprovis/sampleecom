import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampleecom/widgets/ecom_button.dart';
import 'package:sampleecom/widgets/ecom_text.dart';

import '../../models/cart_model.dart';
import '../../models/product_model.dart';
import '../../provider/user_provider.dart';

void sizeSheet(BuildContext context, Product product) {
  showModalBottomSheet(
      context: context,
      builder: (builder) {
        int? currentSize;
        UserProvider userProvider = Provider.of<UserProvider>(context);
        return StatefulBuilder(builder: (context, ss) {
          return Container(
              padding: const EdgeInsets.all(16),
              height: 220,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const EcomText(
                        "Select Size",
                        size: 18,
                        weight: FontWeight.w500,
                      ),
                      GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Icon(Icons.close))
                    ],
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      height: 70,
                      child: ListView.builder(
                        itemCount: product.size.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              currentSize = product.size[index];
                              ss(() {});
                            },
                            child: AnimatedContainer(
                                duration: const Duration(milliseconds: 400),
                                margin: const EdgeInsets.only(
                                    right: 16, top: 8, bottom: 8),
                                width: 54,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: currentSize == product.size[index]
                                      ? Border.all(width: 2.5)
                                      : null,
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child:
                                    EcomText(product.size[index].toString())),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: EcomButton(
                        text: "+ Add To Cart",
                        func: () {
                          if (currentSize != null) {
                            userProvider.addToCart(
                                cartItem: Cart(
                                    productId: product.id,
                                    qty: 1,
                                    size: currentSize!));
                          }
                          Navigator.of(context).pop();
                        },
                        color: currentSize == null ? Colors.grey : Colors.black,
                        isLoading: false),
                  )
                ],
              ));
        });
      });
}
