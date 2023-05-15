// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:missan_app/widgets/category/category_widget.dart';
import 'package:missan_app/widgets/product_widget/appbar_widget.dart';
import 'package:missan_app/widgets/product_widget/drawer_widget.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: drawerWidget(context, "Missan"),
        appBar: appBarWidget(
          context,
        ),
        body: CategoriesWidget());
  }
}
