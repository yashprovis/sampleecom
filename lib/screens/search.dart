import 'package:firestore_search/firestore_search.dart';
import 'package:flutter/material.dart';
import 'package:sampleecom/services/product_service.dart';
import '../models/product_model.dart';
import '../widgets/tiles/search_tile.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = "/search";
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  List<Product> products = [];

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
            padding: EdgeInsets.only(top: 60, left: 10, right: 10),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.arrow_back_ios_new_rounded)),
                ),
                SizedBox(
                  width: size.width - 50,
                  height: 60,
                  // child: EcomTextField(
                  //     onSubmit: () {
                  //       fetchProducts(searchController.text);
                  //     },
                  //     suffixIcon: Padding(
                  //       padding: const EdgeInsets.only(top: 14, right: 10),
                  //       child: GestureDetector(
                  //           onTap: () {
                  //             fetchProducts(searchController.text);
                  //           },
                  //           child: Text(
                  //             'Search',
                  //             style: TextStyle(fontWeight: FontWeight.w500),
                  //           )),
                  //     ),
                  //     controller: searchController,
                  //     hintText: "Search products",
                  //     isPassword: false),
                  child: FirestoreSearchBar(
                    tag: "tag",
                    searchBackgroundColor: Colors.grey[200],
                  ),
                )
              ],
            )),
        SizedBox(
            height: size.height - 120,
            // child: products.isEmpty
            //     ? Center(child: Lottie.asset("assets/lottie/search_empty.json"))
            //     : ListView.builder(
            //         padding: EdgeInsets.symmetric(horizontal: 10),
            //         itemCount: products.length,
            //         itemBuilder: (context, index) {
            //           return SearchTile(
            //             product: products[index],
            //           );
            //         },
            //       ),
            child: FirestoreSearchResults.builder(
              tag: 'tag',
              firestoreCollectionName: 'products',
              searchBy: 'title',
              initialBody: const Center(
                child: Text('Initial body'),
              ),
              dataListFromSnapshot: Product.productFromSnapshot,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<Product>? dataList = snapshot.data;
                  if (dataList!.isEmpty) {
                    return const Center(
                      child: Text('No Results Returned'),
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    itemCount: dataList.length,
                    itemBuilder: (context, index) {
                      return SearchTile(
                        product: dataList[index],
                      );
                    },
                  );
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text('No Results Returned'),
                    );
                  }
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ))
      ]),
    );
  }
}
