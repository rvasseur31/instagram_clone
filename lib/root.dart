import 'package:flutter/material.dart';
import 'package:instagram_clone/ui/view/screens/PictureListScreen.dart';
import 'package:instagram_clone/ui/view/screens/register/RegisterPasswordScreen.dart';
import 'package:provider/provider.dart';

import 'core/enums/EStatus.dart';
import 'core/provider/userRepository.dart';
import 'ui/view/screens/LoginScreen.dart';
import 'ui/view/screens/MainScreen.dart';
import 'ui/view/screens/SplashScreen.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserRepository userRepository = Provider.of<UserRepository>(context);
    return PictureListScreen();
    switch (userRepository.status) {
      case EStatus.UNITIALIZED:
        return SplashScreen();
      case EStatus.UNAUTHENTICATED:
      case EStatus.AUTHENTICATING:
        return LoginScreen();
      case EStatus.AUTHENTICATED:
        // return MainScreen(user: userRepository.user);
        return MainScreen();
      default:
        return Scaffold();
    }
  }
}
