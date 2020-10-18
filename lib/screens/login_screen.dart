import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/export.dart';
import 'package:toast/toast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseRepository _firebaseRepository = FirebaseRepository();
  LoginWidgets _loginWidgets = LoginWidgets();
  bool isLoading = false;

  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff73aef5),
                  Color(0xff61a4f1),
                  Color(0xff478de0),
                  Color(0xff398ae5),
                ],
                stops: [0.1, 0.4, 0.6, 0.8],
              ),
            ),
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                )
              : Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      vertical: 120.0,
                      horizontal: 40.0,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        _loginWidgets.buildEamilTF(),
                        SizedBox(
                          height: 30.0,
                        ),
                        _loginWidgets.buildPasswordTF(),
                        _loginWidgets.buildForgotPasswordBtn(),
                        buildRememberMeCheckBox(),
                        buildLoginBtn(),
                        _loginWidgets.buildSignInWithText(),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _loginWidgets.buildFacebookLoginBtn(),
                              _loginWidgets.buildGoogleLoginBtn(),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Don\'t have an Account? ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget buildRememberMeCheckBox() {
    return Container(
      child: Row(
        children: [
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  rememberMe = value;
                });
              },
            ),
          ),
          Text(
            'Remember me',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  Widget buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        onPressed: () {
          print('login button');
          signIn();
        },
        child: Text(
          'Login',
          style: TextStyle(
            color: Color(0xff527daa),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void signIn() {
    setState(() {
      isLoading = true;
    });
    // new account
    // there is no data in database.
    // so carry out firebase auth and save in firestore
    _firebaseRepository.signIn().then((User user) {
      setState(() {
        isLoading = false;
      });
      if (user != null) {
        // delete email and password from memory.
        LoginWidgets.email.clear();
        LoginWidgets.passwd.clear();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        Toast.show("Please check your email or password", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
    });
  }
}
