import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instagram_clone/core/provider/userRepository.dart';
import 'package:provider/provider.dart';

import 'core/constants/uiData.dart';
import 'root.dart';
import 'ui/view/screens/LoginScreen.dart';
import 'ui/view/screens/register/RegisterEmailScreen.dart';
import 'ui/view/screens/register/RegisterPasswordScreen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return ChangeNotifierProvider(
      create: (_) => UserRepository.instance(),
      child: MaterialApp(
        title: UIData.appName,
        theme: ThemeData(
          primaryColor: Colors.black,
          fontFamily: UIData.quickFont,
          primarySwatch: Colors.amber,
        ),
        debugShowCheckedModeBanner: false,
        showPerformanceOverlay: false,
        routes: {
          '/login': (context) => LoginScreen(),
          '/register-email': (context) => RegisterEmailScreen(),
          '/register-password': (context) => RegisterPasswordScreen()
        },
        home: Root(),
      ),
    );
  }
}
