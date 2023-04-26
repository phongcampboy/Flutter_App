// ignore_for_file: prefer_const_constructors, sort_child_properties_last

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
        body: ListView(
          children: <Widget>[
            Card(
              elevation: 1.0,
              margin: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Container(
                    //width: MediaQuery.of(context).size.width,
                    child: Image.network(
                        'https://chawtaichonburi.com/appdata/img/cable/cable.png',
                        fit: BoxFit.cover),
                    margin: EdgeInsets.all(10),
                  ),
                  ListTile(
                    /*             leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://tmncabletv.com/app_flutter/Net/net-tmn.png'),
                    ), */
                    title: Text('เคเบิลทีวีท้องถิ่น'),
                    subtitle: Text(
                      'ส่งตรงความบันเทิงและสาระด้วยรายการทีวีน่าสนใจจากทั่วทุกมุมโลกทั้งรูปแบบ ANALOG และ DIGITAL คมชัด บริการรวดเร็วฉับไว',
                      //overflow: TextOverflow.ellipsis,
                      //maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
            Card(
              elevation: 1.0,
              margin: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Image.network(
                        'https://tmncabletv.com/app_flutter/Net/net-tmn.png',
                        fit: BoxFit.cover),
                    margin: EdgeInsets.all(10),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://tmncabletv.com/app_flutter/Net/net-tmn.png'),
                    ),
                    title: Text('Test'),
                    subtitle: Text(
                      'xxxxxxxxxxxxxxx',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
