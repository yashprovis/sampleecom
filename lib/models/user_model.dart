import 'package:cloud_firestore/cloud_firestore.dart';
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

  const User(
      {required this.name,
      required this.uid,
      required this.image,
      required this.email,
      this.cart,
      this.address,
      required this.favourites,
      required this.phone});

  static Future<User> fromSnap(DocumentSnapshot data) async {
    Map<String, dynamic> json = data.data() as Map<String, dynamic>;

    final cartData = await FirebaseFirestore.instance
        .collection('users')
        .doc(data.id)
        .collection("cart")
        .get();
    List<Cart> cartList = [];
    for (int i = 0; i < cartData.size; i++) {
      cartList.add(Cart.fromSnap(cartData.docs[i].data()));
    }

    final addressData = await FirebaseFirestore.instance
        .collection('users')
        .doc(data.id)
        .collection("address")
        .get();
    List<Address> addressList = [];
    for (int i = 0; i < addressData.size; i++) {
      addressList.add(Address.fromSnap(addressData.docs[i].data()));
    }

    return User(
      name: json["name"],
      uid: json["uid"],
      phone: json["phone"],
      email: json["email"],
      cart: cartList,
      address: addressList,
      favourites: json["favourites"],
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "uid": uid,
        "phone": phone,
        "email": email,
        "favourites": favourites,
        "image": image,
      };
}
