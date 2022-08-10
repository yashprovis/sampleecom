import 'package:flutter/material.dart';
import 'package:sampleecom/services/order_service.dart';

import '../models/cart_model.dart';
import '../models/order_model.dart';

class OrderProvider with ChangeNotifier {
  List<Order> userOrders = [];

  List<Order> get getUserOrders => userOrders;

  Future fetchCurrentOrders() async {
    userOrders = await OrderService().fetchUserOrders();
    notifyListeners();
  }

  addOrder({required Order order}) {
    userOrders.add(order);
    notifyListeners();
  }

  Order fetchSingleOrder({required String orderId}) {
    int i = userOrders.indexWhere((element) => element.orderId == orderId);
    return userOrders[i];
  }

  List<String> fetchOrderProductIds({required String orderId}) {
    List<String> ids = [];
    int i = userOrders.indexWhere((element) => element.orderId == orderId);
    List<Cart> cartItems = userOrders[i].cartItems!;
    for (var element in cartItems) {
      ids.add(element.productId);
    }
    return ids;
  }

  Cart fetchOrderCartItem({required String orderId, required String id}) {
    int i = userOrders.indexWhere((element) => element.orderId == orderId);
    List<Cart> cartItems = userOrders[i].cartItems!;
    int index = cartItems.indexWhere((e) => e.productId == id);
    return cartItems[index];
  }
}
