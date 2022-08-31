import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sampleecom/screens/search.dart';

import 'package:sampleecom/services/category_service.dart';
import 'package:sampleecom/widgets/tiles/category_tile.dart';
import 'package:sampleecom/widgets/ecom_text.dart';
import 'package:sampleecom/widgets/utils/cart_heaer_button.dart';

import '../models/category_model.dart';
import '../widgets/ecom_loader.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Category> category = [];
  @override
  void initState() {
    CategoryService().fetchCategory().then((value) => setState(() {
          category = value;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: category.isEmpty
                ? const Center(child: EcomLoader())
                : ListView(padding: const EdgeInsets.only(top: 20), children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 15),
                      child: SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const EcomText(
                                "Categories",
                                size: 20,
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
                    ),
                    ListView.builder(
                      padding: const EdgeInsets.only(top: 15),
                      itemCount: category.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CategoryTile(category: category[index]);
                      },
                    )
                  ])));
  }
}
