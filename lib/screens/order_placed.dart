import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sampleecom/constants.dart';
import 'package:sampleecom/screens/order_detail.dart';
import 'package:sampleecom/widgets/ecom_button.dart';
import 'package:sampleecom/widgets/ecom_text.dart';

import '../provider/tabs_provider.dart';

class OrderPlaced extends StatelessWidget {
  final String orderId;
  static const routeName = "/orderPlaced";
  const OrderPlaced({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TabsProvider tabsProvider = Provider.of<TabsProvider>(context);
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 50, right: 20),
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.close, size: 36)),
          ),
        ),
        Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: EcomText(
                "Order Placed Successfully!!",
                size: 26,
                align: TextAlign.center,
              ),
            ),
            Lottie.asset("assets/lottie/order_placed.json"),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Card(
              elevation: 4,
              child: EcomButton(
                  text: "View Order",
                  func: () {
                    Navigator.of(context).pushReplacementNamed(
                        OrderDetail.routeName,
                        arguments: orderId);
                  },
                  isLoading: false)),
        ),
        Padding(
            padding: const EdgeInsets.only(bottom: 80, left: 20, right: 20),
            child: Card(
                elevation: 4,
                child: EcomButton(
                  text: "Back To Home",
                  color: Colors.white,
                  textColor: primaryColor,
                  func: () {
                    tabsProvider.changeIndex(0);
                    Navigator.of(context).pop();
                  },
                  isLoading: false,
                )))
      ],
    ));
  }
}
