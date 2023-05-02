// ignore_for_file: avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field, avoid_print, prefer_typing_uninitialized_variables, non_constant_identifier_names, prefer_final_fields, no_leading_underscores_for_local_identifiers

import 'package:app_flutter/screen/add_member.dart';
import 'package:app_flutter/screen/load_member.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';

class Member extends StatefulWidget {
  const Member({super.key});

  @override
  State<Member> createState() => _MemberState();
}

class _MemberState extends State<Member> {
  late bool _loginSuccess; // กำหดตัวแปรสถานะการล็อกอิน
  // ส่วนของตัวแปรข้อมูลพื้นฐาน
  Usermodel? _user;

  String _id = '';
  String _firstname = '';
  String _lastname = '';

  String _idsave = '';
  String _nameplus = '';
  String _lastplus = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MEMBER'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20.0),
              height: 150.0,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffDDDDDD),
                    blurRadius: 6.0,
                    spreadRadius: 1.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("รหัสสมาชิก  : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      Text(
                        "   $_id",
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("ชื่อ-สกุล  : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      Text(
                        "   $_firstname $_lastname",
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("ที่อยู่  : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      Text(
                        "   ทดสอบ ยอดจำปา",
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      TextButton(
                        child: const Text('จ่ายบิล'),
                        onPressed: () {/* ... */},
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        child: const Text('ประวัติการชำระ'),
                        onPressed: () {/* ... */},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  // กำหดให้รอค่า หลังจากเปิดไปหน้า lgoin
                  final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddMember(),
                        settings: RouteSettings(arguments: null),
                      ));

                  // ถ้ามีการปิดหน้มที่เปิด และส่งค่ากลับมาเป็น true
                  if (result == true) {
                    // ทำคำสั่งดึงข้อมูลผู้ใช้ เมื่อล็อกอินผ่าน
                    //fetchUser();
                  }
                },
                child: Text('Go Add Member')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoadMember(),
                        settings: RouteSettings(arguments: null),
                      ));
                },
                child: Text('Go Data Member'))
          ],
        ),
      ),
    );
  }
}
