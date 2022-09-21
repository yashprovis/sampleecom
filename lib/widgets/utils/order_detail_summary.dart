import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampleecom/models/product_model.dart';
import 'package:sampleecom/provider/user_provider.dart';
import 'package:sampleecom/widgets/ecom_button.dart';
import 'package:sampleecom/widgets/ecom_text.dart';
import 'package:sampleecom/widgets/tiles/rating_tile.dart';
import 'package:sampleecom/widgets/utils/add_order_rating.dart';

import '../../models/order_model.dart';
import 'order_detail_ratings.dart';

class OrderDetailSummary extends StatefulWidget {
  final Order order;
  List<Product> products;
  OrderDetailSummary({Key? key, required this.products, required this.order})
      : super(key: key);

  @override
  State<OrderDetailSummary> createState() => _OrderDetailSummaryState();
}

class _OrderDetailSummaryState extends State<OrderDetailSummary> {
  bool addMode = false;

  void alterRatings(Map rating, int i) {
    if (rating.isEmpty) {
      addMode = false;
    } else {
      widget.products[i].ratings.add(rating);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 6, left: 26, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          ListView.builder(
            itemCount: widget.products.length,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              int i = widget.products[index].ratings.indexWhere(
                  (element) => element["userId"] == widget.order.orderedBy);
              Map userProductReview = {};
              if (i != -1) {
                userProductReview = widget.products[index].ratings[i];
              }
              return ListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                  title: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: 80,
                              height: 80,
                              child: Image.network(
                                widget.products[index].image,
                                fit: BoxFit.cover,
                              )),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 140,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: EcomText(
                                        "${widget.order.cartItems![index].qty} x ${widget.products[index].title}",
                                        size: 16)),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: EcomText(
                                      "Price: ₹${widget.products[index].price}.00, Size: ${widget.order.cartItems![index].size}",
                                      size: 14),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      userProductReview.isNotEmpty
                          ? OrderDetailRatings(rating: userProductReview)
                          : addMode
                              ? AddOrderRating(
                                  index: index,
                                  func: alterRatings,
                                  userId: userProvider.getUser.uid,
                                  userImage: userProvider.getUser.image,
                                  userName: userProvider.getUser.name,
                                  productId: widget.products[index].id)
                              : Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: EcomButton(
                                    text: "Add Review",
                                    width: 116,
                                    height: 26,
                                    textSize: 14,
                                    isLoading: false,
                                    func: () {
                                      addMode = true;
                                      setState(() {});
                                    },
                                  ),
                                ),
                    ],
                  ));
            },
          )
        ],
      ),
    );
  }
}
