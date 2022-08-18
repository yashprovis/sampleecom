import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampleecom/helpers/methods.dart';
import 'package:sampleecom/models/order_model.dart';
import 'package:sampleecom/provider/user_provider.dart';
import 'package:sampleecom/screens/order_placed.dart';
import 'package:sampleecom/services/order_service.dart';
import 'package:sampleecom/widgets/ecom_button.dart';
import 'package:sampleecom/widgets/tiles/address_tile.dart';
import 'package:sampleecom/widgets/utils/checkout_order_details.dart';
import 'package:sampleecom/widgets/utils/checkout_order_summary.dart';

import '../models/address_model.dart';
import '../models/product_model.dart';
import '../provider/order_provider.dart';
import '../provider/tabs_provider.dart';
import '../widgets/ecom_text.dart';

class CheckoutScreen extends StatefulWidget {
  final List<Product> products;
  static const routeName = "/checkout";
  const CheckoutScreen({Key? key, required this.products}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int? selectedDeliveryAddressIndex;
  int? selectedBillingAddressIndex;
  bool billingSameAsDelivery = true;
  bool isLoading = false;
  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    TabsProvider tabsProvider = Provider.of<TabsProvider>(context);
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: ListView(padding: EdgeInsets.zero, children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 20),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(Icons.arrow_back_ios_new_rounded)),
                    const SizedBox(width: 12),
                    const EcomText(
                      "Checkout",
                      size: 18,
                    ),
                  ],
                ),
              ),
              CheckoutOrderSummary(products: widget.products),
              CheckoutOrderDetails(products: widget.products),
              Container(
                color: Colors.blueGrey[50],
                padding: const EdgeInsets.only(bottom: 20),
                margin: const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 26, vertical: 16),
                      child: EcomText(
                        "Delivery Address",
                        size: 18,
                      ),
                    ),
                    SizedBox(
                      height: 164,
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(left: 10),
                        scrollDirection: Axis.horizontal,
                        itemCount: userProvider.getUser.address!.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  selectedDeliveryAddressIndex = index;
                                  setState(() {});
                                },
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  child: AddressTile(
                                      removable: true,
                                      size: 14,
                                      address:
                                          userProvider.getUser.address![index]),
                                ),
                              ),
                              selectedDeliveryAddressIndex == index
                                  ? Positioned(
                                      child: Icon(Icons.done_all),
                                      right: 26,
                                      top: 12)
                                  : SizedBox()
                            ],
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6, left: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            value: billingSameAsDelivery,
                            fillColor: MaterialStateProperty.all(Colors.black),
                            onChanged: (value) {
                              setState(() {
                                billingSameAsDelivery = !billingSameAsDelivery;
                              });
                            },
                          ),
                          const Flexible(
                            child: EcomText(
                              "Billing address is same as Delivery address",
                              //weight: FontWeight.w300,
                              size: 12,
                            ),
                          )
                        ],
                      ),
                    ),
                    if (!billingSameAsDelivery)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 26, vertical: 16),
                            child: EcomText(
                              "Billing Address",
                              size: 18,
                            ),
                          ),
                          SizedBox(
                            height: 164,
                            child: ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.only(left: 10),
                              scrollDirection: Axis.horizontal,
                              itemCount: userProvider.getUser.address!.length,
                              itemBuilder: (context, index) {
                                return Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        selectedBillingAddressIndex = index;
                                        setState(() {});
                                      },
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.2,
                                        child: AddressTile(
                                            removable: true,
                                            size: 14,
                                            address: userProvider
                                                .getUser.address![index]),
                                      ),
                                    ),
                                    selectedBillingAddressIndex == index
                                        ? Positioned(
                                            child: Icon(Icons.done_all),
                                            right: 26,
                                            top: 12)
                                        : SizedBox()
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: EcomButton(
                    text: "Pay Amount",
                    func: () {
                      if (selectedDeliveryAddressIndex == null) {
                        HelperMethods.showSnack(
                            margin: 80,
                            context: context,
                            message: "Select a delivery address");
                        return;
                      }
                      if (!billingSameAsDelivery &&
                          selectedBillingAddressIndex == null) {
                        HelperMethods.showSnack(
                            margin: 80,
                            context: context,
                            message: "Select a billing address");
                        return;
                      }
                      setState(() {
                        isLoading = true;
                      });
                      Order currentOrder = Order(
                          cartItems: null,
                          orderedBy: currentUser!.uid,
                          address: null,
                          totalAmount: userProvider
                              .fetchCartTotal(widget.products)["total"]!,
                          subtotalAmount: userProvider
                              .fetchCartTotal(widget.products)["subtotal"]!,
                          savingsAmount: userProvider
                              .fetchCartTotal(widget.products)["savings"]!,
                          couponAmount: userProvider.fetchCartTotal(
                              widget.products)["coupon_savings"]!,
                          orderPlacedDate: DateTime.now(),
                          orderUpdatedDate: DateTime.now(),
                          orderStatus: "created",
                          orderId: null);

                      List<Address> address = [];
                      address.add(userProvider
                          .getUser.address![selectedDeliveryAddressIndex!]);
                      if (!billingSameAsDelivery) {
                        address.add(userProvider
                            .getUser.address![selectedBillingAddressIndex!]);
                      }
                      try {
                        // OrderService()
                        //     .createOrder(currentOrder,
                        //         userProvider.getUser.cart!, address)
                        //     .then((v) {
                        //   userProvider.emptyCart();
                        //   userProvider.removeCoupon();
                        //   tabsProvider.changeIndex(4);
                        //   orderProvider.addOrder(order: v);
                        //   Navigator.of(context).pushReplacementNamed(
                        //       OrderPlaced.routeName,
                        //       arguments: v.orderId);
                        // });
                      } catch (e) {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    isLoading: isLoading),
              )
            ])));
  }
}
