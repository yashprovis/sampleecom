class Cart {
  final String productId;
  final num qty;
  final num size;

  const Cart({required this.productId, required this.qty, required this.size});

  static Cart fromSnap(Map<String, dynamic> json) {
    return Cart(productId: json["_id"], qty: json["qty"], size: json["size"]);
  }

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "qty": qty,
        "size": size,
      };
}
