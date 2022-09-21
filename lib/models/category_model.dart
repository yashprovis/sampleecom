class Category {
  String name;
  String image;

  List<SubCategory> subcategory;

  Category(
      {required this.name, required this.image, required this.subcategory});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
      name: json["name"],
      image: json["image"],
      subcategory: List<SubCategory>.from(
          json["subcategory"].map((x) => SubCategory.fromJson(x))));
}

class SubCategory {
  String name;
  String image;
  List size;

  SubCategory({
    required this.size,
    required this.name,
    required this.image,
  });
  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        size: json["size"],
        name: json["name"],
        image: json["image"],
      );
}
