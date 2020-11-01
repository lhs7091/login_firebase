import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/export.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PostContainer extends StatelessWidget {
  final Post post;
  const PostContainer({
    Key key,
    @required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 5.0,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        color: Colors.white,
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
                          ? CachedNetworkImageProvider(post.userModel.imageUrl)
                          : AssetImage('assets/logos/default.png'),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.userModel.name,
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          '${DateTime.fromMillisecondsSinceEpoch(post.timestamp.millisecondsSinceEpoch).toString().replaceRange(19, 23, "")}',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
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
            post.imageUrl != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CachedNetworkImage(
                      imageUrl: post.imageUrl,
                    ),
                  )
                : const SizedBox.shrink(),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Colors.blue[200],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.thumb_up,
                    size: 10.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 5.0),
                Expanded(
                  child: Text(
                    '${post.likes}',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                Text(
                  '${post.comments} Comments',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(
                  '${post.shares} Shares',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
            const Divider(
              height: 10.0,
              thickness: 0.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    FlatButton(
                      onPressed: () => print('Like'),
                      child: Icon(
                        MdiIcons.thumbUpOutline,
                        color: Colors.grey[600],
                        size: 25.0,
                      ),
                    ),
                    Text('Like'),
                  ],
                ),
                Column(
                  children: [
                    FlatButton(
                      onPressed: () => print('Comments'),
                      child: Icon(
                        MdiIcons.commentOutline,
                        color: Colors.grey[600],
                        size: 25.0,
                      ),
                    ),
                    Text('Comments'),
                  ],
                ),
                Column(
                  children: [
                    FlatButton(
                      onPressed: () => print('Share'),
                      child: Icon(
                        MdiIcons.shareOutline,
                        color: Colors.grey[600],
                        size: 25.0,
                      ),
                    ),
                    Text('Share'),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
