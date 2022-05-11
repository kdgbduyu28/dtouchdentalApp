import 'dart:ui';

import 'package:dtouchdental/screens/homescreen.dart';
import 'package:dtouchdental/screens/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(splash: const Hero(
      tag: 'mainlogo',
      child: Image(
        image: AssetImage('images/touch.png')
      ),
    ), nextScreen: const LoginScreen(),);
  }
}
