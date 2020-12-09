import 'package:scoped_model/scoped_model.dart';

import 'course.dart';

class CoursesModel extends Model {
  List<Course> courses;

  CoursesModel() {
    courses = List();
  }

  void add(Course course) {
    courses.add(course);
    notifyListeners();
  }

  void set(List<Course> courses) {
    this.courses = courses;
    notifyListeners();
  }

  void remove(Course course) {
    courses.remove(course);
    notifyListeners();
  }
}
