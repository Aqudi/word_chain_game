import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum AuthStatus {
  UNINITIALIZED,
  CHECKING,
  LOGGED_IN,
  NOT_LOGGED_IN,
}

class FirebaseAuthProvider with ChangeNotifier {
  FirebaseAuthProvider({auth}) : _auth = auth ?? FirebaseAuth.instance {
    _auth.currentUser().then((FirebaseUser currentUser) {
      checking();
      _user = currentUser;
      done();
    });
  }

  FirebaseAuth _auth;
  FirebaseUser _user;
  AuthStatus _status = AuthStatus.UNINITIALIZED;

  FirebaseUser get user => _user;

  // 이메일 인증된 계정만 로그인된 걸로 간주
  bool get loggedIn => user != null && user.isEmailVerified;

  get status => _status;

  static Stream<FirebaseUser> get onAuthStateChanged =>
      FirebaseAuth.instance.onAuthStateChanged;

  // 이메일 기본 언어 코드
  final String _defaultLanguageCode = "ko";

  checking() {
    _status = AuthStatus.CHECKING;
    notifyListeners();
  }

  done() {
    _status = loggedIn ? AuthStatus.LOGGED_IN : AuthStatus.NOT_LOGGED_IN;
    notifyListeners();
  }

  signOut() async {
    checking();
    await _auth.signOut();
    _user = null;
    done();
  }

  Future<bool> signUpWithEmailAndPassword(
      {@required String email, @required String password}) async {
    bool result = false;
    checking();
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (authResult.user != null) {
        _user = authResult.user;
        user.sendEmailVerification();

        // 계정 생성시 기존 계정 로그아웃
        signOut();
        result = true;
      }
    } on PlatformException catch (e) {
      print("signUpWithEmailAndPassword : ${e.toString()}");
      throw e.message;
    } catch (e) {
      print("signUpWithEmailAndPassword : $e");
      throw e;
    }
    done();
    return result;
  }

  Future<bool> signInWithEmailAndPassword(
      {@required String email, @required String password}) async {
    bool result = false;
    checking();
    try {
      final credential = EmailAuthProvider.getCredential(
        email: email,
        password: password,
      );
      final authResult = await _auth.signInWithCredential(credential);
      if (authResult != null) {
        _user = authResult.user;
        result = true;
      }
    } on PlatformException catch (e) {
      print("signInWithEmailAndPassword : ${e.toString()}");
      throw e.message;
    } catch (e) {
      print("signInWithEmailAndPassword : $e");
      throw e;
    }
    done();
    return result;
  }

  sendPasswordResetEmail(String lang) async {
    checking();
    await _auth.setLanguageCode(lang ?? _defaultLanguageCode);
    _auth.sendPasswordResetEmail(email: user.email);
    done();
  }

  withdrawalAccount() async {
    checking();
    await user.delete();
    _user = null;
    done();
  }
}
