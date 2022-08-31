import 'package:flutter/material.dart';

import 'package:sampleecom/widgets/ecom_text.dart';

import '../../models/product_model.dart';
import '../../screens/product_detail.dart';

class SearchTile extends StatelessWidget {
  final Product product;
  const SearchTile({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ProductDetailScreen.routeName, arguments: product.id);
      },
      child: Container(
          decoration: const BoxDecoration(border: Border(top: BorderSide())),
          // dense: true,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: SizedBox(
                      width: 70,
                      height: 70,
                      child: Image.network(
                        product.image,
                        fit: BoxFit.cover,
                      ))),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 140,
                      child: EcomText(product.title, size: 14)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: EcomText("Price: ₹${product.price}.00", size: 12),
                  ),
                  EcomText("Sizes: ${product.size}", size: 12)
                ],
              )
            ],
          )),
    );
  }
}
