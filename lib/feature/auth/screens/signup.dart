import 'dart:convert';

import 'package:fastbag/feature/auth/screens/otplogin.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/localvariables.dart';
String mobileNumber = "";
class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController phoneNumberController=TextEditingController();

  bool isLoading = false;

  Future<void> registerUser(String mobileNumber) async {
    setState(() => isLoading = true);

    final url = Uri.parse("https://fastbag.pythonanywhere.com/users/register/");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"mobile_number": mobileNumber}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('mobile_number', mobileNumber);

      Future.delayed(Duration(milliseconds: 300), () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Otplogin(mobileNumber: mobileNumber,)));
      });
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${response.body}")),
      );
    }

    setState(() => isLoading = false);
  }


  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(width * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Login or create an account',
              style: GoogleFonts.jomhuria(fontSize: 44, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: height * 0.3,
              child:IntlPhoneField(
                controller: phoneNumberController,
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Phone Number',
                  labelStyle: const TextStyle(color: Colors.blue),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue, width: 1.5),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  border: OutlineInputBorder(borderSide: BorderSide()),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                dropdownIcon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                initialCountryCode: 'IN',
                onChanged: (phone) {
                  setState(() {
                    mobileNumber = phone.completeNumber;
                  });
                },
              ),

            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: GoogleFonts.luxuriousRoman(fontSize: 17, color: Colors.black),
                children: [
                  TextSpan(text: "By clicking “Continue” you agree with our "),
                  TextSpan(
                    text: "Terms and conditions",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (mobileNumber.isNotEmpty) {
                  registerUser(mobileNumber); // Pass the stored number
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please enter a valid phone number")),
                  );
                }
              },
              child: Container(
                height: height * 0.08,
                width: width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(width * 0.09),
                ),
                child: Center(
                  child: Text(
                    'Continue',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
