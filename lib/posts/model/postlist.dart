import 'package:app_inter_2/posts/repository/i_post_repository.dart';
import 'package:app_inter_2/posts/repository/post_repository.dart';
import 'package:scoped_model/scoped_model.dart';
import 'post.dart';

class PostList extends Model {
  List<Post> _posts;
  IPostRepository postRepository;
  String state;
  PostList() {
    _posts = [];
    postRepository = PostRepository();
    state = 'init';
    _initialize();
  }

  Post get(int index) => _posts[index];

  bool isEmpty() {
    return _posts.length == 0;
  }

  int getLength() => _posts.length ?? 0;

  String getState() => state;

  refresh() async {
    state = 'refreshing';
    Post lastPost = _posts[0];
    List<Post> newPosts = await postRepository.getNewPosts(lastPost);
    state = 'complete';
    _posts.addAll(newPosts);
    //sort from big time to small time
    _posts.sort((a, b) => b.time.compareTo(a.time));
    notifyListeners();
  }

  _initialize() async {
    _posts = await postRepository.getAllPosts() ?? [];
    state = 'complete';
    notifyListeners();
  }
}
