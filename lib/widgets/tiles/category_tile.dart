import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sampleecom/helpers/triangle_painter.dart';
import 'package:sampleecom/models/category_model.dart';
import 'package:sampleecom/screens/product_list.dart';
import 'package:sampleecom/widgets/ecom_button.dart';
import 'package:sampleecom/widgets/ecom_text.dart';

class CategoryTile extends StatefulWidget {
  final Category category;
  const CategoryTile({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryTile> createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => setState(() {
              isExpanded = !isExpanded;
            }),
            child: SizedBox(
              height: 160,
              child: Stack(fit: StackFit.expand, children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: NetworkImage(widget.category.image),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.8), BlendMode.dstATop),
                  )),
                  // child: Image.network(
                  //   category.image,
                  //   fit: BoxFit.cover,
                  // ),
                ),
                Positioned(
                    left: 20,
                    top: 20,
                    child: Row(
                      children: [
                        EcomText(
                          widget.category.name,
                          color: Colors.white,
                          weight: FontWeight.w300,
                          size: 34,
                        ),
                        const SizedBox(width: 6),
                        const Icon(CupertinoIcons.arrow_turn_right_down,
                            color: Colors.white)
                      ],
                    )),
                Positioned(
                    right: 20,
                    height: 32,
                    width: 90,
                    bottom: 10,
                    child: EcomButton(
                        text: "View All",
                        func: () {
                          Navigator.of(context).pushNamed(
                              ProductListScreen.routeName,
                              arguments: {
                                "categories": [widget.category.slug],
                                "title": widget.category.name,
                              });
                        },
                        isLoading: false,
                        textSize: 14)),
                isExpanded
                    ? Positioned(
                        bottom: 0,
                        left: 30,
                        child: SizedBox(
                          height: 12,
                          width: 20,
                          child: CustomPaint(
                            painter: TrianglePainter(
                                strokeWidth: 4,
                                paintingStyle: PaintingStyle.fill),
                          ),
                        ),
                      )
                    : const SizedBox()
              ]),
            ),
          ),
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: widget.category.subcategory.length,
            itemBuilder: (context, index) {
              SubCategory subcat = widget.category.subcategory[index];
              return AnimatedContainer(
                duration: const Duration(seconds: 4),
                height: isExpanded ? null : 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(subcat.image),
                      radius: 20,
                    ),
                    title: EcomText(
                        subcat.name
                            .replaceAll(" for ${widget.category.name}", ''),
                        size: 16),
                    trailing: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(ProductListScreen.routeName, arguments: {
                          "categories": [widget.category.slug, subcat.slug],
                          "title": subcat.name,
                        });
                      },
                      child: const Icon(Icons.arrow_forward_ios_rounded,
                          size: 20, color: Colors.black),
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
