import 'package:sampleecom/models/address_model.dart';
import 'package:sampleecom/models/cart_model.dart';

class User {
  final String name;
  final String uid;
  final String phone;
  final String email;
  final List<Cart>? cart;
  final List<Address>? address;
  final List favourites;
  final String image;
  final bool isActive;
  const User(
      {required this.name,
      required this.isActive,
      required this.uid,
      required this.image,
      required this.email,
      this.cart,
      this.address,
      required this.favourites,
      required this.phone});

  static Future<User> fromSnap(Map json) async {
    return User(
      isActive: json["isActive"],
      name: json["name"],
      uid: json["_id"],
      phone: json["phone"],
      email: json["email"],
      cart: List<Cart>.from(json["cart"].map((x) => Cart.fromSnap(x))),
      address:
          List<Address>.from(json["address"].map((x) => Address.fromSnap(x))),
      favourites: json["favourites"],
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "isActive": isActive,
        "uid": uid,
        "phone": phone,
        "email": email,
        "favourites": favourites,
        "image": image,
      };
}
