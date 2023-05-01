// ignore_for_file: avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field, avoid_print, prefer_typing_uninitialized_variables, non_constant_identifier_names, prefer_final_fields, no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:app_flutter/screen/add_member.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/api_parth.dart';
import '../models/user_model.dart';
import '../utils/user_provider.dart';
import 'package:http/http.dart' as http;

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

  Future<List> loadmemberPlus(_id) async {
    List result = [];

    final Map<String, dynamic> loadData = {
      'memberID': _id,
    };

    // ทำการดึงข้อมูลจาก server ตาม url ที่กำหนด
    final response = await http.post(
      Uri.parse(ApiUrl.getmemberplus),
      body: json.encode(loadData),
      headers: {'Content-Type': 'application/json'},
    );

    // เมื่อมีข้อมูลกลับมา
    if (response.statusCode == 200) {
      var data = await json.decode(response.body);

      print(data);
      if (data != null) {
        data.forEach((item) {
          result.add(Usermodel.fromJson(item));
        });
      }
    } else {
      result = [];
    }
    return result;
  }

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
                  )
                ],
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("รหัสสมาชิก  : ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              Text(
                                "   $_id",
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("ชื่อ-สกุล  : ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              Text(
                                "   $_firstname $_lastname",
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("ที่อยู่  : ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
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
                  ),
                ],
              ),
            ),
            Container(
              child: ElevatedButton(
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
                      fetchUser();
                    }
                  },
                  child: Text('Go Add Member')),
            ),
            Expanded(
              child: Container(
                child: FutureBuilder<dynamic>(
                  future: loadmemberPlus(_id),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(shrinkWrap: true,
                          //สร้าง Widget ListView
                          padding: EdgeInsets.all(16.0),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, i) {
                            //หากไม่สร้าง Object สามารถเรียกใช้งานแบบนี้ได้เลย
                            return ListTile(
                              leading: Icon(Icons.car_rental),
                              title: Text(snapshot.data![i]['id_save']),
                            );
                          });
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else if (!snapshot.hasData) {
                      return Text("Nodata");
                    }
            
                    // รูป Spiner ขณะรอโหลดข้อมูล
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
