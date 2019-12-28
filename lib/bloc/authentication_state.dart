import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState{}

class Authenticated extends AuthenticationState{
  final String displayName;
  final String uid;

  const Authenticated(this.displayName, this.uid);
  
  @override
  List<Object> get props => [displayName, uid];

  @override
  String toString() => 'Authenticated {displayName: $displayName, uid: $uid}';

}

class Unauthenticated extends AuthenticationState{}
