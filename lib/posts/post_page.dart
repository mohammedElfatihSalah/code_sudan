import 'package:app_inter_2/posts/model/postlist.dart';
import 'package:app_inter_2/posts/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'model/post.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  PostList postList;

  @override
  void initState() {
    super.initState();
    postList = PostList();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<PostList>(
      model: postList,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Posts',
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 5,
        ),
        body: ScopedModelDescendant<PostList>(
          builder: (context, widget, postList) {
            return RefreshIndicator(
              onRefresh: () async {
                await postList.refresh();
                print('ref');
                setState(() {});
              },
              child: ListView.builder(
                itemCount: postList.getLength(),
                itemBuilder: (BuildContext context, int index) {
                  return PostWidget(
                    post: postList.get(index),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
