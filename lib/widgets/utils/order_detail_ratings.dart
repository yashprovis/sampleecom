import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetailRatings extends StatelessWidget {
  final Map rating;

  const OrderDetailRatings({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12, top: 10),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFABB2BA), width: .5)),
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
                      initialRating: rating["stars"].toDouble(),
                      minRating: 0,
                      glow: false,
                      ignoreGestures: true,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
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
                      onRatingUpdate: (rating) {}),
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Text(
                      intl.DateFormat.yMMMd()
                          .format(DateTime.parse(rating["ratingDate"])),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 12, bottom: 4),
              child: Text(rating["desc"],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  style: TextStyle(
                      height: 1.4, fontSize: 14, color: Colors.grey[800])),
            )
          ]),
    );
  }
}
