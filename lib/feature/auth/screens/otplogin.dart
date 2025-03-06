import 'dart:async';
import 'dart:convert';

import 'package:fastbag/feature/auth/screens/signup.dart';
import 'package:fastbag/feature/auth/screens/signup.dart';
import 'package:fastbag/feature/homescreen/screens/home_bottom.dart';
import 'package:fastbag/feature/homescreen/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/localvariables.dart';

class Otplogin extends StatefulWidget {
  final String mobileNumber;
  const Otplogin({super.key, required this.mobileNumber});

  @override
  State<Otplogin> createState() => _OtploginState();
}

class _OtploginState extends State<Otplogin> {
  String otpCode = "";
  bool isLoading = false;

  Future<void> loginWithOtp() async {
    if (otpCode.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a 6-digit OTP")),
      );
      return;
    }

    setState(() => isLoading = true);

    final url = Uri.parse("https://fastbag.pythonanywhere.com/users/login/");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "mobile_number": widget.mobileNumber,
        "otp": otpCode
      }),
    );

    print("Response Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('mobile_number', widget.mobileNumber);
      await prefs.setBool('isLoggedIn', true);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeBottom()),
            (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${response.body}")),
      );
    }

    setState(() => isLoading = false);
  }



  int _counter = 50;
  late Timer _timer;
  bool isResendEnabled = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _counter = 10;
    isResendEnabled = false;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        setState(() {
          _counter--;
        });
      } else {
        setState(() {
          isResendEnabled = true;
          _timer.cancel();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(width * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.07),
            Text(
              "Enter the 6-digit code sent to you at",
              style: GoogleFonts.figtree(fontSize: 18.5, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            Text(
              widget.mobileNumber,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: width * 0.7,
              child: PinCodeTextField(
                appContext: context,
                length: 6,
                keyboardType: TextInputType.number,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  activeColor: Colors.blue,
                  inactiveColor: Colors.blue.shade200,
                  selectedColor: Colors.blueAccent,
                  selectedFillColor: Colors.grey,
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                ),
                onChanged: (value) {
                  setState(() {
                    otpCode = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.blueGrey.shade100),
              onPressed: () {

              },
              child: Text(
                "Resend Code",
                style: TextStyle(color: Colors.black),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back, size: 30),
                ),
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      onPressed: isLoading ? null : loginWithOtp,
                      child: isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text("Verify", style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
