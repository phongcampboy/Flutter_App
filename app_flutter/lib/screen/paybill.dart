// ignore_for_file: prefer_const_constructors, unused_field, avoid_print, avoid_unnecessary_containers, prefer_typing_uninitialized_variables, unnecessary_new, non_constant_identifier_names, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, unused_local_variable

import 'dart:convert';

import 'package:app_flutter/models/loadmem_member.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  late Future<dynamic> futureAlbum;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Usermodel? _user;
  Getmember? _GetMember;
  late bool _loginSuccess; // กำหดตัวแปรสถานะการล็อกอิน
  String _id = '';
  String mem_id = '';

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
      //print('Loginstatus{$_loginSuccess}');
    });
    // ดึงข้อมูลทั่วไปของผู้ใช้
    _user = await userProvider.getUser();

    setState(() {
      _id = _user!.memberId;
     // futureAlbum = DataMember(_id);
      
      //getdata();
    });
  }

  Future<Map<String, dynamic>> DataMember(id) async {
    final SharedPreferences prefs = await _prefs;
    var result;

    final Map<String, dynamic> PostData = {'memberID': id};

    // ทำการดึงข้อมูลจาก server ตาม url ที่กำหนด
    final response = await http.post(
      Uri.parse(ApiUrl.loadmember),
      body: json.encode(PostData),
      headers: {'Content-Type': 'application/json'},
    );

    // เมื่อมีข้อมูลกลับมา
    if (response.statusCode == 200) {
      var body = response.body;
      result = await json.decode(body);
      print(result);
     
    } else {
      // กรณี error
      throw Exception('Failed to load data');
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
         child: FutureBuilder<dynamic>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(//สร้าง Widget ListView
                    padding: EdgeInsets.all(16.0),
                    itemBuilder: (context, i) {
                       //หากไม่สร้าง Object สามารถเรียกใช้งานแบบนี้ได้เลย
                      return _buildRow(snapshot.data[i]["title"].toString()); 
                    });
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
 
              // รูป Spiner ขณะรอโหลดข้อมูล
              return CircularProgressIndicator();
            },
          ),
        ),
      
    
      
    );
  }
  
  Widget _buildRow(String dataRow) {
     return ListTile(
    title: Text(
      dataRow,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
  );
  }
}
