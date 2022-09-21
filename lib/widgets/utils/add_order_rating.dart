import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart' as intl;
import 'package:sampleecom/helpers/methods.dart';
import 'package:sampleecom/services/product_service.dart';
import 'package:sampleecom/widgets/ecom_text_field.dart';

class AddOrderRating extends StatefulWidget {
  final String userId;
  final int index;
  final String userImage;
  final String userName;
  final String productId;
  final void Function(Map rating, int index) func;
  const AddOrderRating(
      {Key? key,
      required this.func,
      required this.userId,
      required this.userImage,
      required this.userName,
      required this.productId,
      required this.index})
      : super(key: key);

  @override
  State<AddOrderRating> createState() => _AddOrderRatingState();
}

class _AddOrderRatingState extends State<AddOrderRating> {
  TextEditingController reviewController = TextEditingController();
  Map rating = {};

  @override
  void initState() {
    rating = {
      "desc": "",
      "stars": 1.0,
      "userId": widget.userId,
      "userImage": widget.userImage,
      "userName": widget.userName,
      "ratingDate": DateTime.now().toIso8601String(),
      "id": widget.productId
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RatingBar(
                      initialRating: rating["stars"],
                      minRating: 1,
                      glow: false,
                      direction: Axis.horizontal,
                      itemSize: 24,
                      unratedColor: const Color(0xFF9FA8B0),
                      itemCount: 5,
                      ratingWidget: RatingWidget(
                          empty: const Icon(
                            Icons.star_border_outlined,
                            color: Colors.amber,
                          ),
                          half: const Icon(
                            Icons.star_half_outlined,
                            color: Colors.amber,
                          ),
                          full: const Icon(
                            Icons.star,
                            color: Colors.amber,
                          )),
                      itemPadding: const EdgeInsets.symmetric(horizontal: .0),
                      onRatingUpdate: (r) {
                        rating["stars"] = r;
                        setState(() {});
                      }),
                  Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                widget.func({}, -1);
                              },
                              child: Icon(Icons.close, color: Colors.red)),
                          SizedBox(width: 8),
                          GestureDetector(
                              onTap: () async {
                                if (reviewController.text.trim().isNotEmpty) {
                                  rating["desc"] = reviewController.text;
                                  dynamic data = await ProductService()
                                      .rateProduct(rating: rating);
                                  if (data == true) {
                                    widget.func(rating, widget.index);
                                  } else {
                                    HelperMethods.showSnack(
                                        context: context,
                                        message:
                                            "Adding review failed. Try again later");
                                  }
                                }
                              },
                              child: Icon(Icons.done, color: Colors.black))
                        ],
                      )),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                    left: 12, right: 12, top: 8, bottom: 12),
                child: EcomTextField(
                    controller: reviewController,
                    hintText: "Review ",
                    isPassword: false))
          ]),
    );
  }
}
