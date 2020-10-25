import 'package:firebase_auth/firebase_auth.dart';

class FirebaseMethos {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
}
