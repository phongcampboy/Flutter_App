// ignore_for_file: prefer_const_constructors, avoid_print, prefer_is_empty, sized_box_for_whitespace

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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          childAspectRatio: 2 / 3,
          children: [
            itemFood('Awesome Food 1', 'images/food1.jpg'),
            itemFood('Awesome Food 2', 'images/food2.jpg'),
            itemFood('Awesome Food 3', 'images/food3.jpg'),
            itemFood('Awesome Food 4', 'images/food4.jpg'),
            itemFood('Awesome Food 1', 'images/food1.jpg'),
            itemFood('Awesome Food 2', 'images/food2.jpg'),
            itemFood('Awesome Food 3', 'images/food3.jpg'),
            itemFood('Awesome Food 4', 'images/food4.jpg'),
          ],
        ),
      ),
    );
  }

  itemFood(String title, String img) => Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 5),
                  color: Theme.of(context).primaryColor.withOpacity(.2),
                  spreadRadius: 2,
                  blurRadius: 5)
            ]),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(img, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 10),
            Text(title, style: Theme.of(context).textTheme.titleMedium)
          ],
        ),
      );
}
