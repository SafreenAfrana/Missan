import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:missan_app/initials/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: const FirebaseOptions(
      //   apiKey: "AIzaSyBve5jkfna_6IjvS9oOSZtj0WcQpbdvBPo",
      //   projectId: "missan-cead9",
      //   messagingSenderId: "382688386493",
      //   appId: "1:382688386493:web:8dfa6380a51cdec0da86d4",
      // ),
      );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Missan App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
