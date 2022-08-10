import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampleecom/models/product_model.dart';
import 'package:sampleecom/provider/user_provider.dart';
import 'package:sampleecom/screens/checkout.dart';

import 'package:sampleecom/services/product_service.dart';
import 'package:sampleecom/widgets/ecom_button.dart';
import 'package:sampleecom/widgets/ecom_no_products.dart';
import 'package:sampleecom/widgets/ecom_text.dart';
import 'package:sampleecom/widgets/sheets/coupon_sheet.dart';
import 'package:sampleecom/widgets/utils/cart_order_items.dart';

import '../helpers/methods.dart';

import '../widgets/tiles/cart_tile.dart';
import '../widgets/ecom_loader.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Product>? products;

  ScrollController cartScrollController = ScrollController();
  @override
  void initState() {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    List<String> ids = [];
    if (userProvider.getUser.cart != null) {
      for (int i = 0; i < userProvider.getUser.cart!.length; i++) {
        ids.add(userProvider.getUser.cart![i].productId);
      }
    }
    ProductService().fetchProductsFromId(ids).then((value) {
      products = value;

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        // backgroundColor: Colors.grey[100],
        body: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: products == null
                ? const Center(child: EcomLoader())
                : userProvider.getUser.cart == null ||
                        userProvider.getUser.cart!.isEmpty
                    ? const Center(
                        child: EcomNoProducts(
                        title: "No Products in your Shopping Cart",
                      ))
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(20),
                            child: EcomText(
                              "Shopping Cart",
                              size: 20,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height - 240,
                            child: ListView(
                                controller: cartScrollController,
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                children: [
                                  ListView.builder(
                                    physics: const ClampingScrollPhysics(),
                                    padding: const EdgeInsets.only(bottom: 20),
                                    itemCount:
                                        userProvider.getUser.cart!.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return CartTile(
                                          product: products![index]);
                                    },
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        "Assured Quality | ",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 1),
                                      ),
                                      Text(
                                        "100% Handpicked | ",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 1),
                                      ),
                                      Text(
                                        "Easy Exchange",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 1),
                                      ),
                                    ],
                                  ),
                                  Container(
                                      height: 60,
                                      decoration: BoxDecoration(
                                        border: Border.all(width: .5),
                                        color: Colors.white,
                                      ),
                                      margin: const EdgeInsets.only(
                                          top: 30, bottom: 30),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          userProvider.cartCoupon != null
                                              ? Padding(
                                                  // margin: const EdgeInsets.symmetric(vertical: 10),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 14,
                                                  ),

                                                  child: Text(
                                                    userProvider.cartCoupon!.id,
                                                    style: const TextStyle(
                                                        fontSize: 16),
                                                  ),
                                                )
                                              : const EcomText(
                                                  " Have Coupon?",
                                                  size: 16,
                                                ),
                                          GestureDetector(
                                            onTap: () {
                                              userProvider.cartCoupon != null
                                                  ? userProvider.removeCoupon()
                                                  : couponSheet(context);
                                            },
                                            child: Container(
                                              // margin: const EdgeInsets.symmetric(vertical: 10),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 14,
                                                      vertical: 4),
                                              decoration: BoxDecoration(
                                                  border: Border.all()),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    userProvider.cartCoupon !=
                                                            null
                                                        ? "Remove"
                                                        : "Apply?",
                                                    style: const TextStyle(
                                                        fontSize: 14),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                  Container(
                                    color: Colors.white,
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const EcomText(
                                            'ORDER DETAILS',
                                            weight: FontWeight.bold,
                                            size: 16,
                                          ),
                                          const SizedBox(height: 10),
                                          CartOrderItem(
                                              title: "Bag Total",
                                              value:
                                                  " ₹${formatNumber(userProvider.fetchCartTotal(products!)["subtotal"]!)}.00"),
                                          CartOrderItem(
                                              title: "Bag Savings",
                                              value:
                                                  "- ₹${formatNumber(userProvider.fetchCartTotal(products!)["savings"]!)}.00"),
                                          userProvider.fetchCartTotal(
                                                          products!)[
                                                      "coupon_savings"] ==
                                                  0
                                              ? const SizedBox()
                                              : CartOrderItem(
                                                  title:
                                                      "Coupon Savings ${userProvider.cartCoupon != null ? ("(${userProvider.cartCoupon!.id})") : ""}",
                                                  value:
                                                      "- ₹${formatNumber(userProvider.fetchCartTotal(products!)["coupon_savings"]!)}.00"),
                                          const CartOrderItem(
                                              title: "Delivery",
                                              value: " Free"),
                                          CartOrderItem(
                                              title: "Total Amount",
                                              value:
                                                  " ₹${formatNumber(userProvider.fetchCartTotal(products!)["total"]!)}.00")
                                        ]),
                                  ),
                                ]),
                          ),
                          Container(
                              height: 78,
                              padding:
                                  const EdgeInsets.only(left: 16, right: 10),
                              width: double.infinity,
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      EcomText(
                                          "Total: ₹${formatNumber(userProvider.fetchCartTotal(products!)["total"]!)}.00"),
                                      const SizedBox(height: 4),
                                      GestureDetector(
                                        onTap: () {
                                          cartScrollController.animateTo(
                                              curve: Curves.easeInOut,
                                              duration: const Duration(
                                                  milliseconds: 400),
                                              cartScrollController
                                                  .position.maxScrollExtent);
                                        },
                                        child: const Text("View Details",
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline)),
                                      )
                                    ],
                                  ),
                                  EcomButton(
                                      width: 150,
                                      height: 40,
                                      textSize: 12,
                                      text: "Confirm Order".toUpperCase(),
                                      func: () {
                                        Navigator.of(context).pushNamed(
                                            CheckoutScreen.routeName,
                                            arguments: products);
                                      },
                                      isLoading: false)
                                ],
                              )),
                        ],
                      )));
  }
}
