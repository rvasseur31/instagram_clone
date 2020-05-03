import 'package:flutter/material.dart';

class GlobalUtils {
  GlobalUtils._privateConstructor();

  static final GlobalUtils _instance = GlobalUtils._privateConstructor();

  factory GlobalUtils() {
    return _instance;
  }

  void changeScreen(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  void changeScreenReplacement(BuildContext context, Widget widget) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => widget));
  }

  void resetAndOpenPage(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => widget),
        (Route<dynamic> route) => false);
  }
}
