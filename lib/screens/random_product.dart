import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampleecom/provider/user_provider.dart';
import 'package:sampleecom/screens/search.dart';
import 'package:sampleecom/widgets/ecom_no_products.dart';
import 'package:sampleecom/widgets/ecom_text.dart';
import 'package:sampleecom/widgets/tiles/ramdom_product_tile.dart';
import 'package:sampleecom/widgets/utils/cart_heaer_button.dart';

import '../models/product_model.dart';
import '../services/product_service.dart';
import '../widgets/ecom_loader.dart';
import '../widgets/tiles/wishlist_tile.dart';

class RandomProducts extends StatefulWidget {
  const RandomProducts({Key? key}) : super(key: key);

  @override
  State<RandomProducts> createState() => _RandomProductsState();
}

class _RandomProductsState extends State<RandomProducts> {
  List<Product>? products;
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    products = await ProductService().fetchRandomProducts();
    setState(() {});
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: products == null
            ? const Center(child: EcomLoader())
            : products!.isEmpty
                ? const Center(
                    child: EcomNoProducts(
                    title: "No Products in your Wishlist",
                  ))
                : Stack(
                    children: [
                      PageView.builder(
                        onPageChanged: (value) {
                          currentIndex = value;
                          setState(() {});
                        },
                        itemCount: products!.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              RandomProductTile(product: products![index]),
                              // Positioned(
                              //   right: 0,
                              //   top: 80,
                              //   child: GestureDetector(
                              //       onTap: () {
                              //         if (currentIndex !=
                              //             products!.length - 1) {
                              //           currentIndex += 1;
                              //           setState(() {});
                              //         }
                              //       },
                              //       child: Container(
                              //         color: Colors.transparent,
                              //         width: 40,
                              //         height:
                              //             MediaQuery.of(context).size.height,
                              //       )),
                              // ),
                              // Positioned(
                              //     top: 80,
                              //     child: GestureDetector(
                              //       onTap: () {
                              //         if (currentIndex != 0) {
                              //           currentIndex -= 1;
                              //           setState(() {});
                              //         }
                              //       },
                              //       child: Container(
                              //         color: Colors.transparent,
                              //         width: 40,
                              //         height:
                              //             MediaQuery.of(context).size.height,
                              //       ),
                              //     ))
                            ],
                          );
                        },
                      ),
                      SizedBox(
                        height: 74,
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(
                              top: 60, bottom: 10, left: 20),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, i) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: currentIndex >= i
                                      ? Color(0xFF080808)
                                      : Colors.grey[300]),
                              alignment: Alignment.center,
                              // child: Container(
                              //     height: 1,
                              //     color: Colors.white,
                              //     margin: EdgeInsets.symmetric(
                              //         vertical: 2, horizontal: 4)),
                              width: MediaQuery.of(context).size.width /
                                      products!.length -
                                  16,
                            );
                          },
                          itemCount: products!.length,
                        ),
                      ),
                    ],
                  ));
  }
}
