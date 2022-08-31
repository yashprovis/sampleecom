import 'dart:convert';

import 'package:http/http.dart' as http;
import '../constants.dart';

import '../models/banner_model.dart';

class BannerService {
  Future<List<BannerModel>> fetchBanner() async {
    List<BannerModel> banners = [];
    http.Response response = await http.get(Uri.parse("$baseUrl/banner"));
    print(response.body);
    // return user.User.fromSnap(jsonDecode(response.body)['data']);
    List data = jsonDecode(response.body)['data'];
    for (var element in data) {
      banners.add(BannerModel.fromJson(element));
    }
    return banners;
  }
}
