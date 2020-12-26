import 'package:app_inter_2/authentication/nodejs-authentication/node_js_authentication.dart';
import 'package:app_inter_2/authentication/authentication_response.dart';
import 'package:app_inter_2/authentication/authentication-interface/i_authentication.dart';
import 'package:app_inter_2/authentication/user.dart';
import 'package:app_inter_2/authentications_pages/widgets/eye_invisibility.dart';
import 'package:app_inter_2/localization/Demo.dart';
import 'package:app_inter_2/my_app.dart';
import 'package:app_inter_2/authentications_pages/register_page.dart';
import 'package:app_inter_2/util/user_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:app_inter_2/home/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //TO DO move them all to initState
  Locale locale;
  bool _loading = false;
  final _key = GlobalKey<FormState>();
  String _password;
  bool _obsecure = true;
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  IAuthentication authentication = NodeJsAuthentication();

  //handling both ui and business logic
  _login() async {
    if (!_key.currentState.validate()) return;

    setState(() {
      _loading = true;
    });

    User user = User(
        name: _userNameController.text, password: _passwordController.text);

    AuthenticationResponse response = await authentication.login(user);

    setState(() {
      _loading = false;
    });
    if (response.isSuccess) {
      User user = await authentication.currentUser();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomePage(
            user: user,
          ),
        ),
      );
    } else {
      _showDialog(response.errorMessage);
    }
  }

  _showDialog(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(DemoLocalizations.of(context).translate('error')),
              content: Text(message),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(DemoLocalizations.of(context).translate('ok')))
              ],
            ));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    return LoadingOverlay(
      isLoading: _loading,
      color: Colors.black.withOpacity(.5),
      child: Scaffold(
        /*  appBar: AppBar(
          title: Text(DemoLocalizations.of(context).translate('login_page')),
          actions: <Widget>[
           
          ],
        ),*/
        body: SingleChildScrollView(
          child: Column(
            children: [
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  height: _screenHeight * 0.35,
                  // width: 500,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        width: 40,
                      ),
                      Image.asset('assets/logo.png'),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DropdownButton(
                              icon: Icon(
                                Icons.language,
                                color: Colors.white,
                                // size: 30,
                              ),
                              items: ['English', 'Arabic'].map((String value) {
                                return DropdownMenuItem(
                                  child: Text(value),
                                  value: value,
                                );
                              }).toList(),
                              onChanged: (value) {
                                switch (value) {
                                  case 'English':
                                    locale = Locale('en', 'US');
                                    break;
                                  case 'Arabic':
                                    locale = Locale('ar', 'SA');
                                    break;
                                }

                                MyApp.setLocale(context, locale);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Form(
                key: _key,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        DemoLocalizations.of(context).translate('login_page'),
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _userNameController,
                        validator: (value) =>
                            UserValidator.validateUserNameWithTranslation(
                                context, value),
                        decoration: InputDecoration(
                            // border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email),
                            hintText: DemoLocalizations.of(context)
                                .translate('user_name')),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        obscureText: _obsecure,
                        controller: _passwordController,
                        validator: (value) =>
                            UserValidator.validateUserPasswordWithTranslation(
                                context, value),
                        decoration: InputDecoration(
                            // border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: _obsecure
                                  ? EyeInvisibility()
                                  : Icon(Icons.remove_red_eye),
                              onPressed: () {
                                setState(() {
                                  _obsecure = !_obsecure;
                                });
                              },
                            ),
                            hintText: DemoLocalizations.of(context)
                                .translate('enter_password')),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            onPressed: () {
                              _login();
                            },
                            child: Text(
                              DemoLocalizations.of(context).translate('login'),
                              style: TextStyle(fontSize: 20),
                            ),
                            // color: Colors.blue,
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            DemoLocalizations.of(context)
                                .translate('no_account'),
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Container(
                            color: Colors.black,
                            child: SizedBox(
                              height: 20,
                              width: 2,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage()));
                            },
                            child: Text(
                              DemoLocalizations.of(context)
                                  .translate('create_one'),
                              style:
                                  TextStyle(fontSize: 20, color: Colors.blue),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, size.height - 70);
    var control = Offset(50, size.height);
    var endPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(control.dx, control.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
