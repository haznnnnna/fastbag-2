import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:fastbag/feature/homescreen/screens/homepage.dart';
import 'package:flutter/material.dart';

class HomeBottom extends StatefulWidget {
  const HomeBottom({super.key});

  @override
  State<HomeBottom> createState() => _HomeBottomState();
}

class _HomeBottomState extends State<HomeBottom> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    Homepage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],

        bottomNavigationBar: ConvexAppBar(
          backgroundColor: Colors.white,
          color: Colors.grey,
          activeColor: Colors.blue,
          items: [
            TabItem(icon: Icons.home),
            TabItem(icon: Icons.storefront),
            TabItem(icon: Icons.grid_view), // Middle FAB-like button
            TabItem(icon: Icons.restaurant),
            TabItem(icon: Icons.person),
          ],
          initialActiveIndex: 2,
        )
    );
  }
}
