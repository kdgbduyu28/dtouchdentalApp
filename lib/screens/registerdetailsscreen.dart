import 'package:dtouchdental/constants/constants.dart';
import 'package:dtouchdental/screens/homescreen.dart';
import 'package:dtouchdental/screens/verifyOTPscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';


class RegisterDetailsScreen extends StatefulWidget {
  const RegisterDetailsScreen({Key? key}) : super(key: key);

  @override
  State<RegisterDetailsScreen> createState() => _RegisterDetailsScreenState();
}
class _RegisterDetailsScreenState extends State<RegisterDetailsScreen> {
  // var userName,userPhone;
  var userCredential;
  @override
  void initState() {
    // userName = FirebaseAuth.instance.currentUser?.displayName;
    // userPhone = FirebaseAuth.instance.currentUser?.phoneNumber;
    userCredential = FirebaseAuth.instance.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _formKeyPxInfo = GlobalKey<FormState>();
    String? lname, fname;
    PhoneNumber? contactNumber;
    var contact = TextEditingController();

    verifyOTP(String userNumber) async {

      OtpFieldController otpFieldController = OtpFieldController();

      await FirebaseAuth.instance.verifyPhoneNumber(phoneNumber: userNumber,
          verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
            FirebaseAuth.instance.currentUser?.updatePhoneNumber(phoneAuthCredential);
          },
          verificationFailed: (FirebaseAuthException authException) {
            print(authException.message);
          },
          codeSent: (String verificationId, int? resendToken) {
            Get.defaultDialog(
              title: 'OTP sent to '+userNumber,
              barrierDismissible: false,
              content: Center(
                child: OTPTextField(
                  controller: otpFieldController,
                  width: (MediaQuery.of(context).size.width)*0.7,
                  length: 6,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  fieldWidth: 45,
                  fieldStyle: FieldStyle.underline,
                  onChanged: (userpin) {},
                  onCompleted: (pin) {
                    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
                        verificationId: verificationId,
                        smsCode: pin);
                    FirebaseAuth.instance.currentUser?.updatePhoneNumber(phoneAuthCredential)
                        .catchError((onError) {
                      otpFieldController.clear();
                      Get.snackbar(
                          "Error",
                          "Incorrect OTP",
                          icon: const Icon(Constant.kErrorIcon),
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Constant.kErrorColor,
                          duration: const Duration(seconds: 3)
                      );
                      Get.back();
                    });

                    print(FirebaseAuth.instance.currentUser?.phoneNumber);
                    Get.back();
                    Get.to(()=> const HomeScreen());
                  },
                ),
              ),
            );
          },
          codeAutoRetrievalTimeout: (String timeout) {
            print(timeout);
          });


    }
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(height: 150, image: Constant.kLogo),
            const Text(
              "Patient Information",
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Form(
                  key: _formKeyPxInfo,
                  child: Column(children: [
                    FractionallySizedBox(
                      widthFactor: 0.7,
                      child: TextFormField(
                        onSaved: (String? value) {
                          fname = value;
                        },
                        decoration: const InputDecoration(
                          fillColor: Colors.grey,
                          filled: true,
                          border: OutlineInputBorder(),
                          hintText: 'First Name',
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    FractionallySizedBox(
                      widthFactor: 0.7,
                      child: TextFormField(
                        onSaved: (String? value) {
                          lname = value;
                        },
                        decoration: const InputDecoration(
                          fillColor: Colors.grey,
                          filled: true,
                          border: OutlineInputBorder(),
                          hintText: 'Last Name',
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    FractionallySizedBox(
                      widthFactor: 0.7,
                      child: IntlPhoneField(
                        onSaved: (phone) {
                          contactNumber = phone;
                        },
                        controller: contact,
                        decoration: const InputDecoration(
                          fillColor: Colors.grey,
                          filled: true,
                          border: OutlineInputBorder(),
                          hintText: 'Contact Number',
                        ),
                        initialCountryCode: 'PH',
                      ),
                    ),
                  ]),
                ),
                const SizedBox(height: 20),
                FractionallySizedBox(
                  widthFactor: 0.4,
                  child: TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white)),
                    child: const Text(
                      "Save And Verify OTP",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () async {
                      _formKeyPxInfo.currentState?.save();
                      String userNumber =
                          '${contactNumber?.countryCode}${contactNumber?.number}';
                      print(userNumber);
                      // _formKeyPxInfo.currentState?.save();
                      // if (_formKeyPxInfo.currentState!.validate()) {
                      //   var data = _formKeyPxInfo.currentState != null?
                      //   print(data);
                      var displayName = '$lname, $fname';
                      print(displayName);
                      // var phoneNumber = data['contactNumber'];
                      await FirebaseAuth.instance.currentUser?.updateDisplayName(displayName);
                      verifyOTP(userNumber);
                      // print(FirebaseAuth.instance.currentUser);
                      // await FirebaseAuth.instance.currentUser?.updatePhoneNumber(phoneNumber);
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
