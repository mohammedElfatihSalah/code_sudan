import 'package:app_inter_2/authentication/user.dart';
import 'package:app_inter_2/courses/nodejs-repo/nodejs_repository.dart';
import 'package:app_inter_2/courses/parse-sdk-course-repo/course_repo_impl.dart';
import 'package:app_inter_2/courses/repo-interface/i_courses_repo.dart';
import 'package:app_inter_2/courses/widgets/course_widget.dart';
import 'package:app_inter_2/courses/model/course.dart';
import 'package:app_inter_2/localization/Demo.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:scoped_model/scoped_model.dart';

import 'model/user_model.dart';

class CoursesPage extends StatefulWidget {
  final User user;

  const CoursesPage({Key key, this.user}) : super(key: key);
  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  bool _loading = true;
  List<Course> _courses = List();

  ICoursesRepo repo = NodeJsCourseRepository();

  _loadAllCourse() async {
    setState(() {
      _loading = true;
    });

    _courses = await repo.getAllCourses();
    print('finished');

    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadAllCourse();
  }

  @override
  Widget build(BuildContext context) {
    print(_courses);
    return LoadingOverlay(
      isLoading: _loading,
      color: Colors.black.withOpacity(0.5),
      child: ScopedModel<UserModel>(
        model: UserModel(user: widget.user),
        child: Scaffold(
            appBar: AppBar(
              title: Text(DemoLocalizations.of(context).translate('courses')),
            ),
            body: SafeArea(
              child: Center(
                child: ListView.builder(
                    itemCount: _courses.length,
                    itemBuilder: (context, index) =>
                        ScopedModelDescendant<UserModel>(
                          builder: (context, widget, model) => CourseWidget(
                              course: _courses[index], model: model),
                        )),
              ),
            )),
      ),
    );
  }
}
