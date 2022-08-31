import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sampleecom/models/product_model.dart';
import 'package:sampleecom/provider/user_provider.dart';
import 'package:sampleecom/screens/product_detail.dart';
import 'package:sampleecom/widgets/ecom_text.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  const ProductTile({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(ProductDetailScreen.routeName, arguments: product.id),
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: .3, color: Colors.blueGrey)),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                children: [
                  Image.network(
                    product.image,
                    height: 170,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            alignment: Alignment.centerLeft,
                            height: 38,
                            child: EcomText(
                              product.title,
                              size: 15,
                              weight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              EcomText("₹${product.price}", size: 14),
                              Text(
                                "₹${product.mrp}",
                                style: const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ))
                ],
              ),
              Positioned(
                right: 15,
                top: 15,
                child: GestureDetector(
                  onTap: () => userProvider.alterFav(
                      productId: product.id,
                      isFav:
                          userProvider.getUser.favourites.contains(product.id)),
                  child: CircleAvatar(
                      backgroundColor: Colors.black12,
                      radius: 16,
                      child: Icon(
                          userProvider.getUser.favourites.contains(product.id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 20,
                          color: Colors.black)),
                ),
              )
            ],
          )),
    );
  }
}
