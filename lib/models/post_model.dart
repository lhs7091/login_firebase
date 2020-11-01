import 'package:login_firebase/export.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  UserModel userModel;
  String caption;
  String imageUrl;
  int likes;
  int comments;
  int shares;
  Timestamp timestamp;

  Post({
    this.userModel,
    this.caption,
    this.imageUrl,
    this.likes,
    this.comments,
    this.shares,
    this.timestamp,
  });

  Post.fromJson(Map<String, dynamic> json) {
    userModel = json['userModel'];
    caption = json['caption'];
    imageUrl = json['imageUrl'];
    likes = json['likes'];
    comments = json['comments'];
    shares = json['shares'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userModel'] = this.userModel;
    data['caption'] = this.caption;
    data['imageUrl'] = this.imageUrl;
    data['likes'] = this.likes;
    data['comments'] = this.comments;
    data['shares'] = this.shares;
    data['timestamp'] = this.timestamp;

    return data;
  }

  Post.fromMap(Map<String, dynamic> map) {
    this.userModel = map['userModel'];
    this.caption = map['caption'];
    this.imageUrl = map['imageUrl'];
    this.likes = map['likes'];
    this.comments = map['comments'];
    this.shares = map['shares'];
    this.timestamp = map['timestamp'];
  }
}
