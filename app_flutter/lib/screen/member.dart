// ignore_for_file: avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field, avoid_print, prefer_typing_uninitialized_variables, non_constant_identifier_names, prefer_final_fields, no_leading_underscores_for_local_identifiers

import 'package:app_flutter/screen/add_member.dart';
import 'package:app_flutter/screen/listpay.dart';
import 'package:app_flutter/screen/paybill.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../utils/user_provider.dart';
import 'load_member.dart';

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
  void initState() {
    super.initState();
    loadSettings(); // เรียกใช้งานตั้งค่าเมื่อเริ่มต้นเป็นฟังก์ชั่น ให้รองรับ async
  }

  // ตั้งค่าเริ่มต้น
  void loadSettings() async {
    // ใช้งาน provider
    UserProvider userProvider = context.read<UserProvider>();
    _loginSuccess =
        await userProvider.getLoginStatus(); // ถึงสถานะการล็อกอิน ถ้ามี
    if (_loginSuccess) {
      fetchUser(); // ดึงข้อมูลของผู้ใช้ ถ้าล็อกอินอยู่
    }
  }

  // ฟังก์ชั่นสำหรับดึงข้อมูลผู้ใช้
  void fetchUser() async {
    // ใช้งาน provider
    UserProvider userProvider = context.read<UserProvider>();
    setState(() {
      _loginSuccess = true;
      print('Loginstatus{$_loginSuccess}');
    });
    // ดึงข้อมูลทั่วไปของผู้ใช้
    _user = await userProvider.getUser();

    setState(() {
      _id = _user!.memberId;
      _firstname = _user!.firstName;
      _lastname = _user!.lastName;

      //loadmemberPlus(_id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MEMBER'),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
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
                  color: Color.fromARGB(255, 237, 236, 236),
                  blurRadius: 6.0,
                  spreadRadius: 1.0,
                  offset: Offset(0.0, 0.0),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(children: [
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
              ]),
            ),
          ),
          Container(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(200))),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 30,
                children: [
                  itemDashboard('Videos', CupertinoIcons.play_rectangle,
                      Colors.deepOrange),
                  itemDashboard(
                      'Analytics', CupertinoIcons.graph_circle, Colors.green),
                  itemDashboard(
                      'Audience', CupertinoIcons.person_2, Colors.purple),
                  itemDashboard(
                      'Comments', CupertinoIcons.chat_bubble_2, Colors.brown),
                  itemDashboard('Revenue', CupertinoIcons.money_dollar_circle,
                      Colors.indigo),
                  itemDashboard(
                      'Upload', CupertinoIcons.add_circled, Colors.teal),
                  itemDashboard(
                      'About', CupertinoIcons.question_circle, Colors.blue),
                  itemDashboard(
                      'Contact', CupertinoIcons.phone, Colors.pinkAccent),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  itemDashboard(String title, IconData iconData, Color background) => Container(
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: background,
                  shape: BoxShape.circle,
                ),
                child: Icon(iconData, color: Colors.white)),
            const SizedBox(height: 8),
            Text(title.toUpperCase(),
                style: Theme.of(context).textTheme.titleMedium)
          ],
        ),
      );
}
