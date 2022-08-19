import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../models/cart_model.dart';
import '../models/coupon_model.dart';

class CartService {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  Future addToCartService({required Cart cartItem}) async {
    await http.post(
        headers: headerApiMap,
        body: jsonEncode(cartItem.toJson()),
        Uri.parse("$baseUrl/cart/$userId"));

    //  await _ref.doc(cartItem.productId).set(cartItem.toJson());
  }

  Future removeFromCartService({required String cartId}) async {
    await http.delete(
        headers: headerApiMap, Uri.parse("$baseUrl/cart/$userId&$cartId"));
  }

  Future updateCartService({required Cart cartItem}) async {
    await http.put(
        headers: headerApiMap,
        body: jsonEncode(cartItem.toJson()),
        Uri.parse("$baseUrl/cart/$userId&${cartItem.productId}"));
  }

  Future<Coupon> fetchCoupon(String title) async {
    http.Response response = await http.get(
        headers: headerApiMap, Uri.parse("$baseUrl/coupon/$title"));

    if (response.statusCode == 200) {
      return Coupon.fromSnap(jsonDecode(response.body)['data']);
    }
    return const Coupon(
        id: "", discount: 0, type: CouponType.value, status: false);
  }
}
