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
      // ถ้าล็อกอินอยู่

      print(_loginSuccess);
      // fetchUser(); // ดึงข้อมูลของผู้ใช้ ถ้าล็อกอินอยู่
    }
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
                      Visibility(
                        visible: _loginSuccess,
                        child: Column(
                          children: [
                            FlutterLogo(
                              size: 100,
                            ),
                            Text('Welcome'),
                            ElevatedButton(
                                onPressed: () async {
                                  await userProvider.logout();
                                  setState(() {
                                    _loginSuccess = false;
                                  });
                                },
                                child: Text('Log Out'))
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
