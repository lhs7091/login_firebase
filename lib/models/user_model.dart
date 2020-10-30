import 'package:meta/meta.dart';

class UserInfo {
  final String name;
  final String imageUrl;
  final String email;

  const UserInfo({
    @required this.name,
    @required this.imageUrl,
    this.email,
  });
}
