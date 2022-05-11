import 'package:flutter/material.dart';
import 'package:dtouchdental/constants/constants.dart';
import 'package:dtouchdental/screens/editprofilescreen.dart';

class KAppBar extends StatelessWidget implements PreferredSizeWidget {
  // final callback;
  // const KAppBar(this.callback);
  @override
  Size get preferredSize => const Size.fromHeight(50);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        const IconButton(onPressed: null, icon: Icon(Constant.kHomeIcon)),
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const EditProfileScreen()),
              );
            },
            icon: const Icon(Constant.kPersonIcon)),
        const IconButton(onPressed: null, icon: Icon(Constant.kLogoutIcon)),

      ],
      backgroundColor: Constant.kAppBarColor,
      leading: const Image(
        image: Constant.kLogoOnly,
      ),
    );
  }
}
