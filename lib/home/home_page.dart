import 'package:app_inter_2/authentication/nodejs-authentication/node_js_authentication.dart';
import 'package:app_inter_2/authentication/authentication_response.dart';
import 'package:app_inter_2/authentication/authentication-interface/i_authentication.dart';
import 'package:app_inter_2/connector.dart';
import 'package:app_inter_2/courses/courses_page.dart';
import 'package:app_inter_2/home/widgets/image_name_container.dart';
import 'package:app_inter_2/localization/Demo.dart';
import 'package:app_inter_2/programs/program_list.dart';
import 'package:app_inter_2/util/shared_pref_manager.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:app_inter_2/authentication/user.dart';
import 'package:app_inter_2/authentications_pages/login_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HomePage extends StatefulWidget {
  final User user;

  const HomePage({Key key, this.user}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Connector connector = Connector();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final IAuthentication _authentication = NodeJsAuthentication();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  _initializeNotification() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            onDidReceiveLocalNotification:
                (int id, String title, String body, String payload) {});
    final MacOSInitializationSettings initializationSettingsMacOS =
        MacOSInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: initializationSettingsMacOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future selectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (context) => HomePage()),
    );
  }

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
  void initState() {
    super.initState();
    connector.connectToServer(() {});
    _initializeNotification();
    _firebaseMessaging.subscribeToTopic("any");
    _firebaseMessaging.subscribeToTopic("programs");
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        print('>>>>>>>>>>>>>under message');
        const AndroidNotificationDetails androidPlatformChannelSpecifics =
            AndroidNotificationDetails('your channel id', 'your channel name',
                'your channel description',
                importance: Importance.max,
                priority: Priority.high,
                showWhen: false);
        var notifi = message['notification'];
        String title = notifi['title'];
        String body = notifi['body'];
        print(title);
        print(body);
        const NotificationDetails platformChannelSpecifics =
            NotificationDetails(android: androidPlatformChannelSpecifics);
        await flutterLocalNotificationsPlugin
            .show(0, title, body, platformChannelSpecifics, payload: 'item x');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        //_homeScreenText = "Push Messaging token: $token";
      });
      //(_homeScreenText);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _loading,
      color: Colors.black.withOpacity(.5),
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                right: 0,
                left: 0,
                top: 0,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image(
                        height: MediaQuery.of(context).size.height * .4,
                        image: AssetImage(
                          'assets/home_back_2.png',
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      top: 32,
                      right: 32,
                      child: Text(
                        'Programming \n path',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageNameContainer(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    CoursesPage(user: widget.user)));
                          },
                          imageUrl: "assets/courses_2.png",
                          name: DemoLocalizations.of(context)
                              .translate('our_programs'))
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
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
