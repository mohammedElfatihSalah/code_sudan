import 'package:app_inter_2/courses/model/topic.dart';
import 'package:scoped_model/scoped_model.dart';

class TopicsModel extends Model {
  List<Topic> topics;

  TopicsModel() {
    topics = List();
  }

  void add(Topic topic) {
    topics.add(topic);
    notifyListeners();
  }

  void remove(Topic topic) {
    topics.remove(topic);
    notifyListeners();
  }
}
