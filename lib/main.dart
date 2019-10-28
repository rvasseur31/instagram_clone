import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone_androidx/app.dart';
import 'package:instagram_clone_androidx/bloc/authentication_bloc.dart';
import 'package:instagram_clone_androidx/bloc/authentication_event.dart';
import 'package:instagram_clone_androidx/user_repository.dart';
import 'bloc/simple_bloc_delegate.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider(
      builder: (context) => AuthenticationBloc(userRepository:  userRepository)..add(AppStarted()),
      child: App(userRepository: userRepository),
    )
  );
}
