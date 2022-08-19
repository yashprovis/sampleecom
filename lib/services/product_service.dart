import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sampleecom/models/product_model.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class ProductService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Product>> fetchProducts(List categories) async {
    List<Product> products = [];
    http.Response response = await http.post(
        body: jsonEncode({"categoryList": categories}),
        headers: headerApiMap,
        Uri.parse("$baseUrl/productsByCategory"));
    List data = jsonDecode(response.body)['data'];
    for (var element in data) {
      products.add(Product.fromJson(element));
    }
    return products;
  }

  Future<List<Product>> fetchProductsFromId(List ids) async {
    List<Product> products = [];
    if (ids.isEmpty) {
      return [];
    }
    http.Response response = await http.post(
        body: jsonEncode({"idList": ids}),
        headers: headerApiMap,
        Uri.parse("$baseUrl/productsByIds"));
    List data = jsonDecode(response.body)['data'];
    for (var element in data) {
      products.add(Product.fromJson(element));
    }
    return products;
  }

  Future<Product> fetchProduct(String id) async {
    Product product;
    http.Response response = await http.get(
        headers: headerApiMap, Uri.parse("$baseUrl/product/$id"));

    product = Product.fromJson(jsonDecode(response.body)['data']);

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
