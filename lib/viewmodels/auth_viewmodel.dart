import 'package:fastbag/services/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/user.dart';

final authProvider=Provider((ref) => AuthViewModel(apiService: ref.watch(apiServiceProvider)),);

class AuthViewModel{
  final ApiService _apiService;
  AuthViewModel({required ApiService apiService}):_apiService=apiService;

  register(String mobile)async{
    final user = User(mobileNumber: mobile);
    final success = await _apiService.registerUser(user);

    return success;
  }

  login(String mobile, String otp)async{
    final success = await _apiService.loginUser(mobile, otp);
    return success;
  }
}