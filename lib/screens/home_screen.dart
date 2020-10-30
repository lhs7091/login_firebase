import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/export.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          title: Text(
            'Board',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: false,
          floating: true,
          actions: [
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
              child: IconButton(
                icon: Icon(Icons.person_outline_sharp),
                color: Colors.black,
                onPressed: () {},
              ),
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
    );
  }
}

class PostContainer extends StatelessWidget {
  final Post post;
  const PostContainer({
    Key key,
    @required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20.0,
                  child: CircleAvatar(
                    radius: 20.0,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: post.imageUrl != null
                        ? CachedNetworkImageProvider(post.userInfo.imageUrl)
                        : AssetImage('assets/logos/default.png'),
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.userInfo.name,
                      ),
                      Row(
                        children: [
                          //profile avatar
                          const SizedBox(
                            width: 8.0,
                          ),
                          Row(
                            children: [
                              Text(
                                post.timeAgo,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_horiz),
                  onPressed: () {
                    print('more button');
                  },
                ),
              ],
            ),
          ),
          Text(post.caption),
          post.imageUrl != null
              ? const SizedBox.shrink()
              : const SizedBox(height: 6.0),
        ],
      ),
    );
  }
}
