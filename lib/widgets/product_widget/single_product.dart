import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:missan_app/miscellaneous/theme.dart';

class SingleProduct extends StatefulWidget {
  const SingleProduct(
      {super.key,
      required this.index,
      required this.documentSnapshot,
      required this.id,
      required this.categoryName});
  final int index;
  final DocumentSnapshot documentSnapshot;
  final String id;
  final String categoryName;
  @override
  State<SingleProduct> createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  bool isDelete = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 8, 0, 8),
        child: Column(
          children: [
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                                height: 130,
                                width: 130,
                                child: Hero(
                                    tag: widget.id,
                                    child: Image.asset(
                                      'assets/${widget.categoryName}/${widget.documentSnapshot['imageName']}',
                                      fit: BoxFit.fill,
                                    ))),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 170.0,
                            child: Text(
                              widget.documentSnapshot['name'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(
                                Icons.add_business,
                                size: 18,
                                color: Colors.black26,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                widget.documentSnapshot['category'],
                                style: const TextStyle(
                                  color: Color(0xff666666),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(
                                Icons.currency_rupee_outlined,
                                size: 18,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                "${widget.documentSnapshot['price'].toStringAsFixed(2)}",
                                style: TextStyle(
                                    color: text_color,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  showLoading(context, DocumentSnapshot doc, bool isDelete) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Dialog(
                child: SizedBox(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Are you sure you want to delete?",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: appbar_bgcolor,
                              minimumSize: const Size(30, 40),
                              textStyle: const TextStyle(fontSize: 14),
                              side:
                                  BorderSide(width: 1, color: appbar_bgcolor)),
                          onPressed: () {
                            deleteProduct(doc);
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.delete,
                                size: 17,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Delete',
                                style: TextStyle(color: appbar_font_color),
                              ),
                            ],
                          )),
                      const SizedBox(
                        width: 20,
                      ),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: appbar_bgcolor,
                              minimumSize: const Size(30, 40),
                              textStyle: const TextStyle(fontSize: 14),
                              side:
                                  BorderSide(width: 1, color: appbar_bgcolor)),
                          onPressed: () {
                            setState(() {
                              isDelete = false;
                            });
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.clear,
                                size: 17,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text('Cancel',
                                  style: TextStyle(color: appbar_font_color)),
                            ],
                          )),
                    ],
                  ),
                ],
              ),
            ));
          });
        });
  }

  deleteProduct(DocumentSnapshot doc) {
    FirebaseFirestore.instance.collection("Product").doc(doc.id).delete();
  }
}
