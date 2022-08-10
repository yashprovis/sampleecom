class Category {
  String title;
  String image;
  List category;
  List<SubCategory> subcategory;

  Category(
      {required this.category,
      required this.title,
      required this.image,
      required this.subcategory});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
      category: json["category"],
      title: json["title"],
      image: json["image"],
      subcategory: List<SubCategory>.from(
          json["sub_category"].map((x) => SubCategory.fromJson(x))));
}

class SubCategory {
  String title;
  String image;
  List category;

  SubCategory({
    required this.category,
    required this.title,
    required this.image,
  });
  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        category: json["category"],
        title: json["title"],
        image: json["image"],
      );
}
