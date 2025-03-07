import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/category.dart';
import '../model/user.dart';
import 'package:http/http.dart' as http;

import '../views/otplogin.dart';

final apiServiceProvider=Provider((ref) => ApiService(),);

class ApiService{
  static const String baseUrl="https://fastbag.pythonanywhere.com";

  registerUser(User user)async{
    final response = await http.post(
      Uri.parse('$baseUrl/users/register/'),
      body: jsonEncode(user.toJson()),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('mobile_number', user.mobileNumber);

    }
    
  }

  
  loginUser(String mobile,String otp)async{
    final response = await http.post(
      Uri.parse('$baseUrl/users/login/'),
      body: jsonEncode({"mobile_number": mobile, "otp": otp}),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setString('mobile_number', user.mobileNumber);

    }
  }
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