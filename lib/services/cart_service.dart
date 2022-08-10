import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/cart_model.dart';
import '../models/coupon_model.dart';

class CartService {
  final CollectionReference _ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("cart");

  Future addToCartService({required Cart cartItem}) async {
    await _ref.doc(cartItem.productId).set(cartItem.toJson());
  }

  Future removeFromCartService({required String cartId}) async {
    await _ref.doc(cartId).delete();
  }

  Future updateCartService({required Cart cartItem}) async {
    await _ref.doc(cartItem.productId).set(cartItem.toJson());
  }

  Future<Coupon> fetchCoupon(String title) async {
    final data = await FirebaseFirestore.instance
        .collection('coupons')
        .where("id", isEqualTo: title)
        .get();
    if (data.docs.isNotEmpty) {
      return Coupon.fromSnap(data.docs[0].data());
    }
    return const Coupon(
        id: "", discount: 0, type: CouponType.value, status: false);
  }
}
