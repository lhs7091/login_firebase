import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_firebase/export.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class PostFormWidget extends StatefulWidget {
  @override
  _PostFormWidgetState createState() => _PostFormWidgetState();
}

class _PostFormWidgetState extends State<PostFormWidget> {
  UserInfoProvider _userInfoProvider;
  UserModel _currentUser;

  final FocusNode captionFocusNode = FocusNode();
  final FocusNode commentsFocusNode = FocusNode();

  final FirebaseRepository _firebaseRepository = FirebaseRepository();

  TextEditingController caption = TextEditingController();
  TextEditingController content = TextEditingController();

  bool isLoading = false;
  bool isUploadingPicture = false;

  Post post = Post();

  String postImage = null;

  @override
  Widget build(BuildContext context) {
    _userInfoProvider = Provider.of<UserInfoProvider>(context);
    _currentUser = _userInfoProvider.getCurrentUserInfo();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      color: Color(0xff344955),
      child: Column(
        children: [
          isLoading
              ? LinearProgressIndicator()
              : Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                color: Color(0xff4a6572),
                child: TextField(
                  controller: caption,
                  decoration: InputDecoration(
                    hintText: "Write a caption......",
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Colors.white54,
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  cursorColor: Colors.white,
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Container(
                height: MediaQuery.of(context).size.width * 0.2,
                width: MediaQuery.of(context).size.width * 0.2,
                child: AspectRatio(
                  aspectRatio: 487 / 451,
                  child: isUploadingPicture
                      ? Center(child: CircularProgressIndicator())
                      : Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                fit: BoxFit.fill,
                                alignment: FractionalOffset.topCenter,
                                image: postImage != null
                                    ? CachedNetworkImageProvider(postImage)
                                    : AssetImage('assets/logos/default.png'),
                              )),
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
                        ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              color: Color(0xff4a6572),
            ),
            child: TextField(
              controller: content,
              maxLines: null,
              decoration: InputDecoration(
                hintText: "Write a contents......",
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Colors.white54,
                ),
              ),
              style: TextStyle(
                color: Colors.white,
              ),
              cursorColor: Colors.white,
            ),
          ),
          Container(
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
                postSaveFunction();
                captionFocusNode.unfocus();
                commentsFocusNode.unfocus();
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
          ),
        ],
      ),
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
    uploadPostImageToFirestoreAndStorage(newImageFile);
  }

  postSaveFunction() {
    // save in DB
    post.setCaption(caption.text);
    post.setContent(content.text);
    post.setImageUrl(postImage);
    post.setUid(_currentUser.uid);
    post.setTimeStamp(Timestamp.now());
    post.setLikes(0);
    post.setComments(0);
    post.setShares(0);

    _firebaseRepository.addPost(post).then((value) {
      setState(() {
        caption.clear();
        content.clear();
        postImage = null;
      });
      Toast.show("Upload Complete", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }, onError: (errorMsg) {
      // fail to upload
      Toast.show(errorMsg.toString(), context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    });

    // refresh post list
  }

  uploadPostImageToFirestoreAndStorage(File newImageFile) {
    String fileName = "${_currentUser.uid}_${DateTime.now()}";
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('${_currentUser.uid}/post/${fileName}');
    StorageUploadTask storageUploadTask =
        storageReference.putFile(newImageFile);
    StorageTaskSnapshot storageTaskSnapshot;
    storageUploadTask.onComplete.then((value) {
      if (value.error == null) {
        storageTaskSnapshot = value;

        storageTaskSnapshot.ref.getDownloadURL().then((newImageDownloadUrl) {
          // update photourl of current user object
          post.setImageUrl(newImageDownloadUrl);
          setState(() {
            postImage = newImageDownloadUrl;
          });
          setState(() {
            isUploadingPicture = false;
          });
        }, onError: (errorMsg) {
          // fail to upload
          setState(() {
            isUploadingPicture = false;
          });
          Toast.show(errorMsg.toString(), context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        });
      }
    });
  }
}
