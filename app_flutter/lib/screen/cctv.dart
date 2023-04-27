// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';

class Cctv extends StatefulWidget {
  const Cctv({super.key});

  @override
  State<Cctv> createState() => _CctvState();
}

class _CctvState extends State<Cctv> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('CCTV'),
        ),
        body: ListView(
          children: <Widget>[
            Card(
              elevation: 1.0,
              margin: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Container(
                    //width: MediaQuery.of(context).size.width,
                    child: Image.network(
                        'https://chawtaichonburi.com/appdata/img/cctv/cctv.png',
                        fit: BoxFit.cover),
                    margin: const EdgeInsets.all(10),
                  ),
                  const ListTile(
                    title: Text('ระบบโทรทัศน์วงจรปิด ( CCTV System)'),
                    subtitle: Text(
                      'เป็นการส่งสัญญาณภาพ จากกล้องโทรทัศน์วงจรปิด ที่ได้ติดตั้งตามที่ต่างๆ มายังส่วนรับภาพ/ดูภาพ ซึ่งเรียกว่า จอภาพ ( Monitor ) โดยทั่วไปจะติดตั้งอยู่คนละที่กับกล้อง เช่นที่ห้องควบคุม เป็นต้น',
                    ),
                  ),
                  const ListTile(
                    title: Text('อุปกรณ์ที่ใช้ในระบบโทรทัศน์วงจรปิด'),
                    subtitle: Text(
                      '1.กล้องโทรทัศน์วงจรปิด (CCTV Camera)\n2.เลนส์ (CCTV Lenses)\n3.เครื่องเลือก / สลับภาพ (Video Switcher) และเครื่องผสม / รวมภาพ (Multiple Screen Displays)\n4.จอภาพ (Video Monitor)\n5.เครื่องบันทึกภาพ (Video Recorder)\n 6.อุปกรณ์เสริม เพื่อเพิ่มประสิทธิภาพในการทำงานของระบบโทรทัศน์วงจรปิด(Related Accessories for more efficiency CCTV System)\n- กล่องหุ้มกล้อง (Camera Housing)\n- ฐานกล้องปรับทิศทางได้ (Pan & Tilt units)\n- อุปกรณอื่นๆ ที่เกี่ยวข้อง\n 7.ระบบการควบคุม (Control System)\n8.อุปกรณ์อื่น ๆ ที่นำเข้าใช้เกี่ยวข้องกับระบบโทรทัศน์วงจรปิด',
                    ),
                  ),
                ],
              ),
            ),
            Card(
              elevation: 1.0,
              margin: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Image.network(
                        'https://chawtaichonburi.com/appdata/img/cctv/cctv01.png',
                        fit: BoxFit.cover),
                    margin: const EdgeInsets.all(10),
                  ),
                ],
              ),
            ),
            Card(
              elevation: 1.0,
              margin: const EdgeInsets.only(bottom: 10),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Image.network(
                        'https://chawtaichonburi.com/appdata/img/cctv/cctv02.png',
                        fit: BoxFit.cover),
                    margin: const EdgeInsets.all(10),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
