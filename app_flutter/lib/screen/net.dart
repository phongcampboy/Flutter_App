// ignore_for_file: sort_child_properties_last, prefer_const_constructors, avoid_unnecessary_containers, unnecessary_new
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Net extends StatefulWidget {
  const Net({super.key});

  @override
  State<Net> createState() => _NetState();
}

class _NetState extends State<Net> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("TMN INTERNET")),
        body: ListView(
          children: <Widget>[
            Card(
              elevation: 1.0,
              margin: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Image.network(
                        'https://tmncabletv.com/app_flutter/Net/net-tmn.png',
                        fit: BoxFit.cover),
                    margin: EdgeInsets.all(5),
                  ),
                  ListTile(
                    title: Text('Fiber Optic อินเตอร์เน็ต ความเร็วสูง'),
                    subtitle: Text(
                      'บริการอินเตอร์เน็ตความเร็วสูง ด้วยการเชื่อมต่อผ่านสายสัญญาณไฟเบอร์ ออฟติก ที่รองรับเทคโนโลยีแห่งอนาคต ตอบสนองได้ทุกความต้องการ วันนี้เราพร้อมแล้ว สำหรับการให้บริการที่ครอบคลุมทั่วทุกพื้นที่ของพัทยา และพื้นที่ใกล้เคียง ติดตั้งรวดเร็ว ด้วยทีมช่างที่ชำนาญ เชิญสัมผัสกับบริการในระดับพรีเมี่ยมได้แล้ววันนี้. *ราคายังไม่รวมภาษีมูลค่าเพิ่ม (Vat 7%)*',
                    ),
                  ),
                ],
              ),
            ),
            Card(
              elevation: 1.0,
              margin: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Image.network(
                        'https://chawtaichonburi.com/appdata/img/net/P1.png',
                        fit: BoxFit.cover),
                    margin: EdgeInsets.all(5),
                  ),
                ],
              ),
            ),
            Card(
              elevation: 1.0,
              margin: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Image.network(
                        'https://chawtaichonburi.com/appdata/img/net/P2.png',
                        fit: BoxFit.cover),
                    margin: EdgeInsets.all(5),
                  ),
                ],
              ),
            ),
            Card(
              elevation: 1.0,
              margin: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Image.network(
                        'https://chawtaichonburi.com/appdata/img/net/P3.png',
                        fit: BoxFit.cover),
                    margin: EdgeInsets.all(5),
                  ),
                ],
              ),
            ),
            Card(
              elevation: 1.0,
              margin: EdgeInsets.only(bottom: 10),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Image.network(
                        'https://chawtaichonburi.com/appdata/img/net/S4.png',
                        fit: BoxFit.cover),
                    margin: EdgeInsets.all(5),
                  ),
                ],
              ),
            ),
             SizedBox(height: 10,)
          ],
        ));
  }

  Future<void> launchUrlStart({required String url}) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }
}
