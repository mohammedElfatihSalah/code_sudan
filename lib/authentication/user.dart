import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String token;

  final bool isLogged;

  List<String> enrolledCourses;
  Map<String, List<String>> completedResources;

  User(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.enrolledCourses,
      this.completedResources,
      this.token,
      this.isLogged}) {
    if (enrolledCourses == null) enrolledCourses = [];
    if (completedResources == null) completedResources = Map();
  }

  bool enrolled(String courseId) {
    return enrolledCourses.contains(courseId);
  }

  bool completedResource(String courseId, String resourceName) {
    if (completedResources[courseId] == null) return false;
    if (completedResources[courseId].isEmpty) return false;

    return completedResources[courseId].contains(resourceName);
  }

  String toString() {
    return name + ' ' + email + '\n';
  }
}
// courses: [
//            {
//              "id": "tsd_23w",
//              "name": "Flutter",
//
//             }
//          ]
