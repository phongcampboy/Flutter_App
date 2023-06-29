// ignore_for_file: prefer_const_constructors, unused_field, avoid_print, avoid_unnecessary_containers, prefer_typing_uninitialized_variables, unnecessary_new, non_constant_identifier_names, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:app_flutter/models/loadmem_member.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/api_parth.dart';
import '../models/user_model.dart';
import '../utils/user_provider.dart';
import 'package:http/http.dart' as http;

class PayBill extends StatefulWidget {
  const PayBill({super.key});

  @override
  State<PayBill> createState() => _PayBillState();
}

class _PayBillState extends State<PayBill> {
  late Future<Getmember> futureAlbum;

  Usermodel? _user;
  // Getmember? _GetMember;
  late bool _loginSuccess; // กำหดตัวแปรสถานะการล็อกอิน
  String _id = '';
  String mem_id = '';

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  // ฟังก์ชั่นสำหรับดึงข้อมูลผู้ใช้
  void fetchUser() async {
    // ใช้งาน provider
    UserProvider userProvider = context.read<UserProvider>();
    // ดึงข้อมูลทั่วไปของผู้ใช้
    _user = await userProvider.getUser();
    setState(() {
      // _loginSuccess = true;
      _id = _user!.memberId;
      print(_id);
    });
    //DataMember(_id);
  }

  Future<Getmember?> DataMember(id) async {


    final Map<String, dynamic> loadData = {
      'memberID': id,
    };

    // ทำการดึงข้อมูลจาก server ตาม url ที่กำหนด
    final response = await http.post(
      Uri.parse(ApiUrl.loadmember),
      body: json.encode(loadData),
      headers: {'Content-Type': 'application/json'},
    );

    // เมื่อมีข้อมูลกลับมา
    if (response.statusCode == 200) {
      final data = await json.decode(response.body);
      print(data);
      return Getmember.fromJson(data);
      /*     if (data != null) {
        data.forEach((item) {
          result.add(Getmember.fromJson(item));
        });
      } */
    } 
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('PayBill'),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: _id.isEmpty
                ? Center()
                : FutureBuilder<dynamic>(
                    future: DataMember(_id),
                    builder: (context, snashot) {
                      if (snashot.connectionState == ConnectionState.done) {
                        if (snashot.data!=null) {
                          return Container(
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
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                    Text(snashot.data!.memberId),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("รหัสสมาชิก  : ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                    Text('test'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("รหัสสมาชิก  : ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                    Text('test'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("รหัสสมาชิก  : ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                    Text('test'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("รหัสสมาชิก  : ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                    Text('test'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("รหัสสมาชิก  : ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                    Text('test'),
                                  ],
                                ),
                              ],
                            ),
                          );
                          /*         return ListView.builder(
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
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }); */
                        }
                      }
                      return LinearProgressIndicator();
                    }),
          ),
        ));
  }
}
