import 'package:fastbag/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/auth/view/otplogin.dart';
import 'features/auth/view/signup.dart';
import 'features/home/view/home_bottom.dart';
import 'features/home/view/homepage.dart';
import 'features/home/view/splash.dart';
import 'features/home/viewmodel/category_viewmodel.dart';

void main() {
  runApp ( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AuthViewModel(),),
          ChangeNotifierProvider(create: (context) => CategoryViewModel(),),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
          ),
          home: Splash(),
        ),
      ),
    );
  }
}

