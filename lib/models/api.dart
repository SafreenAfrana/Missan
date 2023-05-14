// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:missan_app/models/product_model.dart';

class Api {
  Future<List<Category>> getCategories() async {
    return Future.delayed(
      Duration(milliseconds: 100),
      () {
        return Category.allCategories;
      },
    );

    //  return Future.value(Category.allCategories);
  }

  Future<List<Product>> getProductsByCategory(String category) async {
    return Future.delayed(Duration(milliseconds: 100), () {
      return Product.allProducts.where((p) => p.category == category).toList();
    });
  }
}

class Category {
  final String id;
  final String name;
  final AssetImage image;
  Category({required this.id, required this.name, required this.image});

  static List<Category> allCategories = [
    Category(
        id: '0',
        name: 'Clothing',
        image: AssetImage("assets/category/clothing.jpg")),
    Category(
        id: '1',
        name: 'Fashion',
        image: AssetImage("assets/category/fashion.jpg")),
    Category(
        id: '2',
        name: 'Jewellery',
        image: AssetImage("assets/category/jewellery.jpg")),
  ];
}
