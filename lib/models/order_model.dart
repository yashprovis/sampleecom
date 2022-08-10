import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sampleecom/models/address_model.dart';
import 'package:sampleecom/models/cart_model.dart';

class Order {
  final String? orderId;
  final List<Cart>? cartItems;
  final List<Address>? address;
  final String orderedBy;
  final num totalAmount;
  final num subtotalAmount;
  final num savingsAmount;
  final num couponAmount;
  final DateTime orderPlacedDate;
  final DateTime orderUpdatedDate;
  final String orderStatus;

  const Order(
      {required this.cartItems,
      required this.orderedBy,
      required this.address,
      required this.totalAmount,
      required this.subtotalAmount,
      required this.savingsAmount,
      required this.couponAmount,
      required this.orderPlacedDate,
      required this.orderUpdatedDate,
      required this.orderStatus,
      required this.orderId});

  static Future<Order> fromSnap(DocumentSnapshot data) async {
    Map<String, dynamic> json = data.data() as Map<String, dynamic>;

    final cartData = await FirebaseFirestore.instance
        .collection('orders')
        .doc(data.id)
        .collection("cart")
        .get();
    List<Cart> cartList = [];
    for (int i = 0; i < cartData.size; i++) {
      cartList.add(Cart.fromSnap(cartData.docs[i].data()));
    }

    final addressData = await FirebaseFirestore.instance
        .collection('orders')
        .doc(data.id)
        .collection("address")
        .get();
    List<Address> addressList = [];
    for (int i = 0; i < addressData.size; i++) {
      addressList.add(Address.fromSnap(addressData.docs[i].data()));
    }

    return Order(
      orderedBy: json["orderedBy"],
      cartItems: cartList,
      address: addressList,
      orderId: data.id,
      totalAmount: json["totalAmount"],
      subtotalAmount: json["subtotalAmount"],
      savingsAmount: json["savingsAmount"],
      couponAmount: json["couponAmount"],
      orderPlacedDate: json["orderPlacedDate"].toDate(),
      orderUpdatedDate: json["orderUpdatedDate"].toDate(),
      orderStatus: json["orderStatus"],
    );
  }

  Map<String, dynamic> toJson() => {
        "orderedBy": orderedBy,
        "totalAmount": totalAmount,
        "subtotalAmount": subtotalAmount,
        "savingsAmount": savingsAmount,
        "couponAmount": couponAmount,
        "orderPlacedDate": orderPlacedDate,
        "orderUpdatedDate": orderUpdatedDate,
        "orderStatus": orderStatus,
      };
}
