import 'package:blind/Screens/MainPages/LandingPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:blind/Screens/MainPages/Dashboard.dart';

import 'Screens/MainPages/AutoClickPage.dart';
import 'Screens/MainPages/LandingPage.dart';
import 'Screens/MainPages/SplashScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      title: 'Blind App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
       home:  const SplashScreen(),
    );
  }
}

