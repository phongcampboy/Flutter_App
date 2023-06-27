// ignore_for_file: prefer_const_constructors, unused_field, avoid_print, avoid_unnecessary_containers, prefer_typing_uninitialized_variables, unnecessary_new

import 'dart:convert';
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
  Usermodel? _user;
  late bool _loginSuccess; // กำหดตัวแปรสถานะการล็อกอิน
  String _id = '';

  @override
  void initState() {
    super.initState();
    loadSettings();
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
      //print(_id);
      loadmember(_id);
    });
  }

  Future<List> loadmember(id) async {
    List result = [];

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
        title: Text('PayBill'),
      ),
      body: Container(
/*         child: FutureBuilder<dynamic>(
            future: loadmember(_id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data.length > 0) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
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
                                      Text(snapshot.data![index].memberId),
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
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return LinearProgressIndicator();
            }), */
      ),
    );
  }
}
