import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sampleecom/models/order_model.dart';

import '../models/address_model.dart';
import '../models/cart_model.dart';

class OrderService {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  final CollectionReference userRef =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference orderRef =
      FirebaseFirestore.instance.collection('orders');

  final CollectionReference productRef =
      FirebaseFirestore.instance.collection('products');

  Future<Order> createOrder(
      Order order, List<Cart> cart, List<Address> address) async {
    final docRef = orderRef.doc();
    final orderJson = order.toJson();
    orderJson["orderId"] = docRef.id;
    await docRef.set(orderJson);

    for (int i = 0; i < cart.length; i++) {
      docRef.collection('cart').doc(cart[i].productId).set(cart[i].toJson());
      final productDocs =
          await productRef.where("id", isEqualTo: cart[i].productId).get();
      num stock = (productDocs.docs[0].data() as Map<String, dynamic>)["stock"];
      productRef.doc(productDocs.docs[0].id).update({"stock": stock - 1});
    }

    final userCartDocs = await userRef.doc(userId).collection("cart").get();
    for (var element in userCartDocs.docs) {
      userRef.doc(userId).collection("cart").doc(element.id).delete();
    }

    for (int i = 0; i < address.length; i++) {
      String id = "delivery";
      if (i == 1) {
        id = "billing";
      }
      final addressRef = docRef.collection('address').doc(id);
      final addressJson = address[i].toJson();
      addressJson["id"] = addressRef.id;
      await addressRef.set(addressJson);
    }
    final newOrder = await orderRef.doc(docRef.id).get();
    return Order.fromSnap(newOrder);
  }

  Future<Order> fetchOrder({required String orderId}) async {
    final order = await orderRef.doc(orderId).get();
    return Order.fromSnap(order);
  }

  Future<List<Order>> fetchUserOrders() async {
    List<Order> orderList = [];
    final orders = await orderRef.where("orderedBy", isEqualTo: userId).get();

    orders.docs.forEach((element) async {
      orderList.add(await Order.fromSnap(element));
    });

    return orderList;
  }
}
