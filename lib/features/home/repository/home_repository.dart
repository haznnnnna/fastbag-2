import 'dart:convert';

import '../model/category.dart';
import 'package:http/http.dart' as http;

class CategoryRepository{

  static const String baseUrl="https://fastbag.pythonanywhere.com";

  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/vendors/categories/view/'));

    print(" API Response: ${response.body}");

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);

      if (decodedData is List) {
        return decodedData.map((e) => Category.fromJson(e)).toList();
      } else {
        print("Unexpected API response format: $decodedData");
        throw Exception("Unexpected API response format");
      }
    } else {
      print("API Error: ${response.statusCode}");
      throw Exception("Failed to load categories");
    }
  }
}