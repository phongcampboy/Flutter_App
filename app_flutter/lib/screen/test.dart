// ignore_for_file: prefer_const_constructors, avoid_print, prefer_is_empty, sized_box_for_whitespace

import 'package:app_flutter/utils/my_style.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  static const routeName = '/';

  const Test({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TestState();
  }
}

class _TestState extends State<Test> {
  late double screen;
  @override
  void initState() {
    // สำหรับทดสอบ
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    // สำหรับทดสอบ
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Container(
          
          width: screen*0.5,
         
           child: MyStyle().showLogo())
         
          );
  }
}
