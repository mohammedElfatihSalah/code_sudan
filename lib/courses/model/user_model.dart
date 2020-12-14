import 'package:app_inter_2/authentication/user.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  User user;
  UserModel({this.user});

  void enroll(String courseId) {
    user.enrolledCourses.add(courseId);
    notifyListeners();
  }

  void completedResource(String courseId, String resourceName) {
    print(resourceName);
    if (user.completedResources[courseId] == null)
      user.completedResources[courseId] = [];
    user.completedResources[courseId].add(resourceName);
    notifyListeners();
  }

  void removeResource(String courseId, String resourceName) {
    user.completedResources[courseId].remove(resourceName);
    notifyListeners();
  }
}
