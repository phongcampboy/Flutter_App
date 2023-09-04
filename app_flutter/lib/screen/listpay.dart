// ignore_for_file: avoid_print, non_constant_identifier_names, unused_field, no_leading_underscores_for_local_identifiers, avoid_unnecessary_containers, prefer_const_constructors, unused_local_variable, use_build_context_synchronously, unnecessary_new

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../constants/api_parth.dart';
import '../models/listpay.dart';
import '../models/user_model.dart';
import '../utils/user_provider.dart';

class ListPay extends StatefulWidget {
  const ListPay({super.key});

  @override
  State<ListPay> createState() => _ListPayState();
}

class _ListPayState extends State<ListPay> {
  late bool _loginSuccess;
  Usermodel? _user;
  String _id = '';

  @override
  void initState() {
    super.initState();
    fetchUser(); // เรียกใช้งานตั้งค่าเมื่อเริ่มต้นเป็นฟังก์ชั่น ให้รองรับ async
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

      //ListPaydata(_id);
    });
  }

  Future<List> ListPaydata(id) async {
    List result = [];

    final Map<String, dynamic> loadData = {
      'memberID': id,
    };

    // ทำการดึงข้อมูลจาก server ตาม url ที่กำหนด
    final response = await http.post(
      Uri.parse(ApiUrl.listpay),
      body: json.encode(loadData),
      headers: {'Content-Type': 'application/json'},
    );

    // เมื่อมีข้อมูลกลับมา
    if (response.statusCode == 200) {
      final data = await json.decode(response.body);
      //print(data);
      if (data != null) {
        data.forEach((item) {
          result.add(Listpay.fromJson(item));
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
        title: const Text('ListPay'),
      ),
      body: Container(
        child: FutureBuilder<dynamic>(
            future: ListPaydata(_id),
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
                                      Text(snashot.data![index].lastPay),
                                    ],
                                  ),
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
