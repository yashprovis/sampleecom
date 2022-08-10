import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sampleecom/services/cart_service.dart';
import 'package:sampleecom/widgets/ecom_button.dart';
import 'package:sampleecom/widgets/ecom_text.dart';
import 'package:sampleecom/widgets/ecom_text_field.dart';

import '../../models/coupon_model.dart';
import '../../provider/user_provider.dart';

void couponSheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (builder) {
        return const CouponSheet();
      });
}

class CouponSheet extends StatefulWidget {
  const CouponSheet({Key? key}) : super(key: key);

  @override
  State<CouponSheet> createState() => _CouponSheetState();
}

class _CouponSheetState extends State<CouponSheet> {
  Coupon? appliedCoupon;
  bool isLoading = false;
  TextEditingController couponController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
          padding: const EdgeInsets.all(16),
          height: 280,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0))),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const EcomText(
                    "Apply Coupon",
                    size: 18,
                    weight: FontWeight.w500,
                  ),
                ),
                GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.close))
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .65,
                  child: EcomTextField(
                      controller: couponController,
                      hintText: 'Coupon Code ',
                      isPassword: false),
                ),
                EcomButton(
                    text: "Apply",
                    func: () async {
                      if (couponController.text.isNotEmpty) {
                        setState(() {
                          isLoading = true;
                        });
                        appliedCoupon = await CartService()
                            .fetchCoupon(couponController.text);
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    textSize: 12,
                    height: 40,
                    width: MediaQuery.of(context).size.width * .2,
                    isLoading: false)
              ],
            ),
            appliedCoupon == null
                ? Expanded(
                    child: Center(
                        child: Lottie.asset("assets/lottie/coupon.json")))
                : isLoading
                    ? const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 1.5,
                            color: Colors.black,
                          ),
                        ),
                      )
                    : appliedCoupon!.id == ""
                        ? const Expanded(
                            child: const Center(
                              child: EcomText('Invalid coupon code'),
                            ),
                          )
                        : Card(
                            elevation: 5,
                            margin: const EdgeInsets.all(10),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                              border: Border.all(width: .4)),
                                          child: EcomText(appliedCoupon!.id,
                                              size: 14)),
                                      TextButton(
                                          onPressed: () {
                                            userProvider
                                                .applyCoupon(appliedCoupon!);
                                            Navigator.of(context).pop();
                                          },
                                          child: const EcomText(
                                            'Apply',
                                            size: 14,
                                            weight: FontWeight.bold,
                                          ))
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  EcomText(
                                    "Get ${appliedCoupon!.type == CouponType.value ? "₹" : ""}${appliedCoupon!.discount}${appliedCoupon!.type == CouponType.percent ? "%" : ""} worth discount with this coupon code.",
                                    size: 14,
                                  )
                                ],
                              ),
                            ),
                          )
          ])),
    );
  }
}
