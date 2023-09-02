// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers, prefer_const_constructors, avoid_unnecessary_containers, dead_code, prefer_const_literals_to_create_immutables, unnecessary_new, non_constant_identifier_names, prefer_typing_uninitialized_variables, unused_local_variable, use_build_context_synchronously, unnecessary_null_comparison, prefer_final_fields

import 'dart:convert';
import 'package:app_flutter/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/api_parth.dart';
import '../models/addmember_model.dart';
import '../utils/user_provider.dart';
import 'package:http/http.dart' as http;

class LoadMember extends StatefulWidget {
  const LoadMember({super.key});


  @override
  State<LoadMember> createState() => _LoadMemberState();
}

class _LoadMemberState extends State<LoadMember> {
  late bool _loginSuccess; // กำหดตัวแปรสถานะการล็อกอิน
  Usermodel? _user;
  String _id = '';

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

      //loadmemberPlus(_id);
    });
  }

  Future<List> loadmemberPlus(id) async {
    List result = [];

    final Map<String, dynamic> loadData = {
      'memberID': id,
    };

    // ทำการดึงข้อมูลจาก server ตาม url ที่กำหนด
    final response = await http.post(
      Uri.parse(ApiUrl.getmemberplus),
      body: json.encode(loadData),
      headers: {'Content-Type': 'application/json'},
    );

    // เมื่อมีข้อมูลกลับมา
    if (response.statusCode == 200) {
      final data = await json.decode(response.body);
      //print(data);
      if (data != null) {
        data.forEach((item) {
          result.add(Addmember.fromJson(item));
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
        title: Text('LOAD MEMBER'),
      ),
      body: Container(
        child: FutureBuilder<dynamic>(
            future: loadmemberPlus(_id),
            builder: (context, snashot) {
              if (snashot.connectionState == ConnectionState.done) {
                if (snashot.data.length > 0) {
                  //print('DaTA = ' '${snashot.data.length}');
                  return ListView.builder(
                      //สร้าง Widget ListView
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(16.0),
                      itemCount: snashot.data.length,
                      itemBuilder: (context, index) {
                        return Container(
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
                          child: SingleChildScrollView(
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
                                      Text(snashot.data![index].memberId),
                                      
                                    ],
                                  ),
                                      Row(
                                    children: [
                                      Text("ชื่อ  : ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18)),
                                      Text(snashot.data![index].firstName),
                                      Text("    "),
                                      Text(snashot.data![index].lastName),
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
                                  Row(
                                    children: <Widget>[
                                      TextButton(
                                        child: const Text(
                                          'ลบ',
                                          style: TextStyle(
                                              fontSize: 15, color: Colors.red),
                                        ),
                                        onPressed: () async {
                                          final result = await showDialog<bool>(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title:
                                                  const Text('Are you sure?'),
                                              content: const Text(
                                                  'This action will permanently delete this data'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context, false);
                                                  },
                                                  child: const Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    UserProvider userProvider =
                                                        context.read<
                                                            UserProvider>();
                                                    //print(snashot.data![index].memberId);
                                                    var result =
                                                        await userProvider
                                                            .DelUser(snashot
                                                                .data![index]
                                                                .memberId);
                                                    if (result['msg'] ==
                                                        'ลบข้อมูลสำเร็จ') {
                                                      setState(() {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          const SnackBar(
                                                              duration:
                                                                  Duration(
                                                                      seconds:
                                                                          5),
                                                              behavior:
                                                                  SnackBarBehavior
                                                                      .fixed,
                                                              content: Text(
                                                                  'ลบข้อมูลสำเร็จ')),
                                                        );
                                                      });
                                                    }
                                                    Navigator.pop(
                                                        context, true);
                                                  },
                                                  child: const Text('Delete'),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                } else {
                  // ถ้าดาต้าไม่มีค่า
                  return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Center(
                            child: new CircularProgressIndicator(),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            'No DATA',
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ));
                }
                // รูป Spiner ขณะรอโหลดข้อมูล
              } else if (snashot.hasError) {
                return Text("${snashot.error}");
              }
              return LinearProgressIndicator();
            }),
      ),
    );
  }
}
