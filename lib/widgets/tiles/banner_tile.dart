import 'package:flutter/material.dart';
import 'package:sampleecom/models/banner_model.dart';

class BannerTile extends StatelessWidget {
  final BannerModel banner;
  const BannerTile({Key? key, required this.banner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
          child: Image.network(banner.image, fit: BoxFit.cover),
        ),
        const Positioned(
          bottom: 15,
          right: 25,
          child: CircleAvatar(
              radius: 24,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black,
                size: 28,
              )),
        )
      ],
    );
  }
}
