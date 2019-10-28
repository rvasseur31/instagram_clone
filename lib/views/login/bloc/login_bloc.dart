import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:instagram_clone_androidx/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import '../validators.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  UserRepository _userRepository;

  LoginBloc({@required UserRepository userRepository})
    : assert(userRepository != null),
    _userRepository = userRepository;

  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<LoginState> transformEvents(
    Stream<LoginEvent> events,
    Stream<LoginState> Function(LoginEvent event) next,
  ) {
    final observableStream = events as Observable<LoginEvent>;
    final nonDebounceStream = observableStream.where((event) {
      return (event is! EmailChanged && event is! PasswordChanged);
    });

    final debounceStream = observableStream.where((event) {
      return (event is EmailChanged || event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    
    return super.transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is EmailChanged){
      yield* _mapEmailChangedToState(event.email);
    }
    else if (event is PasswordChanged){
      yield* _mapPasswordChangedToState(event.password);
    }
    else if (event is LoggingWithGooglePressed){
      yield* _mapLoginWithGooglePressedToState();
    }
    else if (event is LoggingWithCredentialsPressed){
      yield* _mapLoginWithCredentialsPressedToState(
        email: event.email,
        password: event.password);
    }
  }

  Stream<LoginState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email)
    );
  } 

  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password)
    );
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    try {
      await _userRepository.signInWithGoogle();
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState({
    String email,
    String password
  }) async* {
    print("MY EMAIL : " + email);
    print("MY PASSWORD : " + password);
    yield LoginState.loading();
    try {
      await _userRepository.signInWithCredential(email, password);
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }
}