// ignore_for_file: deprecated_member_use

import 'package:app_flutter/screen/cabletv.dart';
import 'package:app_flutter/screen/login.dart';
import 'package:app_flutter/screen/net.dart';
import 'package:app_flutter/screen/register.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'home.dart';

class Launcher extends StatefulWidget {
  static const routeName = '/';

  const Launcher({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LauncherState();
  }
}

class _LauncherState extends State<Launcher> {
  int _selectedIndex = 0;
  final List<Widget> _pageWidget = <Widget>[
    const Home(),
    const Cabletv(),
    const Net(),
    const Login(),
    const Register(),
  ];
  final List<BottomNavigationBarItem> _menuBar = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      backgroundColor: Colors.blue,
      icon: Icon(FontAwesomeIcons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.infoCircle),
      label: 'Cabletv',
    ),
    const BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.userAlt),
      label: 'Internet',
    ),
    const BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.addressCard),
      label: 'Contact',
    ),
    const BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.cog),
      label: 'Settings',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageWidget.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: _menuBar,
        currentIndex: _selectedIndex,
        //selectedItemColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.blueGrey,
        onTap: _onItemTapped,
      ),
    );
  }
}
