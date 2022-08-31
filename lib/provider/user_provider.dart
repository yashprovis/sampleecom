import 'package:flutter/material.dart';
import 'package:sampleecom/models/coupon_model.dart';
import 'package:sampleecom/services/address_service.dart';
import 'package:sampleecom/services/user_service.dart';

import '../models/address_model.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';
import '../models/user_model.dart';
import '../services/cart_service.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User get getUser =>
      _user ??
      const User(
          name: "",
          uid: "",
          image: "",
          email: "",
          favourites: [],
          phone: "",
          isActive: false);

  Future<void> refreshUser() async {
    User user = await UserService().getUserDetails();
    _user = user;
    notifyListeners();
  }

  Future updateUser(
      {required String name,
      required String phone,
      required String image,
      required BuildContext context}) async {
    await UserService().updateUserProfile(
        name: name, phone: phone, image: image, context: context);
    refreshUser();
  }

  Future alterFav({required String productId, required bool isFav}) async {
    if (isFav) {
      _user!.favourites.remove(productId);
    } else {
      _user!.favourites.add(productId);
    }
    UserService().alterFavService(productId: productId);
    notifyListeners();
  }

  Future addToCart({required Cart cartItem}) async {
    _user!.cart!.add(cartItem);
    CartService().addToCartService(cartItem: cartItem);
    notifyListeners();
  }

  Future removeFromCart({required String cartId}) async {
    _user!.cart!.removeWhere((e) => e.productId == cartId);
    CartService().removeFromCartService(cartId: cartId);
    notifyListeners();
  }

  Future updateCart({required Cart cartItem}) async {
    int i = _user!.cart!.indexWhere((e) => e.productId == cartItem.productId);
    _user!.cart![i] = cartItem;
    CartService().updateCartService(cartItem: cartItem);
    notifyListeners();
  }

  void emptyCart() {
    _user!.cart!.clear();
    notifyListeners();
  }

  bool productExistInCart({required String id}) {
    if (_user!.cart!.indexWhere((e) => e.productId == id) == -1) {
      return false;
    } else {
      return true;
    }
  }

  Cart fetchCartItem({required String id}) {
    int index = _user!.cart!.indexWhere((e) => e.productId == id);
    return _user!.cart![index];
  }

  Map<String, num> fetchCartTotal(List<Product> products) {
    Map<String, num> cartDetails = {
      "subtotal": 0,
      "savings": 0,
      "total": 0,
      "coupon_savings": 0
    };
    for (var cartItem in _user!.cart!) {
      num price = products
          .firstWhere((product) => product.id == cartItem.productId)
          .price;
      num mrp = products
          .firstWhere((product) => product.id == cartItem.productId)
          .mrp;
      cartDetails["subtotal"] = cartDetails["subtotal"]! + cartItem.qty * mrp;
      cartDetails["savings"] =
          cartDetails["savings"]! + cartItem.qty * (mrp - price);
    }
    cartDetails["total"] = cartDetails["subtotal"]! - cartDetails["savings"]!;
    if (cartCoupon != null) {
      if (cartCoupon!.type == CouponType.percent) {
        cartDetails["coupon_savings"] =
            cartDetails["total"]! * cartCoupon!.discount / 100;
      } else {
        cartDetails["coupon_savings"] = cartCoupon!.discount;
      }
      cartDetails["total"] =
          cartDetails["total"]! - cartDetails["coupon_savings"]!;
    }
    return cartDetails;
  }

  Future addAddress({required Address address}) async {
    _user!.address!.add(address);
    notifyListeners();
  }

  Future removeAddress({required String id}) async {
    _user!.address!.removeWhere((e) => e.id == id);
    AddressService().removeAddressService(id: id);
    notifyListeners();
  }

  Future updateAddress({required Address address}) async {
    int i = _user!.address!.indexWhere((e) => e.id == address.id);
    _user!.address![i] = address;
    AddressService().updateAddressService(address: address);
    notifyListeners();
  }

  Coupon? cartCoupon;
  Coupon? get getCoupon => cartCoupon;

  Future applyCoupon(Coupon coupon) async {
    cartCoupon = coupon;
    notifyListeners();
  }

  Future removeCoupon() async {
    cartCoupon = null;
    notifyListeners();
  }

  Map filters = {};
  Map get getFilters => filters;

  bool searchFilters = false;
  bool get getSearchFilters => searchFilters;

  void setFilterSearch(bool value) {
    searchFilters = value;
    notifyListeners();
  }

  void addFilter([List? sizes, RangeValues? price]) {
    if (sizes != null) {
      filters['sizes'] = sizes;
    }
    if (price != null) {
      filters['startPrice'] = price.start;
      filters['endPrice'] = price.end;
    }
    notifyListeners();
  }

  void removeFilter({bool? removeSize, bool? removePrice}) {
    if (removeSize != null) {
      filters.remove("sizes");
    }
    if (removePrice != null) {
      filters.remove('startPrice');
      filters.remove('endPrice');
    }
    notifyListeners();
  }

  Future clearFilters() async {
    filters = {};
    notifyListeners();
  }
}
