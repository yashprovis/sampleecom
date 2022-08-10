import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sampleecom/models/product_model.dart';

class ProductService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Product>> fetchProducts(List categories, int selectedIndex,
      [bool? isPriceDesc]) async {
    List<Product> products = [];
    QuerySnapshot data;
    if (selectedIndex == 0) {
      data = await _db
          .collection('products')
          .where("category", arrayContains: categories[selectedIndex])
          .orderBy("price", descending: isPriceDesc ?? false)
          .get();
    } else {
      data = await _db
          .collection('products')
          .where("category", arrayContains: categories[selectedIndex])
          .where("gender", isEqualTo: categories[0])
          .orderBy("price", descending: isPriceDesc ?? false)
          .get();
    }

    for (var element in data.docs) {
      products.add(Product.fromJson(element.data() as Map<String, dynamic>));
    }
    return products;
  }

  Future<List<Product>> fetchProductsFromId(List ids) async {
    List<Product> products = [];
    if (ids.isEmpty) {
      return [];
    }
    final data =
        await _db.collection('products').where("id", whereIn: ids).get();

    for (var element in data.docs) {
      products.add(Product.fromJson(element.data()));
    }
    return products;
  }

  Future<Product> fetchProduct(String id) async {
    Product product;

    final data =
        await _db.collection('products').where("id", isEqualTo: id).get();

    product = Product.fromJson(data.docs[0].data());

    return product;
  }

  Future<List<Product>> fetchProductsFromSearch(String searchString) async {
    List<Product> products = [];
    final data = await _db
        .collection('products')
        .where("title", isGreaterThanOrEqualTo: searchString)
        .where("title", isLessThanOrEqualTo: "$searchString\uf7ff")
        .get();

    for (var element in data.docs) {
      products.add(Product.fromJson(element.data()));
    }
    return products;
  }
}
