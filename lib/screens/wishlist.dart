import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampleecom/provider/user_provider.dart';
import 'package:sampleecom/screens/search.dart';
import 'package:sampleecom/widgets/ecom_no_products.dart';
import 'package:sampleecom/widgets/ecom_text.dart';
import 'package:sampleecom/widgets/utils/cart_heaer_button.dart';

import '../models/product_model.dart';
import '../services/product_service.dart';
import '../widgets/ecom_loader.dart';
import '../widgets/tiles/wishlist_tile.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  List<Product>? products = [];
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    ProductService()
        .fetchProductsFromId(userProvider.getUser.favourites)
        .then((value) => setState(() {
              products = value;
            }));
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: products == null
                ? const Center(child: EcomLoader())
                : userProvider.getUser.favourites.isEmpty
                    ? const Center(
                        child: EcomNoProducts(
                        title: "No Products in your Wishlist",
                      ))
                    : ListView(
                        padding: const EdgeInsets.only(top: 20),
                        children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 15),
                              child: SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const EcomText(
                                        "Wishlist",
                                        size: 20,
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).pushNamed(
                                                    SearchScreen.routeName);
                                              },
                                              child: Icon(CupertinoIcons.search,
                                                  size: 32)),
                                          const SizedBox(width: 14),
                                          const CartHeaderButton()
                                        ],
                                      )
                                    ],
                                  )),
                            ),
                            GridView.builder(
                              physics: const ClampingScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisExtent: 294,
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 4,
                                      crossAxisSpacing: 4),
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              itemCount: products!.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return WishlistTile(product: products![index]);
                              },
                            )
                          ])));
  }
}
