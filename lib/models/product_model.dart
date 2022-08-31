class Product {
  String id;
  num mrp;
  num price;
  List size;
  int stock;
  String title;
  String desc;
  String image;
  List category;
  List imageList;

  Product(
      {required this.category,
      required this.id,
      required this.desc,
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
        desc: json["desc"],
        image: json["image"],
        imageList: json["imageList"],
        id: json["_id"],
        mrp: json["mrp"],
        price: json["price"],
        size: json["size"],
        stock: json["stock"],
      );
}
