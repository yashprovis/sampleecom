import 'package:firebase_auth/firebase_auth.dart';
import 'package:sampleecom/models/order_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants.dart';

class OrderService {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  Future<Order> createOrder(Order order) async {
    http.Response response = await http.post(
        headers: headerApiMap,
        body: jsonEncode(order.toJson()),
        Uri.parse("$baseUrl/order"));

    return Order.fromSnap(jsonDecode(response.body)['data']);
  }

  Future<Order> fetchOrder({required String orderId}) async {
    http.Response response = await http.get(
        headers: headerApiMap, Uri.parse("$baseUrl/order/$orderId"));

    return Order.fromSnap(jsonDecode(response.body)['data']);
  }

  Future<List<Order>> fetchUserOrders() async {
    List<Order> orderList = [];
    http.Response response = await http.get(
        headers: headerApiMap, Uri.parse("$baseUrl/userOrders/$userId"));
    List data = jsonDecode(response.body)['data'];

    for (var element in data) {
      orderList.add(Order.fromSnap(element));
    }

    return orderList;
  }
}
