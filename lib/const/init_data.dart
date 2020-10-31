import 'package:login_firebase/export.dart';

final UserModel currentUser = UserModel(
  name: 'aaaaa',
  imageUrl:
      'https://images.unsplash.com/photo-1503185912284-5271ff81b9a8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
);

final List<UserModel> onlineUsers = [
  UserModel(
    name: 'bbbbb',
    imageUrl:
        'https://images.unsplash.com/photo-1503001831666-8f3cf3a24544?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
    email: '111@111.com',
  ),
  UserModel(
    name: 'ccccc',
    imageUrl:
        'https://images.unsplash.com/photo-1525803023669-c53c5b290dd8?ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
  ),
  UserModel(
    name: 'ddddd',
    imageUrl:
        'https://images.unsplash.com/photo-1530645728336-ac5b9b630f1c?ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
  ),
  UserModel(
    name: 'eeeee',
    imageUrl:
        'https://images.unsplash.com/photo-1603775282359-6796b6c9e40b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=80',
  ),
  UserModel(
    name: 'fffff',
    imageUrl:
        'https://images.unsplash.com/photo-1603772655636-f4cc96a74ad9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ),
];

final List<Post> posts = [
  Post(
    userModel: currentUser,
    caption: 'Check out these cool puppers',
    timeAgo: '58m',
    imageUrl:
        'https://images.unsplash.com/photo-1603989112393-db862d0176b4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
    likes: 1202,
    comments: 184,
    shares: 96,
  ),
  Post(
    userModel: onlineUsers[4],
    caption: 'This is a very good boi.',
    timeAgo: '8hr',
    imageUrl:
        'https://images.unsplash.com/photo-1603279312618-5009a6caf08b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
    likes: 894,
    comments: 201,
    shares: 27,
  ),
  Post(
    userModel: onlineUsers[3],
    caption: 'Adventure 🏔',
    timeAgo: '15hr',
    imageUrl:
        'https://images.unsplash.com/photo-1603220485746-4395270d2aa4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
    likes: 722,
    comments: 183,
    shares: 42,
  ),
  Post(
    userModel: onlineUsers[0],
    caption:
        'More placeholder text for the soul: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    timeAgo: '1d',
    imageUrl: null,
    likes: 482,
    comments: 37,
    shares: 9,
  ),
  Post(
    userModel: onlineUsers[1],
    caption: 'A classic.',
    timeAgo: '1d',
    imageUrl:
        'https://images.unsplash.com/photo-1568607576135-cff32f62926a?ixlib=rb-1.2.1&auto=format&fit=crop&w=1427&q=80',
    likes: 1523,
    shares: 129,
    comments: 301,
  )
];
