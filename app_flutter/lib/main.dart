// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:app_flutter/routes/routes.dart';
import 'package:app_flutter/screen/home.dart';
import 'package:app_flutter/screen/launcher.dart';
import 'package:app_flutter/screen/login.dart';
import 'package:app_flutter/screen/net.dart';
import 'package:app_flutter/screen/register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(     
                title: 'First Flutter App',
                debugShowCheckedModeBanner: false,
                initialRoute: '/', // สามารถใช้ home แทนได้
                routes: {
                    Launcher.routeName: (context) => Launcher(),
                },
    );
  }
}

