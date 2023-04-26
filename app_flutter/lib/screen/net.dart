// ignore_for_file: sort_child_properties_last, prefer_const_constructors, avoid_unnecessary_containers, unnecessary_new
import 'package:flutter/material.dart';

class Net extends StatefulWidget {
  const Net({super.key});

  @override
  State<Net> createState() => _NetState();
}

class _NetState extends State<Net> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Internet")),
        body: ListView(
          children: <Widget>[
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
                    subtitle: Text('xxxxxxxxxxxxxxx',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,),
                    
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
                    subtitle: Text('xxxxxxxxxxxxxxx',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,),
                    
                  ),
                ],
              ),
            ),
          ],
        )
        );
  }
}
