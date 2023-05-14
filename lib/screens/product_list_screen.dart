import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:missan_app/screens/product_details_screen.dart';
import 'package:missan_app/widgets/product_widget/single_product.dart';

// ignore: must_be_immutable
class ProductList extends StatelessWidget {
  final int index;
  final DocumentSnapshot documentSnapshot;
  final String id;
  final String categoryName;

  const ProductList({
    Key? key,
    required this.index,
    required this.documentSnapshot,
    required this.id,
    required this.categoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(createRouteNavigation());
      },
      child: Card(
          // ignore: sized_box_for_whitespace
          child: SingleProduct(
        index: index,
        documentSnapshot: documentSnapshot,
        id: id,
        categoryName: categoryName,
      )),
    );
  }

  Route createRouteNavigation() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ProductDetailsScreen(
              documentSnapshot: documentSnapshot,
              id: id,
              index: index,
              categoryName: categoryName,
            ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(10.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          final tween = Tween(begin: begin, end: end);
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );
          return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: child,
          );
        });
  }
}
