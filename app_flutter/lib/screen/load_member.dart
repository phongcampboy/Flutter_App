// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers, prefer_const_constructors, avoid_unnecessary_containers

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

      loadmemberPlus(_id);
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
      final data = await json.decode(response.body);

      //print(data);

      if (data != null) {
     
          data.forEach((item) {
          result.add(Addmember.fromJson(item));
          print('result= $result');
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
      body: SingleChildScrollView(
        child: Container(
          child: FutureBuilder<dynamic>(
              future: loadmemberPlus(_id),
              builder: (context, snashot) {
            if (snashot.hasData) {
              return ListView.builder(
                  //สร้าง Widget ListView
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16.0),
                  itemCount: snashot.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.car_rental),
                      title: Text(snashot.data![index].memberId),
                    );
                  });
            } else if (snashot.hasError) {
              return Text("${snashot.error}");
            } else if (!snashot.hasData) {
              return Text("Nodata");
            }
            // รูป Spiner ขณะรอโหลดข้อมูล
            return CircularProgressIndicator();
          }),
        ),
      ),
    );
  }
}
