import 'package:flutter/material.dart';
import 'package:pdam/model/post.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  const PostWidget({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("${post.title}"),
      leading: Text(
        "${post.id}",
        style: TextStyle(fontSize: 10.0),
      ),
      isThreeLine: true,
      subtitle: Text("${post.body}"),
      dense: true,
    );
  }
}
