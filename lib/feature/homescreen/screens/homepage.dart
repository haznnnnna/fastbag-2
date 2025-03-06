import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../core/constants/localvariables.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // final List<Map<String, String>> categories = [
  //   {"name": "Healthy", "image": ImageConstants.pizza},
  //   {"name": "Biryani", "image": ImageConstants.pizza},
  //   {"name": "Pizza", "image": ImageConstants.pizza},
  //   {"name": "Haleem", "image": ImageConstants.pizza},
  //   {"name": "Chicken", "image": ImageConstants.pizza},
  //   {"name": "Burger", "image": ImageConstants.pizza},
  //   {"name": "Cake", "image":ImageConstants.pizza},
  //   {"name": "Shawarma", "image": ImageConstants.pizza},
  //   {"name": "Haleem", "image":ImageConstants.pizza},
  //   {"name": "Haleem", "image": ImageConstants.pizza},
  // ];
  // final List<Map<String, String>> categories2 = [
  //   {"name": "Mexican", "image": ImageConstants.pizza},
  //   {"name": "Fast Food", "image": ImageConstants.pizza},
  //   {"name": "Healthy", "image": ImageConstants.pizza},
  //   {"name": "Pizza", "image": ImageConstants.pizza},
  //   {"name": "Asian", "image": ImageConstants.pizza},
  //   {"name": "Bakery", "image":ImageConstants.pizza},
  // ];



  List categories = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    final url = Uri.parse("https://fastbag.pythonanywhere.com//vendors/categories/view/");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          categories = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        showError("Failed to load categories");
      }
    } catch (e) {
      showError("Something went wrong. Please try again.");
    }
  }


  void showError(String message) {
    setState(() => isLoading = false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Food, shopping, drinks, etc",
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Title
              const Text(
                "Top categories",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              isLoading
                  ? Center(child: CircularProgressIndicator()) // ✅ Loading indicator
                  : SizedBox(
                height: height * 0.5,
                child: GridView.builder(
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(categories[index]["category_image"] ?? ""),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          categories[index]["name"] ?? "Unknown",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // All Categories
              const Text(
                "All categories",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              isLoading
                  ? Center(child: CircularProgressIndicator()) // ✅ Loading indicator
                  : SizedBox(
                height: height * 0.8,
                child: GridView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: categories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: width * 0.05,
                    mainAxisSpacing: height * 0.05,
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: height * 0.17,
                              width: width * 0.45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(width * 0.05),
                                  topLeft: Radius.circular(width * 0.05),
                                ),
                              ),

                              child: Image.network(
                                categories[index]["category_image"] ?? "",
                                width: 100,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              categories[index]["name"] ?? "Unknown",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
