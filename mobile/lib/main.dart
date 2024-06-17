import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/screens/chat.dart';
import 'package:mobile/screens/landing.dart';
import 'package:mobile/screens/signup.dart';
import 'package:mobile/screens/home.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ScreenUtilInit(
        designSize: const Size(412, 732),
        builder: (BuildContext context, child) => MaterialApp(
              theme: ThemeData(
                fontFamily: 'UbuntuMono',
                useMaterial3: true,
                appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.white12,
                ),
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.white60,
                  brightness: Brightness.dark,
                ),
              ),
              routes: {
                '/': (context) => const LandingScreen(),
                '/signup': (context) => const SignupScreen(),
                '/home': (context) => const HomeScreen(),
                '/chat': (context) => const ChatScreen(),
              },
            )),
  );
}
