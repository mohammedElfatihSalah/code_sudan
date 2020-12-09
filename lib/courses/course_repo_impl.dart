import 'dart:convert';

import 'package:app_inter_2/authentication/user.dart';
import 'package:app_inter_2/courses/i_courses_repo.dart';
import 'package:app_inter_2/courses/model/course.dart';
import 'package:app_inter_2/courses/model/resource.dart';
import 'package:app_inter_2/courses/model/topic.dart';
import 'package:app_inter_2/courses/model/user_model.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class CourseRepoImpl extends ICoursesRepo {
  @override
  Future<List<Course>> getAllCourses() async {
    // added a new feature
    ParseResponse response = await ParseObject('Course').getAll();
    List<Course> courses = List();
    if (response.success) {
      print(response.result);
      var jsonResults = jsonDecode(response.result.toString());
      courses = List<Course>.from(
          jsonResults.map((e) => Course.instance(e)).toList());
      return courses;
    }

    return null;
  }

  @override
  Future<List<Topic>> getTopics(String courseId) async {
    List<Topic> topics;

    ParseObject topicObject = ParseObject('Topic');

    var query = QueryBuilder<ParseObject>(topicObject)
      ..whereEqualTo('courseId', courseId);

    ParseResponse response = await query.query();

    if (response.success) {
      topics = List();
      var jsonResults = json.decode(response.result.toString());
      for (var jsonResult in jsonResults) {
        String name = jsonResult['name'];
        String des = jsonResult['description'];
        String id = jsonResult['objectId'];
        Topic topic = Topic(name: name, description: des, id: id);
        topics.add(topic);
      }

      return topics;
    } else {
      return null;
    }
  }

  @override
  Future<List<Resource>> getResources(String topicId) async {
    print('===================');
    print(topicId);
    List<Resource> resources;

    ParseObject resourceObject = ParseObject('Resource');

    var query = QueryBuilder<ParseObject>(resourceObject)
      ..whereEqualTo('topicId', topicId);

    ParseResponse response = await query.query();

    if (response.success) {
      resources = List();
      var jsonResults = json.decode(response.result.toString());
      for (var jsonResult in jsonResults) {
        String name = jsonResult['name'];
        String des = jsonResult['description'];
        String id = jsonResult['objectId'];
        String link = jsonResult['link'];
        String type = jsonResult['type'];
        Resource resource = Resource(
          name: name,
          description: des,
          id: id,
          type: type,
          url: link,
        );
        resources.add(resource);
      }

      return resources;
    } else {
      return null;
    }
  }

  @override
  Future<bool> enroll(UserModel model, Course course) async {
    String userId = model.user.id;

    ParseUser user = await ParseUser.currentUser()
      ..setAddUnique('enrolledCourses', course.id);

    ParseResponse response = await user.save();
    if (response.success) {
      model.enroll(course.id);
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> saveProgress(UserModel model, Course course) async {
    String courseId = course.id;
    User user = model.user;

    Map<String, List<String>> completedResources = user.completedResources;

    String encodeJson = json.encode(completedResources);

    print(encodeJson);

    ParseUser parseUser = await ParseUser.currentUser();

    parseUser..set('completedResources', encodeJson);

    ParseResponse response = await parseUser.save();

    return response.success;
  }
}
