import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sampleecom/models/category_model.dart';
import 'package:sampleecom/screens/product_list.dart';
import 'package:sampleecom/screens/search.dart';

import 'package:sampleecom/widgets/tiles/banner_tile.dart';

import 'package:sampleecom/widgets/ecom_text.dart';
import 'package:sampleecom/widgets/utils/cart_heaer_button.dart';

import '../models/banner_model.dart';
import '../services/banner_service.dart';
import '../services/category_service.dart';
import '../widgets/ecom_loader.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<BannerModel> banners = [];
  List<SubCategory> subcategory = [];
  @override
  void initState() {
    BannerService().fetchBanner().then((value) {
      if (mounted) {
        setState(() {
          banners = value;
        });
      }
    });
    CategoryService().fetchCategory().then((value) {
      if (mounted) {
        setState(() {
          for (var subcat in value) {
            subcategory.addAll(subcat.subcategory);
            subcategory.shuffle();
          }
        });
      }
    });
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
                  padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
                  children: [
                    SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Transform.scale(
                              scale: 1.4,
                              child: SizedBox(
                                  height: 60,
                                  width: 60,
                                  child: Image.asset(
                                      'assets/images/transparent_logo.png')),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushNamed(SearchScreen.routeName);
                                    },
                                    child: const Icon(CupertinoIcons.search,
                                        size: 32)),
                                const SizedBox(width: 14),
                                const CartHeaderButton()
                              ],
                            )
                          ],
                        )),
                    Padding(
                        padding: const EdgeInsets.only(top: 24, left: 10),
                        child: EcomText(
                          banners[currentIndex].title,
                          color: Color(0xFF080808),
                          size: 30,
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
                                color: Color(0xFF080808)),
                            height: 10,
                            width: currentIndex == i ? 60 : 10,
                          );
                        },
                        itemCount: banners.length,
                      ),
                    ),
                    SizedBox(
                      height: 400,
                      child: PageView.builder(
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
                    Transform.scale(
                      scale: 1.15,
                      child: Container(
                          color: Color(0xFF080808),
                          margin: const EdgeInsets.only(top: 30),
                          padding: const EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: const EcomText(
                            "Browse Categories",
                            color: Colors.white,
                            size: 18,
                            weight: FontWeight.w400,
                          )),
                    ),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, mainAxisExtent: 140),
                      padding: const EdgeInsets.only(bottom: 20, top: 30),
                      shrinkWrap: true,
                      itemCount:
                          subcategory.length > 9 ? 9 : subcategory.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                ProductListScreen.routeName,
                                arguments: {
                                  "categories": [subcategory[index].name],
                                  "title": subcategory[index].name,
                                });
                          },
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(width: .5)),
                                margin: const EdgeInsets.only(bottom: 8),
                                height: 100,
                                width: MediaQuery.of(context).size.width / 4,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    subcategory[index].image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              EcomText(
                                subcategory[index].name,
                                color: Color(0xFF080808),
                                size: 16,
                                weight: FontWeight.w400,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
        ));
  }
}
