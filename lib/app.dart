import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/authenticated_app.dart';

import 'bloc/bloc.dart';
import 'user_repository.dart';
import 'utils/routes.dart';
import 'utils/uidata.dart';
import 'views/home_page.dart';
import 'views/login/login_screen.dart';
import 'views/splash_screen.dart';

class App extends StatelessWidget {
  final UserRepository _userRepository;

  App({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: UIData.appName,
      theme: ThemeData(
        primaryColor: Colors.black,
        fontFamily: UIData.quickFont,
        primarySwatch: Colors.amber,
      ),
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      routes: <String, WidgetBuilder>{
        AppRoutes.homeRoute: (BuildContext context) => HomeView(
              uid: null,
            ),
        AppRoutes.splashScreenRoute: (BuildContext context) => SplashScreen(),
        AppRoutes.signInScreenRoute: (BuildContext context) =>
            LoginScreen(userRepository: _userRepository),
      },
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Uninitialized) {
            return SplashScreen();
          } else if (state is Authenticated) {
            //return PickImageAndAddedToFirebase(uid: state.uid);
            //return Profile();
            //return HomeView(uid: "61lh3rJwimfa8rQjotJcNK2hMqs0");
            return AuthenticatedApp(uid: state.uid);
          } else if (state is Unauthenticated) {
            return LoginScreen(userRepository: _userRepository);
          }
          return SplashScreen();
        },
      ),
    );
  }
}
