import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

import 'LandingPage.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedSplashScreen(
        splash: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo2.png', width: 300),
              const SizedBox(height: 20),
            ],
          ),
        ),
        backgroundColor: Colors.black,
        nextScreen: LandingPage(),
        splashIconSize: 500,
        duration: 5000,
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.leftToRightWithFade,
        animationDuration: const Duration(seconds: 3),
      ),
    );
  }
}
