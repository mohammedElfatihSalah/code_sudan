import 'package:app_inter_2/authentication/nodejs-authentication/node_js_authentication.dart';
import 'package:app_inter_2/authentication/authentication_response.dart';
import 'package:app_inter_2/authentication/authentication-interface/i_authentication.dart';
import 'package:app_inter_2/authentication/user.dart';
import 'package:app_inter_2/authentications_pages/widgets/eye_invisibility.dart';
import 'package:app_inter_2/localization/Demo.dart';
import 'package:app_inter_2/authentications_pages/login_page.dart';
import 'package:app_inter_2/my_app.dart';
import 'package:app_inter_2/util/user_validator.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Locale locale;

  bool _obscure = true;
  bool _loading = false;
  String _password;

  final _key = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final IAuthentication authentication = NodeJsAuthentication();

  _signUp() async {
    setState(() {
      _loading = true;
    });

    User user = User(
      email: _emailController.text,
      name: _userNameController.text,
      password: _passwordController.text,
    );

    print(user);

    AuthenticationResponse response = await authentication.signUp(user);

    setState(() {
      _loading = false;
    });

    if (response.isSuccess) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(DemoLocalizations.of(context)
                    .translate('process_is_success')),
                content: Text(
                    DemoLocalizations.of(context).translate('account_created')),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => LoginPage()));
                      },
                      child: Text(DemoLocalizations.of(context)
                          .translate('go_to_login')))
                ],
              ));
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(DemoLocalizations.of(context).translate('error')),
                content: Text(response.errorMessage),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child:
                          Text(DemoLocalizations.of(context).translate('ok')))
                ],
              ));
    }
  }

  _showDialog(String title, String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(DemoLocalizations.of(context)
                  .translate(DemoLocalizations.of(context).translate(title))),
              content: Text(message),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text(DemoLocalizations.of(context).translate('ok')))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _loading,
      color: Colors.black.withOpacity(0.5),
      child: Scaffold(
        appBar: AppBar(
          title: Text(DemoLocalizations.of(context).translate('register_page')),
          actions: <Widget>[
            DropdownButton(
              icon: Icon(
                Icons.language,
                color: Colors.white,
                size: 30,
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
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _key,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    DemoLocalizations.of(context).translate('register_info'),
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
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person_pin),
                        hintText: DemoLocalizations.of(context)
                            .translate('user_name')),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _emailController,
                    validator: (value) =>
                        UserValidator.validateUserEmailWithTranslation(
                            context, value),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                        hintText: DemoLocalizations.of(context)
                            .translate('enter_email')),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    validator: (value) =>
                        UserValidator.validateUserPasswordWithTranslation(
                            context, value),
                    onChanged: (value) {
                      _password = value;
                    },
                    obscureText: _obscure,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscure = !_obscure;
                            });
                          },
                          icon: _obscure
                              ? EyeInvisibility()
                              : Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.black,
                                ),
                        ),
                        prefixIcon: Icon(Icons.lock_outline),
                        hintText: DemoLocalizations.of(context)
                            .translate('enter_password')),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    obscureText: _obscure,
                    validator: (value) =>
                        UserValidator.validateRePasswordWithTranslation(
                            context, _password, value),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock_outline),
                        hintText: DemoLocalizations.of(context)
                            .translate('renter_password')),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          onPressed: () {
                            if (!_key.currentState.validate()) return;
                            _signUp();
                          },
                          child: Text(
                            DemoLocalizations.of(context).translate('register'),
                            style: TextStyle(fontSize: 20),
                          ),
                          color: Colors.blue,
                          textColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        DemoLocalizations.of(context).translate('have_account'),
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
                                  builder: (context) => LoginPage()));
                        },
                        child: Text(
                          DemoLocalizations.of(context).translate('login'),
                          style: TextStyle(fontSize: 20, color: Colors.blue),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
