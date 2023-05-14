import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:missan_app/miscellaneous/theme.dart';

// ignore: must_be_immutable
class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen(
      {super.key,
      required this.documentSnapshot,
      required this.id,
      required this.index,
      required this.categoryName});

  final DocumentSnapshot documentSnapshot;
  final String id;
  final int index;
  final String categoryName;
  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  //Bool
  bool isEdit = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '${widget.documentSnapshot['name']}',
            style: TextStyle(color: appbar_font_color),
          ),
          backgroundColor: appbar_bgcolor,
          iconTheme: IconThemeData(color: appbar_font_color),
        ),
        body: _productDetailUI());
  }

  Widget _productDetailUI() {
    return SingleChildScrollView(
      child: Container(
          margin: const EdgeInsets.all(10),
          // ignore: avoid_unnecessary_containers
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Center(
                          child: Material(
                            type: MaterialType.transparency,
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.transparent,
                                  ),
                                  padding: const EdgeInsets.all(15),
                                  height:
                                      MediaQuery.of(context).size.height * 0.7,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Center(
                                            child: Image.asset(
                                          'assets/${widget.categoryName}/${widget.documentSnapshot['imageName']}',
                                          fit: BoxFit.fill,
                                        )),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  left: MediaQuery.of(context).size.width * 0.6,
                                  bottom:
                                      MediaQuery.of(context).size.height * 0.65,
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                        Icons.cancel,
                                        color: Colors.white,
                                      )),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    height: 200,
                    child: Hero(
                      tag: widget.id,
                      child: Image.asset(
                        'assets/${widget.categoryName}/${widget.documentSnapshot['imageName']}',
                      ),
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 4,
                              ),
                              SizedBox(
                                width:
                                    widget.documentSnapshot['name'].length > 40
                                        ? 300
                                        : 200,
                                child: Text(
                                  widget.documentSnapshot['name'].toUpperCase(),
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 16,
                                      overflow: TextOverflow.ellipsis,
                                      wordSpacing: 1,
                                      fontWeight: FontWeight.w500,
                                      color: text_color),
                                ),
                              ),
                              const SizedBox(
                                height: 9,
                              ),
                              Text('${widget.documentSnapshot['category']}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    wordSpacing: 1,
                                    color: Color(0xff666666),
                                  )),
                              const SizedBox(
                                height: 9,
                              ),
                              Text(
                                "₹ ${widget.documentSnapshot['price']}",
                                // textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 16,
                                  wordSpacing: 1,
                                  color: text_color,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 0,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 1,
                      child: Stack(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        //  mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Positioned(
                            top: 1,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {});
                                    },
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Color(0xff666666),
                                    )),
                                IconButton(
                                    onPressed: () {
                                      setState(() {});
                                    },
                                    icon: const Icon(
                                      Icons.share,
                                      color: Color(0xff666666),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Divider(
                    color: appbar_font_color,
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                  child: Text(
                    "Description",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: text_color),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                  child: Text(
                    '${widget.documentSnapshot['description']}',
                    style: TextStyle(
                      fontSize: 15,
                      wordSpacing: 1,
                      color: text_color,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                  ),
                  child: Divider(
                    color: appbar_font_color,
                    thickness: 1,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Product Details",
                    style: TextStyle(
                      // fontWeight: FontWeight.w400,
                      fontSize: 17,
                      color: text_color,
                      //  decoration: TextDecoration.underline
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          )),
    );
  }
}
