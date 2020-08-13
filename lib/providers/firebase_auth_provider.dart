import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthProvider with ChangeNotifier {
  FirebaseAuthProvider({auth}) : _auth = auth ?? FirebaseAuth.instance {
    _auth.currentUser().then((FirebaseUser currentUser) => _user = currentUser);
  }

  FirebaseAuth _auth;
  FirebaseUser _user;

  FirebaseUser get user => _user;
  
  // 이메일 인증된 계정만 로그인된 걸로 간주
  bool get loggedIn => user != null && user.isEmailVerified;

  set user(FirebaseUser value) {
    _user = value;
    notifyListeners();
  }

  static Stream<FirebaseUser> get onAuthStateChanged =>
      FirebaseAuth.instance.onAuthStateChanged;

  // 이메일 기본 언어 코드
  final String _defaultLanguageCode = "ko";

  signOut() async {
    await _auth.signOut();
    user = null;
  }

  Future<bool> signUpWithEmailAndPassword(
      {@required String email, @required String password}) async {
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (authResult.user != null) {
        user = authResult.user;
        user.sendEmailVerification();

        // 계정 생성시 기존 계정 로그아웃
        signOut();
        return true;
      }
    } catch (e) {
      print(e.toString());
      throw new AuthException(e.code, e.message);
    }
    return false;
  }

  Future<bool> signInWithEmailAndPassword(
      {@required String email, @required String password}) async {
    try {
      final credential = EmailAuthProvider.getCredential(
        email: email,
        password: password,
      );
      final authResult = await _auth.signInWithCredential(credential);
      if (authResult != null) {
        user = authResult.user;
        return true;
      }
    } catch (e) {
      print(e.toString());
      throw new AuthException(e.code, e.message);
    }
    return false;
  }

  sendPasswordResetEmail(String lang) async {
    await _auth.setLanguageCode(lang ?? _defaultLanguageCode);
    _auth.sendPasswordResetEmail(email: user.email);
  }

  withdrawalAccount() async {
    await user.delete();
    user = null;
  }
}
