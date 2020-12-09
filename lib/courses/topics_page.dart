import 'package:app_inter_2/courses/course_repo_impl.dart';
import 'package:app_inter_2/courses/i_courses_repo.dart';
import 'package:app_inter_2/courses/model/course.dart';
import 'package:app_inter_2/courses/model/resource.dart';
import 'package:app_inter_2/courses/model/topic.dart';
import 'package:app_inter_2/courses/model/user_model.dart';
import 'package:app_inter_2/courses/play_video_page.dart';
import 'package:app_inter_2/localization/Demo.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TopicsPage extends StatefulWidget {
  final Course course;
  final UserModel model;

  const TopicsPage({Key key, this.course, this.model}) : super(key: key);
  @override
  _TopicsPageState createState() => _TopicsPageState();
}

class _TopicsPageState extends State<TopicsPage> {
  bool _loading = false;
  bool _isProgressChanged = false;
  List<Topic> topics = List();
  final ICoursesRepo repo = CourseRepoImpl();

  Map<String, bool> resourceValue = Map();

  @override
  void initState() {
    super.initState();
    topics = widget.course.topics;
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _loading,
      color: Colors.black.withOpacity(0.5),
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
            title: Text(DemoLocalizations.of(context).translate('topics'))),
        body: Stack(
          alignment: Alignment.center,
          children: [
            ListView.builder(
              itemCount: topics.length,
              itemBuilder: (BuildContext context, int index) {
                List<Widget> widgets = List();

                widgets.add(Text(
                  topics[index].name,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ));

                for (int i = 0; i < topics[index].resources.length; i++) {
                  Resource e = topics[index].resources[i];

                  bool isLast = i == topics[index].resources.length - 1;
                  Widget resourceWidget = Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            onTap: () {
                              String link = e.url;
                              String videoId =
                                  YoutubePlayer.convertUrlToId(link);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PlayVideoPage(
                                        videoId: videoId,
                                        resource: e,
                                      )));
                            },
                            trailing: CircleCheckBox(
                              value: widget.model.user
                                  .completedResource(widget.course.id, e.name),
                              onPressed: (val) {
                                if (resourceValue.containsKey(e.name)) {
                                  resourceValue.remove(e.name);
                                } else {
                                  resourceValue[e.name] = val;
                                }

                                if (val) {
                                  widget.model.completedResource(
                                      widget.course.id, e.name);
                                } else {
                                  widget.model
                                      .removeResource(widget.course.id, e.name);
                                }

                                setState(() {
                                  _isProgressChanged = resourceValue.length > 0;
                                });

                                print(resourceValue.entries);
                              },
                            ),
                            leading: Icon(Icons.movie),
                            title: Text(
                              e.name,
                              style: TextStyle(fontSize: 20),
                            ),
                            subtitle: Text('minutes' +
                                ' ' +
                                e.minutesToComplete.toString()),
                          ),
                          Divider(
                            color: isLast ? Colors.white : Colors.black,
                          )
                        ],
                      ));

                  widgets.add(resourceWidget);
                }
                //widgets.addAll(reso);

                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            offset: Offset(0, 0),
                            blurRadius: 0)
                      ]),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widgets),
                );
              },
            ),
            Visibility(
              visible: _isProgressChanged,
              child: Positioned(
                bottom: 0,
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.blue.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  onPressed: () async {
                    setState(() {
                      _loading = true;
                    });
                    bool success =
                        await repo.saveProgress(widget.model, widget.course);
                    setState(() {
                      _loading = false;
                    });

                    if (!success) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text('Error saving progress try again'),
                              actions: [
                                FlatButton(
                                  child: Text('Ok'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          });
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(
                      DemoLocalizations.of(context).translate('save_progress'),
                      style: TextStyle(fontSize: 25)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CircleCheckBox extends StatefulWidget {
  final Function onPressed;
  bool value;

  CircleCheckBox({Key key, this.onPressed, this.value = false})
      : super(key: key);

  @override
  _CircleCheckBoxState createState() => _CircleCheckBoxState();
}

class _CircleCheckBoxState extends State<CircleCheckBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.value = !widget.value;
          widget.onPressed(widget.value);
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: widget.value ? 50 : 30,
        width: 40,
        curve: Curves.bounceInOut,
        child: Icon(
          Icons.check,
          color: Colors.white,
        ),
        decoration: BoxDecoration(
            color: widget.value ? Colors.green : Colors.white,
            shape: BoxShape.circle,
            border:
                Border.all(color: widget.value ? Colors.white : Colors.black)),
      ),
    );
  }
}
