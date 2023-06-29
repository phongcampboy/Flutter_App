// ignore_for_file: prefer_const_constructors, unused_field, avoid_print, avoid_unnecessary_containers, prefer_typing_uninitialized_variables, unnecessary_new, non_constant_identifier_names, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'dart:convert';
import 'package:app_flutter/models/loadmem_member.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/api_parth.dart';
import '../models/user_model.dart';
import '../utils/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/qr_flutter.dart';

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
  String code = '';
  String amount = '';
late double screen;
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
    });
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
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
        screen = MediaQuery.of(context).size.width;
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
                        if (snashot.data != null) {
                          code = snashot.data!.billingCode;
                          amount = snashot.data!.amount;
                          return Container(
                            margin: const EdgeInsets.all(20.0),
                            //height: 150.0,
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
                                SizedBox(
                                  width: screen*0.5,
                                  child: Image.asset('images/hispeed.png'),
                                ),
                                    Center(
                                      child: Text(
                                          "บริษัท ซุปเปอร์ ไฮสปีด อินเทอร์เน็ต จำกัด \n 46/20 หมู่ 4 ห้วยใหญ่ บางละมุง ชลบุรี 20150 ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15)),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text("รหัสสมาชิก  : ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15)),
                                        Text(snashot.data!.memberId),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("ชื่อ-สกุล  : ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15)),
                                        Text(snashot.data!.firstName),
                                        Text("  "),
                                        Text(snashot.data!.lastName)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("เบอร์โทรศัพท์  : ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15)),
                                        Text(snashot.data!.tel1),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("สถานะ  : ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15)),
                                        Text(snashot.data!.memberStatusId),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("ประเภทบริการ  : ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15)),
                                        Text(snashot.data!.descriptionRate),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("รอบบริการ  : ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15)),
                                        Text(snashot.data!.lastPay),
                                        Text(" ถึง "),
                                        Text(snashot.data!.nextPay)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("รวมยอดชำระ  : ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15)),
                                        Text(snashot.data!.total),
                                        Text("  บาท")
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('($amount)',
                                            style: TextStyle(fontSize: 16)),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    QrImageView(
                                      data: '$code',
                                      version: QrVersions.auto,
                                      size: 130.0,
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Center(
                                      child: Text(
                                        snashot.data!.billingCode,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: Text(
                                          "ลูกค้าชำระค่าบริการได้ที่ศูนย์บริการ TMN \nหรือชำระผ่านเคาน์เตอร์เซอร์วิส 7-Eleven \nชำระผ่าน เคเบิล ไทยบิลลิ่ง \n*โปรดตรวจสอบความถูกต้องของเอกสาร*",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      }
                      return LinearProgressIndicator();
                    }),
          ),
        ));
  }
}
