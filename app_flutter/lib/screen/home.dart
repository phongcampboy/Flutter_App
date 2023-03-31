// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        elevation: 0,
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        height: 70,
        decoration: new BoxDecoration(color: Colors.blueAccent),
        child: new Center(
          child: new Text("Hello, World!"),
        ),
      ),
    );
  }
}
