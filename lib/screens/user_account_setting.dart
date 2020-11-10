import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_firebase/export.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class UserAccountSettingScreen extends StatefulWidget {
  @override
  _UserAccountSettingScreenState createState() =>
      _UserAccountSettingScreenState();
}

class _UserAccountSettingScreenState extends State<UserAccountSettingScreen> {
  UserInfoProvider _userInfoProvider;
  UserModel _currentUser;

  final FocusNode userNameFocusNode = FocusNode();

  final FirebaseRepository _firebaseRepository = FirebaseRepository();

  String name;
  String imageUrl;
  bool isUploadingPicture = false;

  TextEditingController _name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _userInfoProvider = Provider.of<UserInfoProvider>(context);
    _currentUser = _userInfoProvider.getCurrentUserInfo();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        brightness: Brightness.light,
        backgroundColor: Color(0xff232f34),
        title: Text(
          'User Account Setting',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: false,
        actions: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff344955),
              Color(0xff4a6572),
            ],
          ),
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50.0,
                  ),
                  buildProfilePicture(context),
                  SizedBox(
                    height: 30.0,
                  ),
                  buildEmailTextField(),
                  SizedBox(
                    height: 30.0,
                  ),
                  buildNameTextField(),
                  SizedBox(
                    height: 50.0,
                  ),
                  buildSaveBtn(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSaveBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
      width: double.infinity,
      child: RaisedButton(
        color: Color(0xff37474f),
        elevation: 5.0,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        onPressed: () {
          setState(() {
            name = _name.text;
          });
          saveFunction();
          userNameFocusNode.unfocus();
        },
        child: Text(
          'Save',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void saveFunction() {
    // provider setting,
    if (_name.text != "") {
      _userInfoProvider.setNewName(_name.text);
    }

    setState(() {
      _currentUser = _userInfoProvider.getCurrentUserInfo();
    });
    // DB update
    _firebaseRepository.updateUserInfo(_currentUser).then((value) {
      Toast.show("Save Complete", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    });

    print(_userInfoProvider.getCurrentUserInfo().name);
  }

  Widget buildNameTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name',
          style: TextStyle(
            color: Colors.white54,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Color(0xff4a6572),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: TextField(
            controller: _name,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(
                left: 14.0,
              ),
              hintText: _currentUser.name.toString(),
              hintStyle: TextStyle(
                color: Colors.white70,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildEmailTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email',
          style: TextStyle(
            color: Colors.white54,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Color(0xff4a6572),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: TextField(
            readOnly: true,
            controller: null,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(
                top: 14.0,
              ),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: _currentUser.email,
              hintStyle: TextStyle(
                color: Colors.white70,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildProfilePicture(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.width * 0.3,
          child: isUploadingPicture
              ? Center(child: CircularProgressIndicator())
              : CircleAvatar(
                  radius: 50.0,
                  backgroundImage: _currentUser.imageUrl != null
                      ? CachedNetworkImageProvider(_currentUser.imageUrl)
                      : AssetImage('assets/logos/default.png'),
                ),
        ),
        Positioned(
          right: 0.0,
          bottom: 0.0,
          child: Container(
            child: IconButton(
              icon: Icon(Icons.camera_alt),
              color: Colors.black87,
              onPressed: () {
                getImage();
              },
            ),
          ),
        ),
      ],
    );
  }

  Future getImage() async {
    PickedFile _pickedFile =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    File newImageFile = File(_pickedFile.path);
    if (newImageFile != null) {
      setState(() {
        //this.imageFileAvatar = newImageFile;
        isUploadingPicture = true;
      });
    }
    uploadImageToFirestoreAndStorage(newImageFile);
  }

  void uploadImageToFirestoreAndStorage(File newImageFile) {
    String fileName = "${_currentUser.uid}_${DateTime.now()}";
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('${_currentUser.uid}/profile/${fileName}');
    StorageUploadTask storageUploadTask =
        storageReference.putFile(newImageFile);
    StorageTaskSnapshot storageTaskSnapshot;
    storageUploadTask.onComplete.then((value) {
      if (value.error == null) {
        storageTaskSnapshot = value;

        storageTaskSnapshot.ref.getDownloadURL().then((newImageDownloadUrl) {
          // update photourl of current user object
          _userInfoProvider.setNewProfileImage(newImageDownloadUrl);
          setState(() {
            _currentUser = _userInfoProvider.getCurrentUserInfo();
            isUploadingPicture = false;
          });
        }, onError: (errorMsg) {
          // fail to upload
          setState(() {
            isUploadingPicture = false;
          });
          Toast.show(errorMsg.toString(), context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          //Toast.showToast(msg: errorMsg.toString());
        });
      }
    });
  }
}
