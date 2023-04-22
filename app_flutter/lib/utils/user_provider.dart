// ignore_for_file: unused_import, unused_field

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class UserProvider {
// ใช้งานข้อมูล SharedPreferences
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // ฟังก์ชั่นดึงสถานะการล็อกอิน จากข้อมูล SharedPreferences
  Future<bool> getLoginStatus() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool('loginSuccess') ?? false;
  } 

    // ฟังก์ชั่นสำหรับทำการล็อกอิน โดยส่งค่าไปยัง server 
  Future<Map<String, dynamic>> authen(String email, String password) async {
    final SharedPreferences prefs = await _prefs; 
    var result;
 
    final Map<String, dynamic> loginData = {
        'email': email,
        'password': password
      };
 
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
      if(result['success']!=null){ // กรณีมีข้อมูลกลับบมา และล็อกอินผ่าน
        // บันทึกข้อมูลเบื้องต้นลงใน SharedPreferences
        await prefs.setInt("user_id", int.parse(result['id']));
        await prefs.setString("user_email", result['email']);
        await prefs.setString("user_token", result['jwt']);
        await prefs.setInt("user_token_expired", result['expireAt']);
        await prefs.setBool("loginSuccess", true);
       
      }
    } else { // กรณี error
      throw Exception('Failed to load data');
    }
    return result;
  }

}