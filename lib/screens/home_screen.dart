import 'package:flutter/material.dart';
import 'package:login_firebase/export.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    UserInfoProvider _userInfoProvider = Provider.of<UserInfoProvider>(context);
    return Container(
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
      child: Column(
        children: [
          Text(
            'Login Complete',
            style: textStyle(),
          ),
          SizedBox(
            height: 50.0,
          ),
          Text(
            '${_userInfoProvider.getCurrentUser().uid}',
            style: textStyle(),
          ),
          SizedBox(
            height: 50.0,
          ),
          Text(
            _userInfoProvider.getCurrentUser().email,
            style: textStyle(),
          ),
          SizedBox(
            height: 50.0,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: Text(
              'Log out',
              style: textStyle(),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle textStyle() {
    return TextStyle(
      fontSize: 20,
      color: Colors.white,
    );
  }
}
