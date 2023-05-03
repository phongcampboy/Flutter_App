// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'INTERNET',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                  Expanded(child: Container()),
                  Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: Color.fromARGB(255, 21, 21, 21),
                  ),
                  Icon(Icons.calendar_today_outlined, size: 20),
                  SizedBox(width: 12),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: Color.fromARGB(255, 21, 21, 21),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Text(
                    'INTERNET',
                    style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 115, 113, 113),
                        fontWeight: FontWeight.w700),
                  ),
                  Expanded(child: Container()),
                  Text(
                    'Detail',
                    style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 115, 113, 113),
                        fontWeight: FontWeight.w700),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    size: 20,
                    color: Color.fromARGB(255, 21, 21, 21),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 12, 102, 248).withOpacity(0.9),
                      Colors.blue.withOpacity(0.7),
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(80),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(5, 10),
                      blurRadius: 20,
                      color: Colors.black.withOpacity(0.2),
                    )
                  ],
                ),
                child: Container(
                  padding: EdgeInsets.only(left: 20, top: 25, right: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nexe Work',
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 241, 238, 238),
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Legs Toning',
                          style: TextStyle(
                              fontSize: 25,
                              color: Color.fromARGB(255, 241, 238, 238),
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Add Glutes Workout',
                          style: TextStyle(
                              fontSize: 25,
                              color: Color.fromARGB(255, 241, 238, 238),
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 18),
                        Row(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.add_a_photo_outlined,
                                  size: 25,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            Expanded(child: Container()),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 10,
                                        offset: Offset(4, 7))
                                  ]),
                              child: Icon(
                                Icons.play_circle_fill_rounded,
                                size: 60,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ]),
                ),
              ),
              SizedBox(height: 15),
              Container(
                height: 180,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 20),
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://chawtaichonburi.com/appdata/img/sky.jpg'),
                              fit: BoxFit.fill),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 20,
                                offset: Offset(8, 7)
                                ),
                                BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 10,
                                offset: Offset(-1, -7)
                                ),
                          ]),
                    ),
                    Container(
                      height: 100,
                      margin: EdgeInsets.only(left: 150,top: 50),
                      child: Column(children: [
                             Text(
                          'Add Glutes Workout',
                          style: TextStyle(
                              fontSize: 19,
                              color: Color.fromARGB(255, 172, 82, 241),
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 10,),
                        RichText(text: TextSpan(
                          
                        ))
                      ]),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
