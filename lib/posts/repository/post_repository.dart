import 'dart:convert';
import '../model/post.dart';
import 'i_post_repository.dart';
import 'package:http/http.dart' as http;
import 'package:app_inter_2/server_info.dart';

class PostRepository extends IPostRepository {
  @override
  Future<Post> createPost(Post post) async {
    http.Response response = await http.post(
        ServerInfo.SERVER_URL + "/" + ServerInfo.CREATE_POST,
        body: {"title": post.name, "description": post.des, "time": post.time});

    if (response != null) {
      var bodyJson = json.decode(response.body);
      bool isSuccess = bodyJson['success'];

      if (isSuccess) {
        String id = bodyJson['post']['_id'];
        String title = bodyJson['post']['title'];
        String des = bodyJson['post']['description'];
        String time = bodyJson['post']['time'];
        return Post(id: id, name: title, des: des, time: time);
      }
      return null;
    } else {
      return null;
    }
  }

  @override
  Future<List<Post>> getAllPosts() async {
    http.Response response =
        await http.get(ServerInfo.SERVER_URL + '/' + ServerInfo.GET_POSTS);
    if (response != null) {
      var bodyJson = json.decode(response.body);
      var postsJson = bodyJson['posts'];
      //print(postsJson);
      List<Post> posts = [];
      for (var postJson in postsJson) {
        String id = postJson['_id'];
        String title = postJson['title'];
        String des = postJson['description'];

        String time = postJson['time'];
        Post post = Post(time: time, name: title, des: des, id: id);
        posts.add(post);
        //print(title);
      }

      return posts;
    } else {
      return [];
    }
  }

  @override
  Future<bool> deletePost(Post post) async {
    String id = post.id;
    http.Response response = await http.delete(
      ServerInfo.SERVER_URL + "/" + ServerInfo.CREATE_POST + '/' + id,
    );
    bool isSuccess = json.decode(response.body)['success'] ?? false;

    return isSuccess;
  }

  @override
  Future<List<Post>> getNewPosts(Post lastPost) async {
    print(ServerInfo.SERVER_URL + '/' + ServerInfo.GET_NEW_POSTS);
    print(lastPost);
    http.Response response = await http.post(
      ServerInfo.SERVER_URL + '/' + ServerInfo.GET_NEW_POSTS,
      body: {
        "time": lastPost.time,
      },
    );
    if (response != null) {
      var bodyJson = json.decode(response.body);
      var postsJson = bodyJson['posts'];
      //print(postsJson);
      List<Post> posts = [];
      for (var postJson in postsJson) {
        String id = postJson['_id'];
        String title = postJson['title'];
        String des = postJson['description'];
        String time = postJson['time'];

        Post post = Post(time: time, name: title, des: des, id: id);
        posts.add(post);
        //print(title);
      }

      return posts;
    } else {
      return [];
    }
  }
}
