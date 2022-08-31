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
  dynamic orderPlacedDate;
  dynamic orderUpdatedDate;
  final String orderStatus;

  Order(
      {required this.cartItems,
      required this.orderedBy,
      required this.address,
      required this.totalAmount,
      required this.subtotalAmount,
      required this.savingsAmount,
      required this.couponAmount,
      this.orderPlacedDate,
      this.orderUpdatedDate,
      required this.orderStatus,
      required this.orderId});

  static Order fromSnap(Map json) {
    return Order(
      orderedBy: json["orderedBy"],
      cartItems:
          List<Cart>.from(json["cartItems"].map((x) => Cart.fromSnap(x))),
      address:
          List<Address>.from(json["address"].map((x) => Address.fromSnap(x))),
      orderId: json["_id"],
      totalAmount: json["totalAmount"],
      subtotalAmount: json["subtotalAmount"],
      savingsAmount: json["savingsAmount"],
      couponAmount: json["couponAmount"],
      orderPlacedDate: DateTime.parse(json["orderPlacedDate"]),
      orderUpdatedDate: DateTime.parse(json["orderUpdatedDate"]),
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
        "cartItems": cartItems,
        "address": address
      };
}
