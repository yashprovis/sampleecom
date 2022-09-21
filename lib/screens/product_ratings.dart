import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart' as intl;

import '../widgets/ecom_text.dart';

class RatingsScreen extends StatelessWidget {
  final Map args;
  static const routeName = "/ratings";
  const RatingsScreen({Key? key, required this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 24,
                      //color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const EcomText(
                    "Ratings",
                    // color: Colors.white,
                    size: 20,
                    //   weight: FontWeight.w500,
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 2),
              height: MediaQuery.of(context).size.height - 75,
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 16),
                itemCount: args['ratings'].length,
                itemBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: const BorderSide(
                                color: Color(0xFFABB2BA), width: .4),
                            top: index == 0
                                ? const BorderSide(
                                    color: Color(0xFFABB2BA), width: .3)
                                : const BorderSide(
                                    width: 0.1, color: Colors.white))),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 2.0, bottom: 2),
                          child: args['ratings'][index]["userImage"] == ""
                              ? CircleAvatar(
                                  radius: 30,
                                  child: Text(
                                    args["ratings"][index]["userName"]
                                        .toString()
                                        .substring(0, 2),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                        letterSpacing: -.8,
                                        color: Colors.white),
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      args['ratings'][index]["userImage"]),
                                ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 105,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    args['ratings'][index]["userName"],
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    intl.DateFormat.yMMMd().format(
                                        (DateTime.parse(args['ratings'][index]
                                            ["ratingDate"]))),
                                    style: const TextStyle(
                                        color: Color(0xFF9FA8B0), fontSize: 14),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 3.0),
                              child: RatingBar(
                                initialRating:
                                    args['ratings'][index]["stars"].toDouble(),
                                minRating: 0,
                                glow: false,
                                ignoreGestures: true,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemSize: 18,
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
                                onRatingUpdate: (rating) {},
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 2),
                              padding: const EdgeInsets.only(right: 10),
                              width: MediaQuery.of(context).size.width - 115,
                              child: Text(
                                args['ratings'][index]["desc"],
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Color(0xFF707070), fontSize: 14),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
