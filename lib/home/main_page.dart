import 'package:app_inter_2/authentication/user.dart';
import 'package:app_inter_2/home/home_page.dart';
import 'package:app_inter_2/home/settings_page.dart';
import 'package:app_inter_2/posts/post_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  final User user;

  const MainPage({Key key, this.user}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> screens;
  List<BottomNavigationBarItem> items;
  int _index = 0;
  @override
  void initState() {
    super.initState();

    screens = [
      HomePage(
        user: widget.user,
      ),
      PostPage(),
      SettingsPage(user: widget.user)
    ];
    items = [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.message),
        label: 'Posts',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Settings',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        items: items,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
    );
  }
}
