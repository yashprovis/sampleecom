import 'dart:convert';

import 'package:sampleecom/models/product_model.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class ProductService {
  Future<List<Product>> fetchProducts(List categories,
      [bool? priceDesc, Map? filters]) async {
    print(categories);
    List<Product> products = [];
    Map body = {"categoryList": categories};
    if (priceDesc != null) {
      body['priceDesc'] = priceDesc;
    }
    if (filters != null) {
      body.addAll(filters);
    }
    http.Response response = await http.post(
        body: jsonEncode(body),
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
    print(response.body);
    product = Product.fromJson(jsonDecode(response.body)['data']);

    return product;
  }

  Future<List<Product>> fetchProductsFromSearch(String searchString) async {
    List<Product> products = [];
    http.Response response = await http.post(
        body: jsonEncode({"searchString": searchString}),
        headers: headerApiMap,
        Uri.parse("$baseUrl/searchProducts"));
    List data = jsonDecode(response.body)['data'];
    for (var element in data) {
      products.add(Product.fromJson(element));
    }
    return products;
  }

  Future rateProduct({required Map rating}) async {
    http.Response response = await http.post(
        headers: headerApiMap,
        body: jsonEncode(rating),
        Uri.parse("$baseUrl/rateProduct"));
    if (response.statusCode == 200) {
      return true;
    }
  }
}
