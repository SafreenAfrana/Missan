import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Product {
  String name;
  int price;
  int productId;
  int rank;
  String description;
  String category;
  String imageName;
  ValueNotifier<int> quantity;

  Product({
    required this.name,
    required this.price,
    required this.rank,
    required this.description,
    required this.productId,
    required this.category,
    required this.imageName,
    required this.quantity,
  });

  static Product fromSnapshot(DocumentSnapshot snap) {
    Product product = Product(
      name: snap['name'],
      price: snap['price'],
      productId: snap['productId'],
      rank: snap['rank'],
      description: snap['description'],
      category: snap['category'],
      imageName: snap['imageName'],
      quantity: ValueNotifier<int>(0),
    );
    return product;
  }

  Product.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : price = doc.data()!["price"],
        name = doc.data()!["name"],
        category = doc.data()!["category"],
        rank = doc.data()!["rank"],
        description = doc.data()!["description"],
        productId = doc.data()!["productId"],
        imageName = doc.data()!["imageName"],
        quantity = ValueNotifier<int>(0);
  static List<Product> allProducts = List<Product>.empty(growable: true);
}
