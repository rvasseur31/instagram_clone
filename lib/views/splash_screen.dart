import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Container(
          width: width/6,
          height: width/6,
          child: Image.asset('assets/img/instagram-logo.png'),
        ),
      ),
    );
  }
}
