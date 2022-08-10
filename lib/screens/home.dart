import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sampleecom/screens/search.dart';

import 'package:sampleecom/widgets/tiles/banner_tile.dart';

import 'package:sampleecom/widgets/ecom_text.dart';
import 'package:sampleecom/widgets/utils/cart_heaer_button.dart';

import '../models/banner_model.dart';
import '../services/banner_service.dart';
import '../widgets/ecom_loader.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<BannerModel> banners = [];
  @override
  void initState() {
    BannerService().fetchBanner().then((value) => setState(() {
          banners = value;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: banners.isEmpty
              ? const Center(child: EcomLoader())
              : ListView(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  children: [
                    SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                height: 60,
                                width: 60,
                                child: Image.asset(
                                    'assets/images/transparent_logo.jpg')),
                            Row(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushNamed(SearchScreen.routeName);
                                    },
                                    child:
                                        Icon(CupertinoIcons.search, size: 32)),
                                const SizedBox(width: 14),
                                const CartHeaderButton()
                              ],
                            )
                          ],
                        )),
                    Padding(
                        padding: const EdgeInsets.only(top: 20, left: 10),
                        child: EcomText(
                          banners[currentIndex].title,
                          color: Colors.black,
                          size: 32,
                          weight: FontWeight.w300,
                        )),
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 10, left: 20),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, i) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black),
                            height: 10,
                            width: currentIndex == i ? 60 : 10,
                          );
                        },
                        itemCount: banners.length,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 320,
                      child: PageView.builder(
                        //  physics: const NeverScrollableScrollPhysics(),
                        // padding: const EdgeInsets.only(bottom: 20),
                        // shrinkWrap: true,
                        onPageChanged: (int i) {
                          setState(() {
                            currentIndex = i;
                          });
                        },
                        itemCount: banners.length,
                        itemBuilder: (context, index) {
                          return BannerTile(
                            banner: banners[index],
                          );
                        },
                      ),
                    ),
                  ],
                ),
        ));
  }
}

// class PageViewWidget extends StatefulWidget {
//   @override
//   _PageViewWidgetState createState() => _PageViewWidgetState();
// }

// class _PageViewWidgetState extends State<PageViewWidget> {
//   List _list = [];

//   PageController? pageController;

//   double viewportFraction = 0.8;

//   double? pageOffset = 0;

//   @override
//   void initState() {
//     super.initState();
//     pageController =
//         PageController(initialPage: 0, viewportFraction: viewportFraction)
//           ..addListener(() {
//             setState(() {
//               pageOffset = pageController!.page;
//             });
//           });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PageView.builder(
//       controller: pageController,
//       itemBuilder: (context, index) {
//         double scale = max(viewportFraction,
//             (1 - (pageOffset! - index).abs()) + viewportFraction);

//         double angle = (pageOffset! - index).abs();

//         if (angle > 0.5) {
//           angle = 1 - angle;
//         }
//         return Container(
//           padding: EdgeInsets.only(
//             right: 10,
//             left: 20,
//             top: 100 - scale * 25,
//             bottom: 50,
//           ),
//           child: Transform(
//             transform: Matrix4.identity()
//               ..setEntry(
//                 3,
//                 2,
//                 0.001,
//               )
//               ..rotateY(angle),
//             alignment: Alignment.center,
//             child: Stack(
//               children: <Widget>[
//                 Image.asset(
//                   _list[index].url,
//                   width: MediaQuery.of(context).size.width,
//                   fit: BoxFit.none,
//                   alignment: Alignment((pageOffset! - index).abs() * 0.5, 0),
//                 ),
//                 Positioned(
//                   bottom: 60,
//                   left: 20,
//                   child: AnimatedOpacity(
//                     opacity: angle == 0 ? 1 : 0,
//                     duration: Duration(
//                       milliseconds: 200,
//                     ),
//                     child: Text(
//                       _list[index].name,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 25,
//                         fontWeight: FontWeight.bold,
//                         letterSpacing: 1.2,
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         );
//       },
//       itemCount: _list.length,
//     );
//   }
// }
