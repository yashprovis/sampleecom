import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampleecom/provider/order_provider.dart';
import 'package:sampleecom/services/product_service.dart';
import 'package:sampleecom/widgets/utils/order_detail_bill.dart';
import 'package:sampleecom/widgets/utils/order_detail_summary.dart';

import '../models/product_model.dart';
import '../widgets/ecom_text.dart';

class OrderDetail extends StatefulWidget {
  static const routeName = "/orderDetail";
  final String orderId;
  const OrderDetail({Key? key, required this.orderId}) : super(key: key);

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  List<Product>? products = [];

  @override
  void initState() {
    super.initState();
    OrderProvider orderProvider =
        Provider.of<OrderProvider>(context, listen: false);
    List<String> ids =
        orderProvider.fetchOrderProductIds(orderId: widget.orderId);
    ProductService().fetchProductsFromId(ids).then((value) {
      products = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);
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
                    const EcomText(
                      "Order Detail",
                      size: 18,
                    ),
                  ],
                ),
              ),
              OrderDetailSummary(
                  products: products!,
                  order:
                      orderProvider.fetchSingleOrder(orderId: widget.orderId)),
              OrderDetailBill(
                  order:
                      orderProvider.fetchSingleOrder(orderId: widget.orderId))
            ])));
  }
}
