// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:missan_app/models/api.dart';
import 'package:missan_app/models/product_model.dart';
import 'package:missan_app/screens/add_product_screen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

PreferredSizeWidget appBarWidget(
  BuildContext context,
  TextEditingController searchController,
  TabController tabController,
  List<Product> cartList,
  Api api,
  List<Category> categories,
) {
  return AppBar(
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Color.fromARGB(255, 249, 247, 247),
      centerTitle: true,
      title: SizedBox(
        height: 40,
        width: MediaQuery.of(context).size.width * 20,
        child: FormBuilderTextField(
          controller: searchController,
          onChanged: (value) {},
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(25),
            )),
            contentPadding: EdgeInsets.only(top: 5),
            hintText: 'Search...',
            prefixIcon: Icon(Icons.search),
            suffixIcon: IconButton(
              onPressed: () {
                // homepagedecl.searchText.value = '';
                searchController.text = '';
              },
              icon: Icon(
                Icons.clear,
              ),
            ),
          ),
          name: 'Search',
        ),
      ),
      // ignore: prefer_const_literals_to_create_immutables
      actions: [
        IconButton(
          onPressed: () {
            showBarModalBottomSheet(
                context: context, builder: (context) => AddProductScreen());
          },
          icon: Icon(Icons.add),
          color: Colors.black,
        ),
        SizedBox(
          width: 10,
        ),
      ]);
}
