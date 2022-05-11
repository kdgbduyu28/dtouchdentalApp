import 'dart:async';

import 'package:dtouchdental/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class VerifyOTPScreen extends StatefulWidget {
  const VerifyOTPScreen({Key? key}) : super(key: key);

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  var userCredential;
  var confirmationResult;
  var _otpCode;
  String userNumber = Get.arguments;

  @override
  void initState() {
    // userCredential = FirebaseAuth.instance.currentUser;
    sendOTP();
    super.initState();
  }

  void sendOTP() async {
    await FirebaseAuth.instance.verifyPhoneNumber(phoneNumber: userNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
      print("update sucecss????????");
        FirebaseAuth.instance.currentUser?.updatePhoneNumber(phoneAuthCredential);
        },
        verificationFailed: (FirebaseAuthException authException) {
        print(authException.message);
        },
        codeSent: (String verificationId, int? resendToken) {
            print(verificationId);
        },
        codeAutoRetrievalTimeout: (String timeout) {
          print(timeout);
        });
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(height: 150, image: Constant.kLogo,),
              const Text("OTP Verification",
              style: TextStyle(fontSize: 25),),
              const SizedBox(height: 10,),
              Text('Sent OTP SMS to '+userNumber,
                style: TextStyle(fontSize: 15),),
              OTPTextField(
                width: (MediaQuery.of(context).size.width)*0.8,
                length: 6,
                fieldWidth: 50,
                fieldStyle: FieldStyle.underline,
                onChanged: (userpin) {},
                onCompleted: (pin) {
                  print(pin);
                },
              )
            ],

          ),
        ));
  }
}


// FractionallySizedBox(
// widthFactor: 0.7,
// child: Container(
// child: verifyOTP
// ? Center(
// child: Column(
// children: [
// const Text(
// "OTP SMS has been sent to your phone"),
// const SizedBox(height: 10),
// FractionallySizedBox(
// widthFactor: 0.5,
// child: TextFormField(
// onSaved: (String? value) {
// fname = value;
// },
// keyboardType: TextInputType.number,
// decoration: const InputDecoration(
// fillColor: Colors.grey,
// filled: true,
// border: OutlineInputBorder(),
// hintText: 'OTP Code',
// ),
// ),
// ),
// const SizedBox(height: 10),
// TextButton(
// style: ButtonStyle(
// backgroundColor:
// MaterialStateProperty.all<Color>(
// Colors.white),
// ),
// onPressed: () {
// setState(() {
// verifyOTP = false;
// saveContinueButton = true;
// });
// },
// child: const Text(
// "Confirm OTP",
// style: TextStyle(color: Colors.black),
// ),
// )
// ],
// ))
//     : null),
// ),

// TextButton(
// style: ButtonStyle(
// backgroundColor: MaterialStateProperty.all<Color>(
// Colors.white),
// ),
// child: const Text(
// "Verify",
// style: TextStyle(color: Colors.black),
// ),
// onPressed: () {
// _formKeyPxInfo.currentState?.save();
// setState(() {
// verifyOTP = true;
// });
// String userNumber =
// '${contactNumber?.countryCode}${contactNumber?.number}';
// print(userNumber);
// print(lnameController.value);
// // FirebaseAuth.instance.verifyPhoneNumber(
// //     phoneNumber: userNumber,
// //     verificationCompleted: (credential) async {
// //       await FirebaseAuth.instance.currentUser?.updatePhoneNumber(credential);
// //     },
// //     verificationFailed: null,
// //     codeSent: null,
// //     codeAutoRetrievalTimeout: null);
// },
// ),
