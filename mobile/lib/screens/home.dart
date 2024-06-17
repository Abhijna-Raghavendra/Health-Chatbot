import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, String>? data =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>?;
    String? name = '';
    if (data != null) {
      name = data['name'];
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health-Chatbot'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Hey $name !',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 38.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              Text(
                'Welcome to Health-Chatbot, your go-to resource for health-related queries.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/chat',
                      arguments: {'username': name});
                },
                child: Padding(
                  padding: EdgeInsets.all(12.r),
                  child: Text(
                    'Chat with our Bot',
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
