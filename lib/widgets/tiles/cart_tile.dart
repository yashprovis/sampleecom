import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sampleecom/models/product_model.dart';
import 'package:sampleecom/provider/user_provider.dart';
import 'package:sampleecom/screens/product_detail.dart';
import 'package:sampleecom/widgets/ecom_text.dart';

import '../../models/cart_model.dart';
import '../ecom_button.dart';

class CartTile extends StatelessWidget {
  final Product product;
  const CartTile({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(ProductDetailScreen.routeName, arguments: product.id),
      child: Container(
          margin: const EdgeInsets.only(top: 12, right: 9, left: 9),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: .3, color: Colors.blueGrey)),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                child: Image.network(
                  product.image,
                  height: 170,
                  fit: BoxFit.cover,
                  width: size.width / 2.7,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.width / 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: size.width / 2.3,
                              child: EcomText(
                                product.title,
                                size: 15,
                                maxLines: 2,
                                weight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                userProvider.removeFromCart(cartId: product.id);
                              },
                              child: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            EcomText(
                                "₹${(product.price) * userProvider.fetchCartItem(id: product.id).qty}  ",
                                size: 14),
                            Text(
                              "₹${(product.mrp) * userProvider.fetchCartItem(id: product.id).qty}",
                              style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6, bottom: 10),
                        child: Container(
                          // margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(border: Border.all()),
                          child: Row(
                            children: [
                              const EcomText("Size: ",
                                  size: 12, color: Colors.grey),
                              EcomText(
                                userProvider
                                    .fetchCartItem(id: product.id)
                                    .size
                                    .toString(),
                                size: 12,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          EcomButton(
                              height: 28,
                              text: "–",
                              width: 32,
                              color: userProvider
                                          .fetchCartItem(id: product.id)
                                          .qty ==
                                      1
                                  ? Colors.grey
                                  : null,
                              func: () {
                                if (userProvider
                                        .fetchCartItem(id: product.id)
                                        .qty ==
                                    1) {
                                  // userProvider.removeFromCart(
                                  //     cartId: product.id);
                                } else {
                                  userProvider.updateCart(
                                      cartItem: Cart(
                                          productId: product.id,
                                          qty: userProvider
                                                  .fetchCartItem(id: product.id)
                                                  .qty -
                                              1,
                                          size: userProvider
                                              .fetchCartItem(id: product.id)
                                              .size));
                                }
                              },
                              isLoading: false),
                          EcomText(
                              "   ${userProvider.fetchCartItem(id: product.id).qty}   ",
                              size: 18),
                          EcomButton(
                              height: 28,
                              width: 32,
                              text: "+",
                              func: () {
                                userProvider.updateCart(
                                    cartItem: Cart(
                                        productId: product.id,
                                        qty: userProvider
                                                .fetchCartItem(id: product.id)
                                                .qty +
                                            1,
                                        size: userProvider
                                            .fetchCartItem(id: product.id)
                                            .size));
                              },
                              isLoading: false),
                        ],
                      )
                    ],
                  ))
            ],
          )),
    );
  }
}
