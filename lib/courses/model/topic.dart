import 'package:app_inter_2/courses/model/resource.dart';

class Topic {
  final String id;
  final String courseId;
  final String name;
  final String description;
  final List<Resource> resources;
  final String weekId;
  final int minutesToComplete;

  Topic(
      {this.id,
      this.courseId,
      this.name,
      this.description,
      this.resources,
      this.weekId,
      this.minutesToComplete});

  static instance(Map topicJson) {
    String name = topicJson['name'];
    String descripton = topicJson['description'];

    print('>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<');
    List<Resource> resources = List<Resource>.from(
        topicJson['resources'].map((e) => Resource.instance(e)).toList());
    return Topic(
      name: name,
      description: descripton,
      resources: resources,
    );
  }
}
