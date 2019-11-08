import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone_androidx/bloc/authentication_bloc.dart';
import 'package:instagram_clone_androidx/bloc/authentication_state.dart';
import 'package:instagram_clone_androidx/user_repository.dart';
import 'package:instagram_clone_androidx/utils/routes.dart';
import 'package:instagram_clone_androidx/utils/uidata.dart';
import 'package:instagram_clone_androidx/views/home_page.dart';
import 'package:instagram_clone_androidx/views/login/login_screen.dart';
import 'package:instagram_clone_androidx/views/splash_screen.dart';

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
        AppRoutes.homeRoute: (BuildContext context) => HomeScreen(
              name: null,
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
            return HomeScreen(name: state.displayName);
          } else if (state is Unauthenticated) {
            return LoginScreen(userRepository: _userRepository);
          }
          return SplashScreen();
        },
      ),
    );
  }
}
