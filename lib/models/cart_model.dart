class Cart {
  final String productId;
  final num qty;
  final num size;

  const Cart({required this.productId, required this.qty, required this.size});

  static Cart fromSnap(Map<String, dynamic> json) {
    return Cart(
        productId: json["product_id"], qty: json["qty"], size: json["size"]);
  }

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "qty": qty,
        "size": size,
      };
}
