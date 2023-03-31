// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Cabletv extends StatefulWidget {
  const Cabletv({super.key});

  @override
  State<Cabletv> createState() => _CabletvState();
}

class _CabletvState extends State<Cabletv> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cabletv"),
      ),
      body: Center(
        child: Text("Cabletv"),
      ),
    );
  }
}
