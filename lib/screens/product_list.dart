import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampleecom/models/product_model.dart';
import 'package:sampleecom/screens/search.dart';
import 'package:sampleecom/widgets/ecom_no_products.dart';
import 'package:sampleecom/widgets/utils/cart_heaer_button.dart';

import '../provider/tabs_provider.dart';
import '../provider/user_provider.dart';
import '../services/product_service.dart';
import '../widgets/ecom_loader.dart';
import '../widgets/ecom_text.dart';
import '../widgets/sheets/filter_size_sheet.dart';
import '../widgets/tiles/product_tile.dart';

class ProductListScreen extends StatefulWidget {
  final Map args;
  static const routeName = "/productList";
  const ProductListScreen({Key? key, required this.args}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product>? products;
  bool? isPriceDesc;
  @override
  void initState() {
    fetchProducts();
    super.initState();
  }

  fetchProducts([bool? isPriceDesc, Map? filters]) {
    setState(() {
      products = null;
    });
    ProductService()
        .fetchProducts(widget.args['categories'], isPriceDesc, filters)
        .then((value) {
      products = value;
      setState(() {});
    });
  }

  showFilterSheet([List? initialSizes, RangeValues? initialPrice]) {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        builder: (builder) {
          return FilterSizeSheet(
              initialPrice: initialPrice, initialSizes: initialSizes);
        }).whenComplete(() {
      UserProvider userProvider =
          Provider.of<UserProvider>(context, listen: false);
      if (userProvider.searchFilters) {
        fetchProducts(isPriceDesc,
            userProvider.filters.isEmpty ? null : userProvider.filters);
      }
    });
  }

  List sortItems = ['Relevance', 'Lowest Price', 'Highest Price'];
  String? selectedSortItem;
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: products == null
                ? const Center(child: EcomLoader())
                : Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 20),
                      child: SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                      onTap: () => Navigator.of(context).pop(),
                                      child: const Icon(
                                          Icons.arrow_back_ios_new_rounded)),
                                  const SizedBox(width: 12),
                                  EcomText(
                                    widget.args['title'],
                                    size: 18,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed(SearchScreen.routeName);
                                      },
                                      child: const Icon(CupertinoIcons.search,
                                          size: 28)),
                                  const SizedBox(width: 14),
                                  CartHeaderButton(
                                    func: () {
                                      Navigator.of(context).pop();
                                      context
                                          .read<TabsProvider>()
                                          .changeIndex(3);
                                    },
                                  )
                                ],
                              )
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                  customButton: Container(
                                    height: 40,
                                    width:
                                        MediaQuery.of(context).size.width * .5 -
                                            30,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          selectedSortItem ?? 'Revelance ',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white),
                                        ),
                                        const Icon(
                                            CupertinoIcons.arrow_up_arrow_down,
                                            color: Colors.white,
                                            size: 20)
                                      ],
                                    ),
                                  ),
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                  ),
                                  value: selectedSortItem,
                                  onChanged: (value) {
                                    if (value == "Highest Price") {
                                      isPriceDesc = true;
                                    } else if (value == "Lowest Price") {
                                      isPriceDesc = false;
                                    } else {
                                      isPriceDesc = null;
                                    }
                                    selectedSortItem = value as String;
                                    fetchProducts(
                                        isPriceDesc,
                                        userProvider.searchFilters &&
                                                userProvider.filters.isNotEmpty
                                            ? userProvider.filters
                                            : null);
                                  },
                                  items: sortItems
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                      .toList()),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showFilterSheet(
                                  userProvider.filters.containsKey("sizes")
                                      ? userProvider.filters["sizes"]
                                      : null,
                                  userProvider.filters.containsKey("startPrice")
                                      ? RangeValues(
                                          userProvider.filters["startPrice"],
                                          userProvider.filters["endPrice"])
                                      : null);
                            },
                            child: Container(
                              height: 40,
                              width:
                                  MediaQuery.of(context).size.width * .5 - 30,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(right: 15),
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  EcomText(
                                    'Filter ',
                                    size: 14,
                                    color: Colors.black,
                                  ),
                                  Icon(CupertinoIcons.slider_horizontal_3)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    products!.isEmpty
                        ? const Center(child: EcomNoProducts())
                        : GridView.builder(
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisExtent: 250,
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 4,
                                    crossAxisSpacing: 4),
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            itemCount: products!.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ProductTile(product: products![index]);
                            },
                          ),
                  ])));
  }
}
