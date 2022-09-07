import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sampleecom/services/product_service.dart';
import '../models/product_model.dart';
import '../widgets/ecom_text_field.dart';
import '../widgets/tiles/search_tile.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = "/search";
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  List<Product>? products;

  fetchProducts(String searchString) async {
    products = await ProductService().fetchProductsFromSearch(searchString);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(children: [
        Container(
            height: 120,
            padding: const EdgeInsets.only(top: 60, left: 10, right: 10),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.arrow_back_ios_new_rounded)),
                ),
                const SizedBox(width: 15),
                SizedBox(
                  width: size.width - 65,
                  height: 60,
                  child: EcomTextField(
                      func: (v) {
                        if (v != null && v.isNotEmpty) {
                          fetchProducts(v);
                        }
                      },
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(top: 14, right: 10),
                        child: GestureDetector(
                            onTap: () {
                              if (searchController.text.isNotEmpty) {
                                fetchProducts(searchController.text);
                              }
                            },
                            child: const Text(
                              'Search',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            )),
                      ),
                      controller: searchController,
                      hintText: "Search products",
                      isPassword: false),
                  // child: FirestoreSearchBar(
                  //   tag: "tag",
                  //   searchBackgroundColor: Colors.grey[200],
                  // ),
                )
              ],
            )),
        SizedBox(
          height: size.height - 120 - MediaQuery.of(context).viewInsets.bottom,
          child: products == null
              ? const SizedBox()
              : products!.isEmpty
                  ? Center(
                      child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 40, left: 40, right: 40),
                      child: Lottie.asset("assets/lottie/search_empty.json"),
                    ))
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemCount: products!.length,
                      itemBuilder: (context, index) {
                        return SearchTile(
                          product: products![index],
                        );
                      },
                    ),
        )
      ]),
    );
  }
}
