import 'package:scoped_model/scoped_model.dart';
import 'post.dart';

class PostList extends Model {
  List<Post> _posts;

  PostList() {
    _posts = List<Post>();
  }

  Post get(int index) => _posts[index];

  void add(Post post) {
    _posts.add(post);
    notifyListeners();
  }

  void addAll(List<Post> posts) {
    _posts.addAll(posts);
  }

  void remove(Post post) {
    _posts.remove(post);
    notifyListeners();
  }

  bool isEmpty() {
    return _posts.length == 0;
  }

  int getLength() => _posts.length ?? 0;
}
