// ignore_for_file: prefer_const_constructors, unnecessary_new, unused_field, unused_local_variable, avoid_print, unused_import

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/user_provider.dart';
import 'login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late bool _loginSuccess; // กำหดตัวแปรสถานะการล็อกอิน

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
  }

  @override
  Widget build(BuildContext context) {
    // ใช้งาน provider
    UserProvider userProvider = context.read<UserProvider>();
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          elevation: 0,
          backgroundColor: Colors.blue,
        ),
        body: FutureBuilder<bool>(
            future: userProvider.getLoginStatus(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Profile Screen'),
                      Visibility(
                        // ส่วนที่แสดงกรณีล็อกอินแล้ว
                        visible: _loginSuccess, // ใช้สถานะการล็อกอินกำหนดกรแสดง
                        child: Column(
                          children: [
                            FlutterLogo(
                              size: 100,
                            ),
                            Text('Welcome member'),
                            //Text(_email), // แสดงอีเมล
                            ElevatedButton(
                              onPressed: () async {
                                // เมื่อล็อกเอาท์
                                // ทำการออกจากระบบ
                                await userProvider.logout();
                                setState(() {
                                  _loginSuccess = false;
                                });
                              },
                              child: Text('Logout'),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: !_loginSuccess,
                        child: ElevatedButton(
                            onPressed: () async {
                              // กำหดให้รอค่า หลังจากเปิดไปหน้า lgoin
                              final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Login(),
                                    settings: RouteSettings(arguments: null),
                                  ));
                
                              // ถ้ามีการปิดหน้มที่เปิด และส่งค่ากลับมาเป็น true
                              if (result == true) {
                                // ทำคำสั่งดึงข้อมูลผู้ใช้ เมื่อล็อกอินผ่าน
                                fetchUser();
                              }
                            },
                            child: Text('Go to Login')),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            }));
  }
}
