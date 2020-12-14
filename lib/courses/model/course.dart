import 'dart:convert';
import 'dart:io';

import 'package:app_inter_2/courses/model/topic.dart';

class Course {
  final String id;
  final String name;
  final String description;
  final File imageFile;
  final String imageUrl;
  final List<Topic> topics;

  int totalMinutes = -1;

  Course(
      {this.id,
      this.name,
      this.description,
      this.topics,
      this.imageFile,
      this.imageUrl});

  static Course instance(Map courseJson) {
    String id = courseJson['objectId'];
    String name = courseJson['name'];
    String des = courseJson['description'];
    String imageUrl = '';

    var imageObject = courseJson['image'];

    if (imageObject != null) {
      imageUrl = imageObject['url'];
    }

    List<Topic> topics = List<Topic>.from(
        courseJson['topics'].map((e) => Topic.instance(e)).toList());

    return Course(
        name: name,
        imageUrl: imageUrl,
        description: des,
        id: id,
        topics: topics);
  }

  static Course instanceNode(Map courseJson) {
        String id = courseJson['_id'];
    String name = courseJson['name'];
    String des = courseJson['description'];
    String imageUrl = '';

    var imageObject = courseJson['image'];

    if (imageObject != null) {
      imageUrl = imageObject['url'];
    }

    List<Topic> topics = List<Topic>.from(
        courseJson['topics'].map((e) => Topic.instance(e)).toList());

    return Course(
        name: name,
        imageUrl: imageUrl,
        description: des,
        id: id,
        topics: topics);
  }

  int getResourcesMinutes(List<String> resourcesName) {
    int sum = 0;

    topics.forEach((topic) {
      topic.resources.forEach((resource) {
        if (resourcesName.contains(resource.name)) {
          sum += resource.minutesToComplete;
        }
      });
    });

    return sum;
  }

  int getTotalMinutesToCompleteCourse() {
    if (totalMinutes != -1) return totalMinutes;

    int sum = 0;
    topics.forEach((topic) {
      topic.resources.forEach((resource) {
        sum += resource.minutesToComplete;
      });
    });

    totalMinutes = sum;
    return totalMinutes;
  }

  String toString() {
    String result = 'course name: ' +
        name +
        '\n' +
        'course description: ' +
        description +
        "\n" +
        'course id: ' +
        id +
        '\n' +
        'imagerl: ' +
        imageUrl;

    String topicsId = '';

    for (var topic in topics) {
      topicsId += ' ${topic.id}';
    }

    return result + '\n' + topicsId;
  }
}
