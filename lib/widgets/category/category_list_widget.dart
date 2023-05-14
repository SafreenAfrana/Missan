import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:missan_app/miscellaneous/theme.dart';
import 'package:missan_app/screens/product_list_screen.dart';

// ignore: must_be_immutable
class CategoryList extends StatefulWidget {
  final String categoryId;
  final String categoryName;
  const CategoryList(
      {Key? key, required this.categoryId, required this.categoryName})
      : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  //controler
  final TextEditingController _searchController = TextEditingController();

  //FirebaseImport
  CollectionReference dbRef = FirebaseFirestore.instance.collection('Products');

  //SnapShots
  List<DocumentSnapshot> documents = [];

  //Strings
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appbar_bgcolor,
          iconTheme: IconThemeData(color: appbar_font_color),
          title: Text(
            widget.categoryName,
            style: TextStyle(color: appbar_font_color),
          ),
        ),
        body: _categoryList());
  }

  Widget _categoryList() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: TextField(
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
            },
            decoration: const InputDecoration(
              hintText: 'Search...',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder<QuerySnapshot>(
              future:
                  dbRef.where("category", isEqualTo: widget.categoryName).get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // ignore: prefer_const_constructors
                  return Center(
                      child: const CircularProgressIndicator(
                    color: Colors.blue,
                  ));
                }
                documents = snapshot.data!.docs;
                //todo Documents list added to filterTitle
                if (searchText.isNotEmpty) {
                  documents = documents.where((element) {
                    return element
                        .get('name')
                        .toString()
                        .toLowerCase()
                        .contains(searchText.toLowerCase());
                  }).toList();
                }
                return !snapshot.hasData
                    ? const Center(child: CircularProgressIndicator())
                    : AnimationLimiter(
                        child: ListView.builder(
                          itemCount: documents.length,
                          itemBuilder: (context, index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: ProductList(
                                    index: index,
                                    documentSnapshot: documents[index],
                                    id: documents[index].id,
                                    categoryName: widget.categoryName,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
              }),
        ),
      ],
    );
  }
}
