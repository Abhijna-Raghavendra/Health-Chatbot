import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    String? name = '';
    String? username = '';
    String? phoneNumber = '';
    if (data != null) {
      name = data['name'];
      username = data['username'];
      phoneNumber = data['emergency_contact'];
    }
    print(phoneNumber);
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
              SizedBox(
                width: 40.w,
                child: Image.asset('assets/images/logo.png'),
              ),
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
                      arguments: {'username': username});
                },
                child: Padding(
                  padding: EdgeInsets.all(12.r),
                  child: Text(
                    'Chat with our Bot',
                    style: TextStyle(fontSize: 18.sp),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              ElevatedButton(
                onPressed: () {
                  _makePhoneCall(phoneNumber!);
                },
                child: Padding(
                  padding: EdgeInsets.all(12.r),
                  child: Text(
                    'Place emergency call',
                    style: TextStyle(fontSize: 18.sp),
                  ),
                ),
              ),
              const Text(
                '*while our chatbot efficiently provides great medical advice, if you think you are facing a serious health issues, please call your emergency contact.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _makePhoneCall(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
