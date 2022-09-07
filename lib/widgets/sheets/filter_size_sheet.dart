import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampleecom/widgets/ecom_button.dart';
import 'package:sampleecom/widgets/ecom_text.dart';

import '../../provider/user_provider.dart';

class FilterSizeSheet extends StatefulWidget {
  final List? initialSizes;
  final RangeValues? initialPrice;
  const FilterSizeSheet({Key? key, this.initialPrice, this.initialSizes})
      : super(key: key);

  @override
  State<FilterSizeSheet> createState() => _FilterSizeSheetState();
}

class _FilterSizeSheetState extends State<FilterSizeSheet> {
  List baseSizes = [5, 6, 7, 8, 9, 10];
  List filterSizes = [];
  RangeValues selectedRange = const RangeValues(0, 5000);
  RangeLabels labels = const RangeLabels("₹0", "₹5000");
  @override
  void initState() {
    filterSizes = widget.initialSizes ?? [];
    selectedRange = widget.initialPrice ?? const RangeValues(0, 5000);
    labels = widget.initialPrice == null
        ? const RangeLabels("₹0", "₹5000")
        : RangeLabels("₹${widget.initialPrice!.start.toInt()}",
            "₹${widget.initialPrice!.end.toInt()}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        height: 430,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0))),
        child: StatefulBuilder(builder: (context, ss) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: SizedBox(
                      width: 40,
                      child: userProvider.filters.isEmpty
                          ? null
                          : GestureDetector(
                              onTap: () {
                                userProvider.clearFilters();
                                userProvider.setFilterSearch(true);
                                ss(() {
                                  labels = const RangeLabels("₹0", "₹5000");
                                  selectedRange = const RangeValues(0, 5000);
                                  filterSizes.clear();
                                });
                                Navigator.of(context).pop();
                              },
                              child: const EcomText(
                                "Clear",
                                size: 14,
                                weight: FontWeight.w500,
                                color: Colors.red,
                              ),
                            ),
                    ),
                  ),
                  const EcomText(
                    "Filter",
                    size: 20,
                    weight: FontWeight.w500,
                  ),
                  SizedBox(
                    width: 40,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                          onTap: () {
                            userProvider.setFilterSearch(false);
                            Navigator.of(context).pop();
                          },
                          child: const Icon(Icons.close)),
                    ),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 16, bottom: 6),
                padding: const EdgeInsets.only(
                    left: 10, top: 4, bottom: 10, right: 10),
                child: Column(
                  children: [
                    Divider(color: Colors.grey[800]),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: EcomText(
                        " Size:",
                        size: 16,
                        //  weight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 9),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        height: 65,
                        child: ListView.builder(
                          itemCount: baseSizes.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                if (filterSizes.contains(baseSizes[index])) {
                                  filterSizes.remove(baseSizes[index]);
                                } else {
                                  filterSizes.add(baseSizes[index]);
                                }
                                ss(() {});
                                if (filterSizes.isNotEmpty) {
                                  userProvider.addFilter(filterSizes);
                                } else {
                                  userProvider.removeFilter(removeSize: true);
                                }
                              },
                              child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 400),
                                  margin: const EdgeInsets.only(
                                      right: 10, top: 8, bottom: 8),
                                  width: 49,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border:
                                        filterSizes.contains(baseSizes[index])
                                            ? Border.all(width: 2.5)
                                            : null,
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: EcomText(baseSizes[index].toString())),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Divider(color: Colors.grey[800]),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: EcomText(
                        " Price:  (${labels.start} - ${labels.end})",
                        size: 16,
                        //  weight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SliderTheme(
                      data: const SliderThemeData(trackHeight: 2),
                      child: RangeSlider(
                          values: selectedRange,
                          min: 0.0,
                          divisions: 500,
                          max: 5000.0,

                          //added talk back feature for android
                          labels: labels,
                          activeColor: Colors.black,
                          inactiveColor: const Color(0xffD7D8DD),
                          onChanged: (value) {
                            ss(() {
                              selectedRange = value;
                              labels = RangeLabels(
                                  "₹${value.start.toInt().toString()}",
                                  "₹${value.end.toInt().toString()}");
                              if (value.start.toInt() != 0 ||
                                  value.end.toInt() != 5000) {
                                userProvider.addFilter(null, value);
                              } else {
                                userProvider.removeFilter(removePrice: true);
                              }
                            });
                          }),
                    ),

                    //  SizedBox(height: 10),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: EcomButton(
                    text: "Search",
                    func: () {
                      if (userProvider.filters.isNotEmpty) {
                        userProvider.setFilterSearch(true);
                        Navigator.of(context).pop();
                      }
                    },
                    color: userProvider.filters.isEmpty
                        ? Colors.grey
                        : Colors.black,
                    isLoading: false),
              )
            ],
          );
        }));
  }
}
