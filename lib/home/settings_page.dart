import 'package:app_inter_2/authentication/authentication-interface/i_authentication.dart';
import 'package:app_inter_2/authentication/authentication_response.dart';
import 'package:app_inter_2/authentication/nodejs-authentication/node_js_authentication.dart';
import 'package:app_inter_2/authentication/user.dart';
import 'package:app_inter_2/authentications_pages/login_page.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final User user;

  const SettingsPage({Key key, this.user}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final IAuthentication authentication = NodeJsAuthentication();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LicensePage(),
                  ),
                );
              },
              leading: Icon(
                Icons.card_membership,
                color: Colors.black,
                size: 25,
              ),
              title: Text('Licenses'),
            ),
            ListTile(
              onTap: () async {
                AuthenticationResponse auth =
                    await authentication.logout(widget.user);

                if (auth.isSuccess) {
                  Navigator.of(context).popUntil((route) => route == null);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                }
              },
              leading: Icon(
                Icons.logout,
                color: Colors.black,
                size: 25,
              ),
              title: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
