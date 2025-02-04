import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:quickmart/models/product.dart';

class QuickMartRepo {
  Future<List<Product>> getProduct() async {
    var data = await rootBundle.loadString('assets/data/products.json');
    var productMap = jsonDecode(data);
    List<Product> products = [];
    for (var product in productMap) {
      products.add(Product.fromJson(product));
    }
    return products;
  }

  Future<List<String>> getCategories() async {
    var data =
        await rootBundle.loadString('assets/data/product-categories.json');
    var categoryList = jsonDecode(data);
    List<String> categories = [];
    for (var category in categoryList) {
      categories.add(category);
    }
    return categories;
  }
}
