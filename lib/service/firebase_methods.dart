import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_firebase/widgets/login_widget.dart';

class FirebaseMethos {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // email password authentication
  Future<User> signIn() async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: LoginWidgets.email.text, password: LoginWidgets.passwd.text);
      User loginUser = result.user;
      return loginUser;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
