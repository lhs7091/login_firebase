import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserInfoProvider with ChangeNotifier {
  User _currentUser;

  User getCurrentUser() => _currentUser;

  void setCurrentUser(User user) {
    _currentUser = user;
    notifyListeners();
  }
}
