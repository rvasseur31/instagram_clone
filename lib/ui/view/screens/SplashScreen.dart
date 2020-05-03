import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
            width: MediaQuery.of(context).size.width / 4,
            child: Image.asset('assets/img/instagram-logo.png'),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
            width: MediaQuery.of(context).size.width / 3,
            child: Image.asset('assets/img/logo.png'),
          ),
        ],
      )),
    );
  }
}
