import 'package:fastbag/features/auth/repository/auth_repository.dart';

import 'package:flutter/cupertino.dart';


import '../model/user.dart';



class AuthViewModel extends ChangeNotifier{
final  _authRepository=AuthRepository();


  register(String mobile)async{
    final user = User(mobileNumber: mobile);
    final success = await _authRepository.registerUser(user);

    return success;
  }

  login(String mobile, String otp)async{
    final success = await _authRepository.loginUser(mobile, otp);
    return success;
  }
}