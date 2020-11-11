import 'package:login_firebase/export.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  UserModel userModel;
  String uid;
  String caption;
  String imageUrl;
  String content;
  int likes;
  int comments;
  int shares;
  Timestamp timestamp;

  Post({
    this.userModel,
    this.uid,
    this.caption,
    this.imageUrl,
    this.content,
    this.likes,
    this.comments,
    this.shares,
    this.timestamp,
  });

  Post.fromJson(Map<String, dynamic> json) {
    //userModel = json['userModel'];
    uid = json['uid'];
    caption = json['caption'];
    imageUrl = json['imageUrl'];
    content = json['content'];
    likes = json['likes'];
    comments = json['comments'];
    shares = json['shares'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //data['userModel'] = this.userModel;
    data['uid'] = this.uid;
    data['caption'] = this.caption;
    data['imageUrl'] = this.imageUrl;
    data['content'] = this.content;
    data['likes'] = this.likes;
    data['comments'] = this.comments;
    data['shares'] = this.shares;
    data['timestamp'] = this.timestamp;

    return data;
  }

  Post.fromMap(Map<String, dynamic> map) {
    //this.userModel = map['userModel'];
    this.uid = map['uid'];
    this.caption = map['caption'];
    this.imageUrl = map['imageUrl'];
    this.content = map['content'];
    this.likes = map['likes'];
    this.comments = map['comments'];
    this.shares = map['shares'];
    this.timestamp = map['timestamp'];
  }

  Map toMap(Post post) {
    var data = Map<String, dynamic>();
    //data[USERMODEL_FIELD] = post.userModel.toMap(post.userModel);
    data[UID_FIELD] = post.uid;
    data[CAPTION_FIELD] = post.caption;
    data[IMAGEURL_FIELD] = post.imageUrl;
    data[CONTENT_FIELD] = post.content;
    data[LIKES_FIELD] = post.likes;
    data[COMMENTS_FIELD] = post.comments;
    data[SHARES_FIELD] = post.shares;
    data[TIMESTAMP_FIELD] = post.timestamp;
    return data;
  }

  setImageUrl(String imageUrl) {
    this.imageUrl = imageUrl;
  }

  setUserModel(UserModel userModel) {
    this.userModel = userModel;
  }

  setUid(String uid) {
    this.uid = uid;
  }

  setCaption(String caption) {
    this.caption = caption;
  }

  setContent(String content) {
    this.content = content;
  }

  setTimeStamp(Timestamp timestamp) {
    this.timestamp = timestamp;
  }

  void setLikes(int likes) {
    this.likes = likes;
  }

  void setComments(int comments) {
    this.comments = comments;
  }

  void setShares(int shares) {
    this.shares = shares;
  }
}
