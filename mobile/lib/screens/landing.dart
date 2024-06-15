import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Health-Chatbot',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40.sp
              ),),
            Text(
              '<Insert amazing tagline here>',
              style: TextStyle(
                fontSize: 18.sp
              ),),
              SizedBox(height: 80.h,),
              ElevatedButton(onPressed: (){}, 
              child:  SizedBox(
                width: 300.w,
                child: Center(
                  child: Text('SignIn',  style: TextStyle(
                    fontSize: 18.sp,
                  ),),
                ),
              )),
              ElevatedButton(onPressed: (){}, 
              child:  SizedBox(
                width: 300.w,
                child: Center(
                  child: Text('SignUp',  style: TextStyle(
                    fontSize: 18.sp,
                  ),),
                ),
              )),
          ],),
      ),
    );
  }
}