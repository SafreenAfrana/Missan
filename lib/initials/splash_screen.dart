// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:missan_app/models/product_model.dart';
import 'package:missan_app/screens/product_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    setState(() {
      Timer(const Duration(seconds: 3), () async {
        if (Product.allProducts.isEmpty) {
          getProduct();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => ProductScreen(),
              ),
              (route) => false);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(157, 28, 22, 111),
      body: SafeArea(
        child: Center(
          child: Image.asset(
            'assets/logo.jpg',
          ),
        ),
      ),
    );
  }

  getProduct() async {
    Product.allProducts.clear();

    FirebaseFirestore.instance
        .collection("Products")
        // .where('category', isEqualTo: category)
        .get()
        .then((querySnapshot) {
      // ignore: avoid_function_literals_in_foreach_calls
      querySnapshot.docs.forEach((result) {
        Product.allProducts.add(Product(
            name: result.get('name'),
            price: result.get('price'),
            rank: result.get('rank'),
            description: result.get('description'),
            productId: result.get('productId'),
            category: result.get('category'),
            imageName: result.get('imageName'),
            quantity: ValueNotifier<int>(0)));
      });
    });
  }

  showFadingCircleLoading(context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SpinKitFadingCircle(
            duration: Duration(seconds: 10),
            color: Colors.pink,
            size: 50.0,
          );
        });
  }
}
