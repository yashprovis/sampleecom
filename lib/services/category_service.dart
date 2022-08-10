import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/category_model.dart';

class CategoryService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Category>> fetchCategory() async {
    List<Category> categories = [];
    final data = await _db.collection('category').orderBy("id").get();
    for (var element in data.docs) {
      categories.add(Category.fromJson(element.data()));
    }
    return categories;
  }
}
