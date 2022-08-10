class BannerModel {
  String title;
  String image;
  int id;
  List category;

  BannerModel({
    required this.id,
    required this.title,
    required this.image,
    required this.category,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        category: json["category"],
      );
}
