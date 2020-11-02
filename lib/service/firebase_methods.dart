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
    print(result.docs[0].data().toString());
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
}
