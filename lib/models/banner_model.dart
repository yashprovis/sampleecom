class BannerModel {
  String title;
  String image;
  String id;
  List category;

  BannerModel({
    required this.id,
    required this.title,
    required this.image,
    required this.category,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        id: json["_id"],
        title: json["name"],
        image: json["image"],
        category: json["category"],
      );
}
