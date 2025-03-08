
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/category_viewmodel.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  // late CategoryViewModel categoryViewModel = CategoryViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // final categoryViewModel=Provider.of<CategoryViewModel>(context);
    // final categories = categoryViewModel.categories;
    // final isLoading = categoryViewModel.isLoading;
  }
  @override
  Widget build(BuildContext context) {
    final categoryViewModel=Provider.of<CategoryViewModel>(context);
    final categories = categoryViewModel.categories;
    final isLoading = categoryViewModel.isLoading;
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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

              const Text(
                "Top categories",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              categoryViewModel.categories.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : SizedBox(
                height: height * 0.5,
                child: GridView.builder(
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: categoryViewModel.categories.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(categoryViewModel.categories[index].image),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          categoryViewModel.categories[index].name,
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

              categoryViewModel.categories.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : SizedBox(
                height: height * 0.8,
                child: GridView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: categoryViewModel.categories.length,
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
                                categoryViewModel.categories[index].image,
                                width: 100,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              categoryViewModel.categories[index].name,
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
    );;
  }
}

