import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_clone/core/enums/EStatus.dart';

class UserRepository with ChangeNotifier {
  FirebaseAuth _firebaseAuth;
  
  FirebaseUser _user;
  FirebaseUser get user => _user;

  String _userId;
  String get userId => _userId;

  EStatus _status = EStatus.UNITIALIZED;
  EStatus get status => _status;
  set status(EStatus status) {
    _status = status;
    notifyListeners();
  }

  UserRepository.instance() : _firebaseAuth = FirebaseAuth.instance {
    _firebaseAuth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  Future<void> signIn(String email, String password) async {
    status = EStatus.AUTHENTICATING;
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      status = EStatus.AUTHENTICATED;
    } catch (_) {
      status = EStatus.UNAUTHENTICATED;
    }
  }

  Future<bool> register(String email, String password) async {
    status = EStatus.AUTHENTICATING;
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      status = EStatus.AUTHENTICATED;
      return true;
    } catch (_) {
      status = EStatus.UNAUTHENTICATED;
      return false;
    }
  }

  Future signOut() async {
    _firebaseAuth.signOut();
    status = EStatus.UNAUTHENTICATED;
    return Future.delayed(Duration.zero);
  }

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      status = EStatus.UNAUTHENTICATED;
    } else {
      _user = firebaseUser;
      _userId = _user.uid.toString();
      print(_userId);
      status = EStatus.AUTHENTICATED;
    }
  }
}
