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
    uid = json['uid'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    data['email'] = this.email;
    return data;
  }

  UserModel.fromMap(Map<String, dynamic> map) {
    this.uid = map['uid'];
    this.name = map['name'];
    this.imageUrl = map['imageUrl'];
    this.email = map['email'];
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
