import 'package:dtouchdental/constants/constants.dart';
import 'package:dtouchdental/screens/homescreen.dart';
import 'package:dtouchdental/screens/loginscreen.dart';
import 'package:dtouchdental/screens/registerdetailsscreen.dart';
import 'package:dtouchdental/screens/splashscreen.dart';
import 'package:dtouchdental/screens/verifyOTPscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import './config/config.dart';
import 'package:get/get.dart';

void main() async {
  final configurations = Configurations();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: configurations.apiKey,
        projectId: configurations.projectId,
        appId: configurations.appId,
        messagingSenderId: configurations.messengerSenderId,

    )
  );
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Constant.kAppBgColor,
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        )
      ),
      home: const LoginScreen(),
    );
  }
}
