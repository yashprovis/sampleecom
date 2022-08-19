class Coupon {
  final String id;
  final num discount;
  final CouponType type;
  final bool status;
  const Coupon({
    required this.id,
    required this.discount,
    required this.type,
    required this.status,
  });

  static Coupon fromSnap(Map<String, dynamic> json) {
    return Coupon(
        id: json["_id"],
        discount: json["discount"],
        type: json["type"] == "percent" ? CouponType.percent : CouponType.value,
        status: json["status"]);
  }
}

enum CouponType { percent, value }
