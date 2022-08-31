import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sampleecom/models/cart_model.dart';
import 'package:sampleecom/models/product_model.dart';
import 'package:sampleecom/provider/user_provider.dart';
import 'package:sampleecom/services/product_service.dart';
import 'package:sampleecom/widgets/ecom_button.dart';
import 'package:sampleecom/widgets/ecom_text.dart';
import 'package:sampleecom/widgets/sheets/size_sheet.dart';
import 'package:sampleecom/widgets/utils/cart_heaer_button.dart';

import '../widgets/ecom_loader.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;
  static const routeName = "/product-detail";
  const ProductDetailScreen({Key? key, required this.productId})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  Product? product;
  int currentImageIndex = 0;

  num? currentSize;
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  @override
  void initState() {
    ProductService().fetchProduct(widget.productId).then((value) {
      product = value;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    currentSize = userProvider.productExistInCart(id: widget.productId)
        ? userProvider.fetchCartItem(id: widget.productId).size
        : null;
    return Scaffold(
        backgroundColor: Colors.white,
        body: product == null
            ? const Center(child: EcomLoader())
            : ListView(
                padding: EdgeInsets.zero,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .55,
                        child: PageView.builder(
                          controller: pageController,
                          onPageChanged: (v) => setState(() {
                            currentImageIndex = v;
                          }),
                          itemCount: product!.imageList.length,
                          itemBuilder: (context, index) => Image.network(
                            product!.imageList[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 50, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: const CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius: 22,
                                  child: Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    size: 24,
                                    color: Colors.white,
                                  )),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                    onTap: () => userProvider.alterFav(
                                        productId: product!.id,
                                        isFav: userProvider.getUser.favourites
                                            .contains(product!.id)),
                                    child: CircleAvatar(
                                        backgroundColor: Colors.black,
                                        radius: 22,
                                        child: Icon(
                                            userProvider.getUser.favourites
                                                    .contains(product!.id)
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: Colors.white,
                                            size: 26))),
                                const SizedBox(width: 14),
                                const CircleAvatar(
                                    backgroundColor: Colors.black,
                                    radius: 22,
                                    child: CartHeaderButton(
                                      size: 24,
                                      color: Colors.white,
                                    ))
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 100,
                    child: Center(
                      child: ListView.builder(
                        itemCount: product!.imageList.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              pageController.animateToPage(index,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.linear);
                            },
                            child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.all(10),
                                width: 80,
                                decoration: BoxDecoration(
                                    border: currentImageIndex == index
                                        ? Border.all(width: 2)
                                        : null,
                                    borderRadius: BorderRadius.circular(50),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      colorFilter: currentImageIndex == index
                                          ? null
                                          : ColorFilter.mode(
                                              Colors.black.withOpacity(0.5),
                                              BlendMode.dstATop),
                                      image: NetworkImage(
                                          product!.imageList[index]),
                                    ))),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        EcomText(
                          product!.title,
                          size: 24,
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "₹${product!.mrp}  ",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey),
                                ),
                                EcomText("₹${product!.price}", size: 20),
                              ],
                            ),
                            userProvider.productExistInCart(id: product!.id)
                                ? Row(
                                    children: [
                                      EcomButton(
                                          height: 36,
                                          text: "–",
                                          width: 40,
                                          func: () {
                                            if (userProvider
                                                    .fetchCartItem(
                                                        id: product!.id)
                                                    .qty ==
                                                1) {
                                              userProvider.removeFromCart(
                                                  cartId: product!.id);
                                            } else {
                                              userProvider.updateCart(
                                                  cartItem: Cart(
                                                      productId: product!.id,
                                                      qty: userProvider
                                                              .fetchCartItem(
                                                                  id: product!
                                                                      .id)
                                                              .qty -
                                                          1,
                                                      size: currentSize!));
                                            }
                                          },
                                          isLoading: false),
                                      EcomText(
                                          "   ${userProvider.fetchCartItem(id: product!.id).qty}   ",
                                          size: 20),
                                      EcomButton(
                                          width: 40,
                                          height: 36,
                                          text: "+",
                                          func: () {
                                            userProvider.updateCart(
                                                cartItem: Cart(
                                                    productId: product!.id,
                                                    qty: userProvider
                                                            .fetchCartItem(
                                                                id: product!.id)
                                                            .qty +
                                                        1,
                                                    size: currentSize!));
                                          },
                                          isLoading: false),
                                    ],
                                  )
                                : EcomButton(
                                    text: "+ Add To Cart",
                                    textSize: 16,
                                    func: () {
                                      if (currentSize == null) {
                                        sizeSheet(context, product!);
                                        return;
                                      }
                                      userProvider.addToCart(
                                          cartItem: Cart(
                                              productId: product!.id,
                                              qty: 1,
                                              size: currentSize!));
                                    },
                                    height: 40,
                                    width: 150,
                                    isLoading: false)
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(border: Border.all()),
                          child: EcomText(
                            "${((product!.mrp - product!.price) / product!.mrp * 100).toStringAsFixed(0)}% OFF",
                            size: 14,
                            color: Colors.black,
                          ),
                        ),
                        const EcomText(
                          "*Inclusive of all taxes",
                          size: 12,
                          weight: FontWeight.bold,
                        ),
                        Transform.scale(
                          scale: 1.2,
                          child: Container(
                              height: 10,
                              margin:
                                  const EdgeInsets.only(top: 16, bottom: 10),
                              width: double.infinity,
                              color: Colors.grey[300]),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10, bottom: 10),
                          child: EcomText("Select Size: ", size: 18),
                        ),
                        SizedBox(
                          height: 60,
                          child: ListView.builder(
                            itemCount: product!.size.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  if (userProvider.productExistInCart(
                                      id: product!.id)) {
                                    userProvider.updateCart(
                                        cartItem: Cart(
                                            productId: product!.id,
                                            qty: userProvider
                                                .fetchCartItem(id: product!.id)
                                                .qty,
                                            size: product!.size[index]));
                                  }
                                  currentSize = product!.size[index];
                                  setState(() {});
                                },
                                child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 400),
                                    margin: const EdgeInsets.all(8),
                                    width: 44,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border:
                                          currentSize == product!.size[index]
                                              ? Border.all(width: 2.5)
                                              : null,
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: EcomText(
                                        product!.size[index].toString())),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
  }
}
