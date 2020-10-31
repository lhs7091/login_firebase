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
