// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:missan_app/models/api.dart';
import 'package:missan_app/models/product_model.dart';
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
  final Api api = Api();
  List<Category> categories = [];

  TabController? _tabController;
  final TextEditingController searchController = TextEditingController();
  fetchAllCategories() async {
    _tabController?.addListener(() {});
    api.getCategories().then((value) {
      setState(() {
        categories.addAll(value);
        _tabController = TabController(length: value.length, vsync: this);
      });
    });
  }

  @override
  void initState() {
    fetchAllCategories();
    super.initState();
  }

  List<Product> cartList = [];

  @override
  Widget build(BuildContext context) {
    cartList.clear();
    return _tabController == null
        ? Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
            drawer: drawerWidget(context, "Missan"),
            appBar: appBarWidget(context, searchController, _tabController!,
                cartList, api, categories),
            body: _tabController == null
                ? Center(child: CircularProgressIndicator())
                : CategoriesWidget());
  }
}
