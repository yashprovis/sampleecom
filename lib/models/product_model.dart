import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String id;
  num mrp;
  num price;
  List size;
  int stock;
  String title;
  String image;
  List category;
  List imageList;

  Product(
      {required this.category,
      required this.id,
      required this.mrp,
      required this.price,
      required this.size,
      required this.stock,
      required this.title,
      required this.image,
      required this.imageList});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        category: json["category"],
        title: json["title"],
        image: json["image"],
        imageList: json["image_list"],
        id: json["id"],
        mrp: json["mrp"],
        price: json["price"],
        size: json["size"],
        stock: json["stock"],
      );

  static List<Product> productFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> json = snapshot.data() as Map<String, dynamic>;

      return Product(
        category: json["category"],
        title: json["title"],
        image: json["image"],
        imageList: json["image_list"],
        id: json["id"],
        mrp: json["mrp"],
        price: json["price"],
        size: json["size"],
        stock: json["stock"],
      );
    }).toList();
  }
}