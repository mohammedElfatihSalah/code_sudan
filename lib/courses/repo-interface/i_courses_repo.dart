import 'package:app_inter_2/authentication/user.dart';
import 'package:app_inter_2/courses/model/course.dart';
import 'package:app_inter_2/courses/model/resource.dart';
import 'package:app_inter_2/courses/model/topic.dart';

import '../model/user_model.dart';

abstract class ICoursesRepo {
  Future<List<Course>> getAllCourses();
  Future<List<Topic>> getTopics(String courseId);
  Future<List<Resource>> getResources(String topicId);

  Future<bool> enroll(UserModel model, Course course);

  Future<bool> saveProgress(UserModel model, Course course);
}
