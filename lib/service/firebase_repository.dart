import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_firebase/export.dart';

class FirebaseRepository {
  FirebaseMethos _firebaseMethos = FirebaseMethos();

  // call login function by firebase with email, passwd
  Future<User> signIn(String email, String passwd) =>
      _firebaseMethos.signIn(email, passwd);

  // call sign up function by firebase with email, passwd
  Future<dynamic> signUp(String email, String passwd) =>
      _firebaseMethos.signUp(email, passwd);
}
