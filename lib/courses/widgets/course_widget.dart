import 'package:app_inter_2/courses/nodejs-repo/nodejs_repository.dart';
import 'package:app_inter_2/courses/parse-sdk-course-repo/course_repo_impl.dart';
import 'package:app_inter_2/courses/repo-interface/i_courses_repo.dart';
import 'package:app_inter_2/courses/model/user_model.dart';
import 'package:app_inter_2/courses/topics_page.dart';
import 'package:app_inter_2/courses/model/course.dart';
import 'package:app_inter_2/localization/Demo.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CourseWidget extends StatelessWidget {
  final Course course;
  final UserModel model;

  _enroll() {
    //if user enrolled
    //go to course page directly
    //else prompt the user to enroll
  }

  CourseWidget({Key key, this.course, this.model}) : super(key: key);
  final ICoursesRepo repo = NodeJsCourseRepository();
  @override
  Widget build(BuildContext context) {
    bool enrolled = model.user.enrolled(course.id);
    double progress = 0.0;

    if (enrolled) {
      //change
      if (model.user.completedResources[course.id] != null) {
        int resourcesMinutes = course
            .getResourcesMinutes(model.user.completedResources[course.id]);
        int totalMinutesToCompleteTheCourse =
            course.getTotalMinutesToCompleteCourse();
        print('TotalMinutes');
        print(totalMinutesToCompleteTheCourse);

        progress = resourcesMinutes / totalMinutesToCompleteTheCourse;
      }

      //end

    }

    Widget progressWidget = enrolled
        ? Expanded(
            child: LinearPercentIndicator(
              lineHeight: 20.0,
              percent: progress,
              backgroundColor: Colors.grey,
              progressColor: Colors.blue,
              center: Text(
                (100 * progress).toStringAsFixed(1) + '%',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          )
        : Container();

    return Container(
      width: MediaQuery.of(context).size.width * .75,
      height: 185,
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 10,
                offset: Offset(8, 8))
          ]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(course.imageUrl),
              radius: 30,
            ),
            SizedBox(
              width: 16,
            ),
            Text(
              course.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        progressWidget,
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: RaisedButton(
                textColor: Colors.white,
                onPressed: () {
                  if (!enrolled) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(DemoLocalizations.of(context)
                                .translate('enroll')),
                            content: Text('Are you sure u want to enroll'),
                            actions: [
                              FlatButton(
                                child: Text(DemoLocalizations.of(context)
                                    .translate('yes')),
                                onPressed: () async {
                                  enrolled = await repo.enroll(model, course);
                                  Navigator.of(context).pop();
                                },
                              ),
                              FlatButton(
                                child: Text(DemoLocalizations.of(context)
                                    .translate('no')),
                                onPressed: () {},
                              ),
                            ],
                          );
                        });
                    return;
                  }
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TopicsPage(
                            course: course,
                            model: model,
                          )));
                },
                child: enrolled
                    ? Text(DemoLocalizations.of(context).translate('resume'))
                    : Text(DemoLocalizations.of(context).translate('enroll')),
                color: enrolled ? Colors.grey : Colors.blue,
              ),
            ),
          ],
        )
      ]),
    );
  }
}
