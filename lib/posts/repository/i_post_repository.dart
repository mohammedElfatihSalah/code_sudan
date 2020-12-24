import '../model/post.dart';

abstract class IPostRepository {
  Future<Post> createPost(Post post);
  Future<bool> deletePost(Post post);
  Future<List<Post>> getAllPosts();
}
