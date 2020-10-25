import 'package:flutter/material.dart';
import 'package:login_firebase/export.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
            child: LoginWidgets(),
          ),
        ],
      ),
    );
  }
}
