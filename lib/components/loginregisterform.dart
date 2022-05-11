import 'package:dtouchdental/constants/constants.dart';
import 'package:dtouchdental/controllers/emailauth.dart';
import 'package:flutter/material.dart';
import 'package:dtouchdental/screens/homescreen.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class LoginRegisterForm extends StatefulWidget {
  const LoginRegisterForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginRegisterForm> createState() => _LoginRegisterFormState();
}

class _LoginRegisterFormState extends State<LoginRegisterForm> {
  String _authMode = 'login';
  late final renders = {
    'login': loginForm(),
    'register': registerForm(),
    'forgotpw': forgotPW(),
  };


  @override
  Widget build(BuildContext context) {


    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Hero(
          tag: 'mainlogo',
          child: Image(height: 150, image: Constant.kLogo),
        ),
        const SizedBox(
          height: 50,
        ),
        AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: Container(child: renders[_authMode],
            key: ValueKey<String>(_authMode),),
          ),

          //
          // (_authMode == 'login')
            //     ? Container(
            //         child: loginForm(),
            //         key: const ValueKey<int>(0),
            //       )
            //     : Container(
            //         child: registerForm(),
            //         key: const ValueKey<int>(1),
            //       ),
        const SizedBox(
          height: 20,
        ),
        FractionallySizedBox(
          widthFactor: 0.7,
          child: Row(
            children: const [
              Expanded(
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              Text(
                " OR ",
                style: TextStyle(color: Colors.grey),
              ),
              Expanded(
                child: Divider(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        FractionallySizedBox(
          widthFactor: 0.4,
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            child: const Text(
              "LOGIN WITH GOOGLE",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        FractionallySizedBox(
          widthFactor: 0.4,
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            child: const Text(
              "LOGIN WITH FACEBOOK",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          ),
        ),
      ],
    );
  }

  Column loginForm() {
    final _formKeyLogin = GlobalKey<FormBuilderState>();

    return Column(
      children: [
        FormBuilder(
          key: _formKeyLogin,
          child: Column(
            children: [
              FractionallySizedBox(
                widthFactor: 0.7,
                child: FormBuilderTextField(
                  name: 'email',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.email(
                        errorText: "Invalid email format"),
                    FormBuilderValidators.required(
                        errorText: "Field is required")
                  ]),
                  decoration: const InputDecoration(
                    fillColor: Colors.grey,
                    filled: true,
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FractionallySizedBox(
                widthFactor: 0.7,
                child: FormBuilderTextField(
                  name: 'password',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: "Field is required")
                  ]),
                  obscureText: true,
                  decoration: const InputDecoration(
                    fillColor: Colors.grey,
                    filled: true,
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FractionallySizedBox(
                widthFactor: 0.4,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: const Text(
                    "LOGIN",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const HomeScreen()),
                    // );
                    _formKeyLogin.currentState?.save();
                    if (_formKeyLogin.currentState!.validate()) {
                      handleLogin(_formKeyLogin.currentState?.value);

                    } else {
                      print("verification failed");
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        FractionallySizedBox(
          widthFactor: 0.7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: const Text(
                  "REGISTER",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    _authMode = 'register';
                  });
                },
              ),
              TextButton(
                child: const Text(
                  "FORGOT PW",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    _authMode = 'forgotpw';
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column registerForm() {
    final _formKeyRegister = GlobalKey<FormBuilderState>();
    TextEditingController password1 = TextEditingController();
    TextEditingController password2 = TextEditingController();

    return Column(
      children: [
        FormBuilder(
          key: _formKeyRegister,
          child: Column(
            children: [
              FractionallySizedBox(
                widthFactor: 0.7,
                child: FormBuilderTextField(
                  name: 'email',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.email(
                        errorText: "Invalid email format"),
                    FormBuilderValidators.required(
                        errorText: "Field is required"),
                    FormBuilderValidators.max(64,
                        errorText: "Character Limit: 64")
                  ]),
                  decoration: const InputDecoration(
                    fillColor: Colors.grey,
                    filled: true,
                    border: OutlineInputBorder(),
                    hintText: 'Username',
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FractionallySizedBox(
                widthFactor: 0.7,
                child: FormBuilderTextField(
                  controller: password1,
                  obscureText: true,
                  name: 'password1',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.maxLength(64,
                        errorText: "Character Limit: 64"),
                    FormBuilderValidators.required(
                        errorText: "Field is required"),
                  ]),
                  decoration: const InputDecoration(
                    fillColor: Colors.grey,
                    filled: true,
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FractionallySizedBox(
                widthFactor: 0.7,
                child: FormBuilderTextField(
                  controller: password2,
                  obscureText: true,
                  name: 'password2',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.maxLength(64,
                        errorText: "Character Limit: 64"),
                    FormBuilderValidators.required(
                        errorText: "Field is required"),
                    (val) {
                      if (val != password1.text) return "Password does not match";
                    }
                  ]),
                  decoration: const InputDecoration(
                    fillColor: Colors.grey,
                    filled: true,
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        FractionallySizedBox(
          widthFactor: 0.4,
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            child: const Text(
              "REGISTER",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const HomeScreen()),
              // );
              _formKeyRegister.currentState?.save();
              if (_formKeyRegister.currentState!.validate()) {
                handleRegister(_formKeyRegister.currentState?.value);
              } else {
                print("verification failed");
              }
            },
          ),
        ),

        const SizedBox(
          height: 20,
        ),
        FractionallySizedBox(
          widthFactor: 0.7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: const Text(
                  "BACK TO LOGIN",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    _authMode = 'login';
                  });
                },
              ),
              TextButton(
                child: const Text(
                  "FORGOT PW",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    _authMode = 'forgotpw';
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column forgotPW() {

    final _formKeyForgotPW =  GlobalKey<FormBuilderState>();

    return Column(
      children: [
        FormBuilder(
          key: _formKeyForgotPW,
          child: Column(
            children: [
              FractionallySizedBox(
                widthFactor: 0.7,
                child: FormBuilderTextField(
                  name: 'email',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.email(
                        errorText: "Invalid email format"),
                    FormBuilderValidators.required(
                        errorText: "Field is required")
                  ]),
                  decoration: const InputDecoration(
                    fillColor: Colors.grey,
                    filled: true,
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FractionallySizedBox(
                widthFactor: 0.4,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: const Text(
                    "Request for PW Reset",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () async {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const HomeScreen()),
                    // );
                    _formKeyForgotPW.currentState?.save();
                    if (_formKeyForgotPW .currentState!.validate()) {

                      handlePWReset(_formKeyForgotPW.currentState?.value);

                    } else {
                      print("verification failed");
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        FractionallySizedBox(
          widthFactor: 0.7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: const Text(
                  "REGISTER",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    _authMode = 'register';
                  });
                },
              ),
              TextButton(
                child: const Text(
                  "BACK TO LOGIN",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    _authMode = 'login';
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );

  }
}
