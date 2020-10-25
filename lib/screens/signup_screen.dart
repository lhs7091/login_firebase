import 'package:flutter/material.dart';
import 'package:login_firebase/export.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  SignUpWidget _signUpWidget = SignUpWidget();
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
                      child: _signUpWidget),
                ),
        ],
      ),
    );
  }
}
