import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../models/category_model.dart';

class CategoryService {
  // final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Category>> fetchCategory() async {
    List<Category> categories = [];
    // final data = await _db.collection('category').orderBy("id").get();
    http.Response response = await http.get(Uri.parse("$baseUrl/category"));

    // return user.User.fromSnap(jsonDecode(response.body)['data']);
    List data = jsonDecode(response.body)['data'];
    for (var element in data) {
      categories.add(Category.fromJson(element));
    }
    return categories;
  }
}
