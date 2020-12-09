import 'package:app_inter_2/courses/model/resource.dart';
import 'package:scoped_model/scoped_model.dart';

class ResourcesModel extends Model {
  List<Resource> resources;

  ResourcesModel() {
    resources = List();
  }

  void add(Resource resource) {
    resources.add(resource);
    notifyListeners();
  }

  void remove(Resource resource) {
    resources.remove(resource);
    notifyListeners();
  }
}
