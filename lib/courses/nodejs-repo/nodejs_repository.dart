import 'dart:convert';

import 'package:app_inter_2/courses/model/user_model.dart';
import 'package:app_inter_2/courses/model/topic.dart';
import 'package:app_inter_2/courses/model/resource.dart';
import 'package:app_inter_2/courses/model/course.dart';
import 'package:app_inter_2/courses/repo-interface/i_courses_repo.dart';
import 'package:http/http.dart' as http;

class NodeJsCourseRepository extends ICoursesRepo {
  static const String BASE_URL = 'http:' + '//' + '192.168.43.84:5000';
  @override
  Future<bool> enroll(UserModel model, Course course) async {
    String userId = model.user.id;

    print(BASE_URL + '/users/enroll' + '/' + userId);
    http.Response response = await http.post(
        BASE_URL + '/users/enroll' + '/' + userId,
        body: {'courseId': course.id});

    if (response != null) {
      String body = response.body;
      print(response.body);
      var jsonBody = json.decode(body);
      if (jsonBody['success']) {
        model.enroll(course.id);

        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Future<List<Course>> getAllCourses() async {
    http.Response response = await http.get(BASE_URL + '/courses');

    if (response != null) {
      String body = response.body;
      var jsonBody = json.decode(body);

      bool isSuccess = jsonBody['success'];

      if (isSuccess) {
        List<Course> courses = [];
        var coursesJson = jsonBody['courses'];
        for (var courseJson in coursesJson) {
          Course course = Course.instanceNode(courseJson);
          courses.add(course);
        }
        return courses;
      } else {
        return [];
      }
    } else {
      return [];
    }
    return [];
  }

  @override
  Future<List<Resource>> getResources(String topicId) {
    // TODO: implement getResources
    throw UnimplementedError();
  }

  @override
  Future<List<Topic>> getTopics(String courseId) {
    // TODO: implement getTopics
    throw UnimplementedError();
  }

  @override
  Future<bool> saveProgress(UserModel model, Course course) async {
    return true;
  }
}
