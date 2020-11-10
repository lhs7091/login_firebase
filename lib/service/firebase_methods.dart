import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_firebase/export.dart';

class FirebaseMethos {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // email password authentication
  Future<User> signIn(String email, String passwd) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: passwd);
      User loginUser = result.user;
      return loginUser;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign up email, password
  Future<dynamic> signUp(String email, String passwd) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: passwd);
      User signUpUser = result.user;
      return signUpUser;
    } catch (e) {
      print(e.toString());
      return e;
    }
  }

  // find current user info in DB
  Future<dynamic> findCurrentUser(String uid) async {
    QuerySnapshot result = await firestore
        .collection(USERS_COLLECTION)
        .where(UID_FIELD, isEqualTo: uid)
        .get();
    if (result.docs.length != 0) {
      UserModel userModel = UserModel.fromMap(result.docs[0].data());
      return userModel;
    } else {
      return null;
    }
  }

  // save new user in DB(Firestore)
  saveNewUser(User user) async {
    UserModel userModel = UserModel(
      uid: user.uid,
      name: user.displayName,
      email: user.email,
      imageUrl: user.photoURL,
    );

    await firestore
        .collection(USERS_COLLECTION)
        .doc(user.uid)
        .set(userModel.toMap(userModel));
  }

  Future<String> updateUserInfo(UserModel user) async {
    await firestore
        .collection(USERS_COLLECTION)
        .doc(user.uid)
        .update(user.toMap(user));
  }

  Future<dynamic> addPost(Post post) async {
    await firestore.collection(POSTS_COLLECTION).doc().set(post.toMap(post));
  }

  Future<List<Post>> getAllPosts() async {
    print('methods getAllposts');
    List<Post> postList = List<Post>();
    QuerySnapshot result = await firestore
        .collection(POSTS_COLLECTION)
        .orderBy(TIMESTAMP_FIELD, descending: true)
        .get();
    if (result.docs.length != 0) {
      result.docs.forEach((element) {
        postList.add(Post.fromMap(element.data()));
      });
    }
    return postList;
  }

  Future<UserModel> findUser(String uid) async {
    UserModel userModel;
    QuerySnapshot result = await firestore
        .collection(USERS_COLLECTION)
        .where(UID_FIELD, isEqualTo: uid)
        .get();
    if (result.docs.length != 0) {
      userModel = UserModel.fromMap(result.docs[0].data());
    }
    return userModel;
  }
}
