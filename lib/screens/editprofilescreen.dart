import 'package:dtouchdental/components/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dtouchdental/constants/constants.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  @override
  void initState() {
    var currentUser = FirebaseAuth.instance.currentUser;
    print(currentUser);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const [
          SizedBox(
            height: 20,
          ),
          Text(
              "Profile Page",
              style: Constant.kPageNavStyle
          ),
        ],
      ),
    );
  }
}
