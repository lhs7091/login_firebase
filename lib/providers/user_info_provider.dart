import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/export.dart';

class UserInfoProvider with ChangeNotifier {
  User _currentUserFirebase;

  UserModel _currentUserInfo;

  User getCurrentUser() => _currentUserFirebase;

  void setCurrentUser(User user) {
    _currentUserFirebase = user;
    setCurrentUserInfo();
    notifyListeners();
  }

  UserModel getCurrentUserInfo() => _currentUserInfo;

  void setCurrentUserInfo() {
    _currentUserInfo = new UserModel();
    _currentUserInfo.setUid(_currentUserFirebase.uid);
    _currentUserInfo.setName(_currentUserFirebase.displayName);
    _currentUserInfo.setEmail(_currentUserFirebase.email);
    _currentUserInfo.setImageUrl(_currentUserFirebase.photoURL);
    notifyListeners();
  }
}
