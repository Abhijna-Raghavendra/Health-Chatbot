import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/utils.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController pswdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Health-Chatbot',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.sp),
            ),
            Text(
              '<Insert amazing tagline here>',
              style: TextStyle(fontSize: 18.sp),
            ),
            SizedBox(
              height: 40.h,
            ),
            SizedBox(
              width: 300.w,
              child: TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
            ),
            SizedBox(
              width: 300.w,
              child: TextFormField(
                obscureText: true,
                controller: pswdController,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            ElevatedButton(
                onPressed: () async {
                  Map<String, String> m = {
                    "username": usernameController.text,
                    "password": pswdController.text,
                  };
                  Map<String, dynamic> r = await signin(m);
                  print(r);
                  Navigator.pushReplacementNamed(context, '/home',
                      arguments: r);
                },
                child: SizedBox(
                  width: 260.w,
                  child: Center(
                    child: Text(
                      'SignIn',
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                )),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/signup');
              },
              child: Center(
                child: Text(
                  'SignUp',
                  style: TextStyle(
                    fontSize: 14.sp,
                    decoration: TextDecoration.underline,
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
