import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/export.dart';

class UserInfoProvider with ChangeNotifier {
  User _currentUserFirebase;

  UserModel _currentUserInfo;

  User getCurrentUser() => _currentUserFirebase;

  void setCurrentUser(User user) {
    _currentUserFirebase = user;
    notifyListeners();
  }

  UserModel getCurrentUserInfo() => _currentUserInfo;

  void setCurrentUserInfo(UserModel userModel) {
    _currentUserInfo = userModel;
    notifyListeners();
  }
}
