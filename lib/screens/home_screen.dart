import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/export.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../export.dart';
import '../export.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserInfoProvider _userInfoProvider;

  UserModel _currentUser;

  @override
  Widget build(BuildContext context) {
    _userInfoProvider = Provider.of<UserInfoProvider>(context);
    _currentUser = _userInfoProvider.getCurrentUserInfo();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: _currentUser.imageUrl != null
                      ? CachedNetworkImageProvider(
                          _userInfoProvider.getCurrentUserInfo().imageUrl)
                      : AssetImage('assets/logos/default.png'),
                ),
                SizedBox(width: 10.0),
                Text(
                  _currentUser.name != null
                      ? _currentUser.name
                      : _currentUser.email,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
            centerTitle: false,
            floating: true,
            actions: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(MdiIcons.plus),
                  color: Colors.black,
                  onPressed: () {
                    print('new post');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PostWriteScreen()));
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.search),
                  color: Colors.black,
                  onPressed: () {},
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: PopupMenuButton<String>(
                  icon: Icon(
                    Icons.person_outline_sharp,
                    color: Colors.black,
                  ),
                  onSelected: choiceAction,
                  itemBuilder: (BuildContext context) {
                    return UserAccountPopupConst.choices.map((String choice) {
                      return PopupMenuItem(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
                // IconButton(
                //   icon: Icon(Icons.person_outline_sharp),
                //   color: Colors.black,
                //   onPressed: () {},
                // ),
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final Post post = posts[index];
              return PostContainer(post: post);
            }, childCount: posts.length),
          ),
        ],
      ),
    );
  }

  void choiceAction(String choice) {
    if (choice == UserAccountPopupConst.ACCOUNT) {
      print('account modify');
    } else if (choice == UserAccountPopupConst.LOGOUT) {
      logout();
    }
  }

  Future<Null> logout() async {
    await FirebaseAuth.instance.signOut();

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MyApp()),
        (Route<dynamic> route) => false);
  }
}
