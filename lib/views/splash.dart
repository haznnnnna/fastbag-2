
import 'package:fastbag/views/signup.dart';
import 'package:flutter/material.dart';

import '../core/constants/imageconstants.dart';
import '../core/constants/localvariables.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Stack(children:[
            SizedBox(
                height: height*1,
                child: Image.asset(ImageConstants.splashLogo,height: height*1,width: width*1,fit: BoxFit.fill,)),
            Align(
              alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: height*1,
                    child: Image.asset(ImageConstants.splashGradient,height: height*1,fit: BoxFit.fill,))),
            Align
              (
              alignment: Alignment.center,
                child: Padding(
                  padding:  EdgeInsets.only(
                    top: height*0.25
                  ),
                  child: Image.asset(ImageConstants.foodLogo),
                )),
            Align
              (
                alignment: Alignment.center,
                child: Padding(
                  padding:  EdgeInsets.only(
                      top: height*0.55,
                    left: width*0.03,
                    right: width*0.03,
                  ),
                  child: Text('FastBag brings food, groceries, and fashion together, making it easy to find everything you need in one place.',style: TextStyle(
                    color: Colors.white
                  ),
                  textAlign: TextAlign.center,),
                )),
            Align
              (
                alignment: Alignment.center,
                child: Padding(
                  padding:  EdgeInsets.only(
                    top: height*0.7,
                    left: width*0.03,
                    right: width*0.03,
                  ),
                  child:GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>Signup() ,), (route) => false,);
                    },
                    child: Container(
                      height: height*0.1,
                      width: width*0.2,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: Icon(Icons.arrow_forward_ios_sharp,color: Colors.white,),
                    ),
                  )
                ))
          ] ,
          ),
        ],
      )
    );
  }
}
