import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/user.dart';

class AuthRepository{
  static const String baseUrl = "https://fastbag.pythonanywhere.com";
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
}