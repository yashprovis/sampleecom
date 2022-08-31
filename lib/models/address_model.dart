class Address {
  String? id;
  final String name;
  final String line1;
  final String line2;
  final String city;
  final String state;
  final String pincode;

  Address({
    this.id,
    required this.name,
    required this.line1,
    required this.line2,
    required this.city,
    required this.state,
    required this.pincode,
  });

  static Address fromSnap(Map<String, dynamic> json) {
    return Address(
        id: json["_id"],
        name: json["name"],
        line1: json["line1"],
        line2: json["line2"],
        city: json["city"],
        state: json["state"],
        pincode: json["pincode"]);
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "line1": line1,
        "line2": line2,
        "city": city,
        "state": state,
        "pincode": pincode,
      };
}
