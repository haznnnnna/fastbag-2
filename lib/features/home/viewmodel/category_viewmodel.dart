

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/category.dart';

import '../repository/home_repository.dart';

// final categoryProvider=Provider((ref) => CategoryViewModel(apiService: ref.watch(apiServiceProvider)),);
// final categoryProvider =
// StateNotifierProvider<CategoryViewModel, List<Category>>((ref) {
//   return CategoryViewModel(apiService: ref.watch(apiServiceProvider));
// });
// final categoryProvider = ChangeNotifierProvider(
//   create: (context) => CategoryViewModel(
//     categoryRepository: CategoryRepository(),
//   ),
// );


class CategoryViewModel extends ChangeNotifier {
  final CategoryRepository _categoryRepository = CategoryRepository(); // ✅ Create instance inside the class
  List<Category> _categories = [];
  bool _isLoading = true;

  List<Category> get categories => _categories; // ✅ Getter
  bool get isLoading => _isLoading;
  // ✅ Remove required constructor parameter
  CategoryViewModel() {
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      _isLoading = true;
      notifyListeners();
      print("🔍 Fetching categories...");
      final fetchedCategories = await _categoryRepository.fetchCategories();

      if (fetchedCategories.isEmpty) {
        print("⚠️ No categories found!");
      } else {
        print("✅ Categories fetched: ${fetchedCategories.length}");
      }

      _categories = fetchedCategories;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print("❌ Error fetching categories: $e");
      _categories = [];
      _isLoading = false;
      notifyListeners();
    }
  }


}