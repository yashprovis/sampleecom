import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sampleecom/screens/order_detail.dart';

import '../helpers/methods.dart';
import '../provider/order_provider.dart';
import '../widgets/ecom_text.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = "/orders";
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider =
        Provider.of<OrderProvider>(context, listen: false);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 20),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(Icons.arrow_back_ios_new_rounded)),
                    const SizedBox(width: 12),
                    EcomText(
                      "Order History",
                      size: 18,
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: orderProvider.getUserOrders.length,
                reverse: true,
                padding: EdgeInsets.only(top: 10),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.grey.shade300))),
                    // dense: true,
                    margin: EdgeInsets.only(top: 10, left: 12, right: 12),
                    padding: EdgeInsets.only(top: 10, bottom: 6),
                    child: Card(
                      elevation: 2,
                      margin: EdgeInsets.zero,
                      child: ListTile(
                          dense: true,
                          onTap: () => Navigator.of(context).pushNamed(
                              OrderDetail.routeName,
                              arguments:
                                  orderProvider.getUserOrders[index].orderId!),
                          trailing: Icon(Icons.arrow_forward_ios_rounded),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              EcomText(
                                "Order Id: ${orderProvider.getUserOrders[index].orderId!}",
                                size: 12,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: EcomText(
                                  "Total: ₹${formatNumber(orderProvider.getUserOrders[index].totalAmount)}",
                                  size: 12,
                                ),
                              ),
                            ],
                          ),
                          subtitle: EcomText(
                            "Date: ${DateFormat("MMMM dd, y hh:mm a").format(orderProvider.getUserOrders[index].orderPlacedDate)}",
                            size: 12,
                          )),
                    ),
                  );
                },
              )
            ])));
  }
}
