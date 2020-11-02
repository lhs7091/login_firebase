import 'package:login_firebase/export.dart';

class UserModel {
  String uid;
  String name;
  String imageUrl;
  String email;

  UserModel({
    this.uid,
    this.name,
    this.imageUrl,
    this.email,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json[UID_FIELD];
    name = json[NAME_FIELD];
    imageUrl = json[IMAGEURL_FIELD];
    email = json[EMAIL_FIELD];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[UID_FIELD] = this.uid;
    data[NAME_FIELD] = this.name;
    data[IMAGEURL_FIELD] = this.imageUrl;
    data[EMAIL_FIELD] = this.email;
    return data;
  }

  UserModel.fromMap(Map<String, dynamic> map) {
    this.uid = map[UID_FIELD];
    this.name = map[NAME_FIELD];
    this.imageUrl = map[IMAGEURL_FIELD];
    this.email = map[EMAIL_FIELD];
  }

  Map toMap(UserModel userModel) {
    var data = Map<String, dynamic>();
    data[UID_FIELD] = userModel.uid;
    data[NAME_FIELD] = userModel.name;
    data[IMAGEURL_FIELD] = userModel.imageUrl;
    data[EMAIL_FIELD] = userModel.email;
    return data;
  }

  void setUid(String uid) {
    this.uid = uid;
  }

  void setName(String name) {
    this.name = name;
  }

  void setImageUrl(String imageUrl) {
    this.imageUrl = imageUrl;
  }

  void setEmail(String email) {
    this.email = email;
  }
}
