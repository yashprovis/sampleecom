import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampleecom/constants.dart';

import 'package:sampleecom/models/product_model.dart';
import 'package:sampleecom/provider/user_provider.dart';
import 'package:sampleecom/screens/product_detail.dart';
import 'package:sampleecom/widgets/ecom_text.dart';

import '../../models/cart_model.dart';
import '../../provider/tabs_provider.dart';
import '../ecom_button.dart';
import '../sheets/size_sheet.dart';

class RandomProductTile extends StatelessWidget {
  final Product product;
  const RandomProductTile({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    TabsProvider tabsProvider = Provider.of<TabsProvider>(context);
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(ProductDetailScreen.routeName, arguments: product.id),
      child: SizedBox(
          height: MediaQuery.of(context).size.height - 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                product.image,
                height: 470,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EcomText(
                        product.title,
                        size: 18,
                        weight: FontWeight.w400,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            EcomText("₹${product.price}", size: 16),
                            SizedBox(width: 8),
                            Text(
                              "₹${product.mrp}",
                              style: const TextStyle(
                                  fontSize: 16,
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.star, size: 20),
                          SizedBox(width: 4),
                          EcomText(
                              product.ratingAvg != null
                                  ? "${product.ratingAvg.toDouble()} ratings"
                                  : "No ratings yet",
                              size: 16),
                        ],
                      ),
                    ],
                  )),
              Row(
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2 - .4,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border(
                          top: BorderSide(width: .3),
                          right: BorderSide(width: .3),
                        )),
                    margin: const EdgeInsets.only(top: 8),
                    padding: EdgeInsets.only(),
                    child: userProvider.productExistInCart(id: product.id)
                        ? Padding(
                            padding: const EdgeInsets.only(top: 6, bottom: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                EcomButton(
                                    height: 28,
                                    width: 32,
                                    text: "–",
                                    func: () {
                                      if (userProvider
                                              .fetchCartItem(id: product.id)
                                              .qty ==
                                          1) {
                                        userProvider.removeFromCart(
                                            cartId: product.id);
                                      } else {
                                        userProvider.updateCart(
                                            cartItem: Cart(
                                                productId: product.id,
                                                qty: userProvider
                                                        .fetchCartItem(
                                                            id: product.id)
                                                        .qty -
                                                    1,
                                                size: userProvider
                                                    .fetchCartItem(
                                                        id: product.id)
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
                                                      .fetchCartItem(
                                                          id: product.id)
                                                      .qty +
                                                  1,
                                              size: userProvider
                                                  .fetchCartItem(id: product.id)
                                                  .size));
                                      tabsProvider.changeIndex(3);
                                    },
                                    isLoading: false),
                              ],
                            ),
                          )
                        : ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.grey[200]),
                                padding:
                                    MaterialStateProperty.all(EdgeInsets.zero)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(CupertinoIcons.cart_badge_plus,
                                    color: primaryColor),
                                SizedBox(width: 8),
                                EcomText(
                                  "Buy Now",
                                ),
                              ],
                            ),
                            onPressed: () {
                              sizeSheet(context, product, true);
                            },
                          ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - .4,
                    height: 50,
                    decoration: const BoxDecoration(
                        border: Border(top: BorderSide(width: .3))),
                    margin: const EdgeInsets.only(top: 8),
                    padding: EdgeInsets.only(),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder()),
                          padding: MaterialStateProperty.all(EdgeInsets.zero)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            userProvider.getUser.favourites.contains(product.id)
                                ? CupertinoIcons.heart_fill
                                : CupertinoIcons.heart,
                          ),
                          SizedBox(width: 8),
                          EcomText(
                            "Wishlist",
                            color: Colors.white,
                          ),
                        ],
                      ),
                      onPressed: () {
                        userProvider.alterFav(
                            productId: product.id,
                            isFav: userProvider.getUser.favourites
                                .contains(product.id));
                      },
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
