import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Constant {
  static const kAppBgColor = Color(0xFFF4DFBA);
  static const kAppBarColor = Color(0xFF876445);
  static const kErrorColor = Color(0xFFDD4A48);
  static const kLogoOnly = AssetImage('assets/logo.png');
  static const kLogo = AssetImage('assets/touch.png');
  static const kPageNavStyle = TextStyle(color: Colors.grey, fontSize: 30);
  static const kLogoutIcon = IconData(0xe3b3, fontFamily: 'MaterialIcons');
  static const kPersonIcon = IconData(0xe491, fontFamily: 'MaterialIcons');
  static const kHomeIcon = IconData(0xe318, fontFamily: 'MaterialIcons');
  static const kErrorIcon = IconData(0xe238, fontFamily: 'MaterialIcons');
  static ToggleSwitch kToggleSwitch = ToggleSwitch(
    minWidth: 100.0,
    minHeight: 50.0,
    fontSize: 16.0,
    initialLabelIndex: 1,
    activeBgColor: [Colors.green],
    activeFgColor: Colors.white,
    inactiveBgColor: Colors.grey,
    inactiveFgColor: Colors.grey[900],
    totalSwitches: 2,
    customTextStyles: const [
      TextStyle(fontSize: 15)
    ],
    labels: const ['Upcoming', 'All'],
    onToggle: (index) {
      null;
    },
  );

}