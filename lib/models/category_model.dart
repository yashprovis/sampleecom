class Category {
  String name;
  String image;
  String slug;
  List<SubCategory> subcategory;

  Category(
      {required this.slug,
      required this.name,
      required this.image,
      required this.subcategory});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
      slug: json["slug"],
      name: json["name"],
      image: json["image"],
      subcategory: List<SubCategory>.from(
          json["subcategory"].map((x) => SubCategory.fromJson(x))));
}

class SubCategory {
  String name;
  String image;
  String slug;

  SubCategory({
    required this.slug,
    required this.name,
    required this.image,
  });
  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        slug: json["slug"],
        name: json["name"],
        image: json["image"],
      );
}
