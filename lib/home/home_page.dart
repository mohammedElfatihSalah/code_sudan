import 'package:app_inter_2/authentication/authentication.dart';
import 'package:app_inter_2/authentication/authentication_response.dart';
import 'package:app_inter_2/authentication/i_authentication.dart';
import 'package:app_inter_2/courses/courses_page.dart';
import 'package:app_inter_2/home/widgets/image_name_container.dart';
import 'package:app_inter_2/localization/Demo.dart';
import 'package:app_inter_2/programs/program_list.dart';
import 'package:app_inter_2/util/shared_pref_manager.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:app_inter_2/authentication/user.dart';
import 'package:app_inter_2/authentications_pages/login_page.dart';

class HomePage extends StatefulWidget {
  final User user;

  const HomePage({Key key, this.user}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final IAuthentication _authentication = ParseSdkAuthenticationImpl();
  bool _loading = false;

  _logout() async {
    setState(() {
      _loading = true;
    });

    SharedPrefManager manager = await SharedPrefManager.getInstance();
    User user = manager.getUser();
    AuthenticationResponse response = await _authentication.logout(user);

    setState(() {
      _loading = false;
    });
    if (response.isSuccess) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(response.errorMessage),
              actions: [
                FlatButton(
                  child: Text('ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.user.enrolledCourses);
    return LoadingOverlay(
      isLoading: _loading,
      color: Colors.black.withOpacity(.5),
      child: Scaffold(
        appBar: AppBar(
          title: Text(DemoLocalizations.of(context).translate('home')),
          actions: [
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text(DemoLocalizations.of(context)
                              .translate('are_u_sure_to_logout')),
                          actions: [
                            FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  _logout();
                                },
                                child: Text(DemoLocalizations.of(context)
                                    .translate('yes'))),
                            FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                    DemoLocalizations.of(context)
                                        .translate('no'),
                                    style: TextStyle(color: Colors.red))),
                          ],
                        );
                      });
                })
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageNameContainer(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              CoursesPage(user: widget.user)));
                    },
                    imageUrl: "assets/programming_program.jpg",
                    name:
                        DemoLocalizations.of(context).translate('our_programs'))
              ],
            ),
            SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageNameContainer(
                    imageUrl: 'assets/who_we_Are.png',
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProgramListPage()));
                    },
                    name: DemoLocalizations.of(context)
                        .translate('register_for_our_courses'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
