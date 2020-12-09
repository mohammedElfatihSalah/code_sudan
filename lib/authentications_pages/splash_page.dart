import 'package:app_inter_2/authentication/user.dart';
import 'package:app_inter_2/authentications_pages/login_page.dart';
import 'file:///C:/Users/hp/AndroidStudioProjects/app_inter_2/lib/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void _init() async {
    ParseUser user = await ParseUser.currentUser();

    print(user);
    if (user != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomePage(
                user: User.instance(user),
              )));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: SpinKitCubeGrid(
          color: Colors.white,
          size: 50,
        ),
      ),
    );
  }
}
