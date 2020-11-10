import 'package:flutter/material.dart';
import 'package:login_firebase/export.dart';

class PostProvider with ChangeNotifier {
  FirebaseRepository _firebaseRepository = FirebaseRepository();
  List<Post> _postList;

  getPostList() => _postList;

  setPostList() async {
    print('setPostList call');
    _postList = await _firebaseRepository.getAllPosts();
    notifyListeners();
  }

  setUserModel() async {
    print('setUserModel in post provider');
    for (int i = 0; i < _postList.length; i++) {
      UserModel userModel = UserModel();
      userModel = await _firebaseRepository.findUser(_postList[i].uid);
      _postList[i].setUserModel(userModel);
    }
    notifyListeners();
  }
}
