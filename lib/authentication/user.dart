import 'dart:convert';

import 'package:parse_server_sdk/parse_server_sdk.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String password;

  final List<String> enrolledCourses;
  final Map<String, List<String>> completedResources;

  User(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.enrolledCourses,
      this.completedResources});

  bool enrolled(String courseId) {
    return enrolledCourses.contains(courseId);
  }

  bool completedResource(String courseId, String resourceName) {
    if (completedResources[courseId] == null) return false;
    if (completedResources[courseId].isEmpty) return false;

    return completedResources[courseId].contains(resourceName);
  }

  static User instance(ParseUser user) {
    String name = user.username;
    String email = user.emailAddress;

    List<String> enrolledCourses = List();

    user.get('enrolledCourses', defaultValue: List()).forEach((element) {
      enrolledCourses.add(element);
    });
    String resources = user.get('completedResources', defaultValue: '{}');

    Map<String, dynamic> completedResourcesd = json.decode(resources);
    Map<String, List<String>> completedResources = Map();
    completedResourcesd.forEach((key, value) {
      List<String> resources = List();
      value.forEach((element) {
        resources.add(element);
      });

      completedResources[key] = resources;
    });

    return User(
        name: name,
        email: email,
        completedResources: completedResources,
        enrolledCourses: enrolledCourses);
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
