import 'package:flutter/material.dart';

import '../../models/order_model.dart';

import '../ecom_text.dart';
import '../tiles/address_tile.dart';

class OrderDetailAddress extends StatelessWidget {
  final Order order;
  const OrderDetailAddress({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 30, left: 15, right: 20),
        child: Card(
          elevation: 2,
          child: ExpansionTile(
            initiallyExpanded: true,
            title: const EcomText("Order Addresses"),
            iconColor: Colors.black,
            childrenPadding:
                const EdgeInsets.only(bottom: 6, right: 4, left: 10),
            children: [
              SizedBox(
                  // height: 135,
                  //width: MediaQuery.of(context).size.width / 3,
                  child: AddressTile(
                address: order.address![0],
                leftMargin: 0.0,
                removable: true,
              )),
              const SizedBox(height: 4),
              if (order.address!.length == 2)
                SizedBox(
                    height: 135,
                    // width: MediaQuery.of(context).size.width / 3,
                    child: AddressTile(
                      address: order.address![1],
                      leftMargin: 0,
                      removable: true,
                    )),
            ],
          ),
        ));
  }
}
