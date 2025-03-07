import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/category.dart';
import '../services/api_service.dart';

// final categoryProvider=Provider((ref) => CategoryViewModel(apiService: ref.watch(apiServiceProvider)),);
final categoryProvider =
StateNotifierProvider<CategoryViewModel, List<Category>>((ref) {
  return CategoryViewModel(apiService: ref.watch(apiServiceProvider));
});

class CategoryViewModel extends StateNotifier<List<Category>> {
  final ApiService _apiService;


  CategoryViewModel({required ApiService apiService})
      : _apiService = apiService,
        super([]) {
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final categories = await _apiService.fetchCategories();
      if (categories.isEmpty) {
      }
    } catch (e) {
      state = []; // Prevent UI crashes
    }
  }
}