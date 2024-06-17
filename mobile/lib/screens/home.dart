import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, String>? data =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>?;
    String? name = 'testing';
    if (data != null) {
      name = data['name'];
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Healthcare Chatbot'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Hey $name',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              Text(
                'medicalHistory',
                style: TextStyle(fontSize: 16.sp),
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/chat');
                },
                child: Padding(
                  padding: EdgeInsets.all(12.r),
                  child: Text(
                    'Chat with our Healthcare Bot',
                    style: TextStyle(fontSize: 18.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
