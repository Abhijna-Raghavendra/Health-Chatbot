import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 8.w),
              child: SizedBox(
                width: 300.w,
                child: ElevatedButton(onPressed: (){
                  Navigator.pushReplacementNamed(context, '/chat');
                }, child: Text(
                  'Chat with Bot',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                  )),
              ),
            ),
          ],
        ),
      ));
  }
}