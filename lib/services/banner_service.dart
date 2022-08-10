import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/banner_model.dart';

class BannerService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<BannerModel>> fetchBanner() async {
    List<BannerModel> banners = [];
    final data = await _db.collection('banners').orderBy("id").get();
    for (var element in data.docs) {
      banners.add(BannerModel.fromJson(element.data()));
    }
    return banners;
  }
}
