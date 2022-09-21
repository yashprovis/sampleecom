import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart' as intl;

class RatingTile extends StatelessWidget {
  final Map rating;

  const RatingTile({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15.0, left: 5),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: .5)),
      width: 220,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  rating["userImage"] == ""
                      ? CircleAvatar(
                          radius: 22.5,
                          child: Text(
                            rating["userName"].toString().substring(0, 2),
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                letterSpacing: -.8,
                                color: Colors.white),
                          ),
                        )
                      : CircleAvatar(
                          radius: 22.5,
                          backgroundImage: NetworkImage(rating["userImage"]),
                        ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 130,
                        child: Text(
                          rating["userName"],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              height: 1.2,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
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
                      const SizedBox(
                        height: 3,
                      ),
                      RatingBar(
                          initialRating: rating["stars"].toDouble(),
                          minRating: 0,
                          glow: false,
                          ignoreGestures: true,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemSize: 12,
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
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: .0),
                          onRatingUpdate: (rating) {}),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 12),
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
