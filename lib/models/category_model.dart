// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

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
