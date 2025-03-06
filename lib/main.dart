import 'package:flutter/material.dart';

import 'feature/auth/screens/otplogin.dart';
import 'feature/auth/screens/signup.dart';
import 'feature/homescreen/screens/home_bottom.dart';
import 'feature/homescreen/screens/homepage.dart';
import 'feature/splashscreen/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      ),
      home: Splash(),
    );
  }
}

