// ignore_for_file: unused_import, unused_field, prefer_typing_uninitialized_variables, avoid_print, unused_local_variable
import 'dart:convert';
import 'package:app_flutter/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../constants/api_parth.dart';

class UserProvider {
// ใช้งานข้อมูล SharedPreferences
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // ฟังก์ชั่นดึงสถานะการล็อกอิน จากข้อมูล SharedPreferences
  Future<bool> getLoginStatus() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool('loginSuccess') ?? false;
  }

  // ฟังก์ชั่นดึงข้อมูลผู้ใช้ทั่วไป จากข้อมูล SharedPreferences
  Future<Usermodel> getUser() async {
    final SharedPreferences prefs = await _prefs;
    return Usermodel(
      memberId: prefs.getString('user_id')!,
      firstName: prefs.getString('firstName')!,
      lastName: prefs.getString('lastName')!,
     
    );
  }

  //  ฟังก์ชั่นล็อกเอาท์ออกจากระบบ ล้างค่าข้อมูล SharedPreferences
  Future<bool> logout() async {
    final SharedPreferences prefs = await _prefs;
    return await prefs.clear();
  }

  // ฟังก์ชั่นสำหรับทำการล็อกอิน โดยส่งค่าไปยัง server
  Future<Map<String, dynamic>> authen(String username, String password) async {
    final SharedPreferences prefs = await _prefs;
    var result;

    final Map<String, dynamic> loginData = {'user': username, 'pass': password};

    // ทำการดึงข้อมูลจาก server ตาม url ที่กำหนด
    final response = await http.post(
      Uri.parse(ApiUrl.login),
      body: json.encode(loginData),
      headers: {'Content-Type': 'application/json'},
    );

    // เมื่อมีข้อมูลกลับมา
    if (response.statusCode == 200) {
      var body = response.body;
      result = await json.decode(body);
      if (result['success'] != null) {
        // กรณีมีข้อมูลกลับบมา และล็อกอินผ่าน
        // บันทึกข้อมูลเบื้องต้นลงใน SharedPreferences
        await prefs.setString("user_id", (result['MemberID']));
        await prefs.setString("firstName", (result['FirstName']));
        await prefs.setString("lastName", (result['LastName']));
        await prefs.setBool("loginSuccess", true);
      }
    } else {
      // กรณี error
      throw Exception('Failed to load data');
    }
    return result;
  }

  // ฟังก์ชั่นสำหรับสร้างบัญชีใหม่ โดยส่งค่าไปยัง server แล้วบันทึกลงฐานข้อมูล
  Future<Map<String, dynamic>> create(
      String memberID, String username, String password) async {
    var result;
    // ทำการดึงข้อมูลจาก server ตาม url ที่กำหนด
    final response =
        await http.post(Uri.parse(ApiUrl.register), // ใช้ url จากค่าที่กำหนด
            body: {
          'MemberID': memberID,
          'User_app': username,
          'Pass_app': password,
        });

    // เมื่อมีข้อมูลกลับมา
    if (response.statusCode == 200) {
      var body = response.body;
      print(body);
      result = await json.decode(body);
    } else {
      // กรณี error
      throw Exception('Failed to load data');
    }
    return result;
  }
}
