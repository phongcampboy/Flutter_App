// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, use_key_in_widget_constructors

import 'package:app_flutter/routes/routes.dart';
import 'package:app_flutter/screen/cabletv.dart';
import 'package:app_flutter/screen/home.dart';
import 'package:app_flutter/screen/launcher.dart';
import 'package:app_flutter/screen/login.dart';
import 'package:app_flutter/screen/net.dart';
import 'package:app_flutter/screen/register.dart';
import 'package:app_flutter/utils/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => UserProvider(),
      child: MaterialApp(
        title: 'First Flutter App',
        debugShowCheckedModeBanner: false,
        home: HelloConvexAppBar(),

        /*      initialRoute: '/', // สามารถใช้ home แทนได้

          routes: {
                      Launcher.routeName: (context) => Launcher(),
                  },  */
      ),
    );
  }
}

class HelloConvexAppBar extends StatefulWidget {
  @override
  State<HelloConvexAppBar> createState() => _HelloConvexAppBarState();
}

class _HelloConvexAppBarState extends State<HelloConvexAppBar> {
  List pages = [Home(), Cabletv(), Net()];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: ConvexAppBar(
          style: TabStyle.reactCircle,
          top: -30,
          height: 50,
          items: [
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(icon: Icons.tv_rounded, title: 'Cable TV'),
            TabItem(icon: Icons.wifi, title: 'Internet'),
          ],
          initialActiveIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
    );
  }
}
