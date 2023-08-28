// ignore_for_file: prefer_const_constructors, unnecessary_new, unused_field, unused_local_variable, avoid_print, unused_import, prefer_final_fields, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace, dead_code, sort_child_properties_last

import 'package:app_flutter/models/user_model.dart';
import 'package:app_flutter/screen/getwidget.dart';
import 'package:app_flutter/screen/member.dart';
import 'package:app_flutter/screen/sildemenu.dart';
import 'package:app_flutter/screen/test.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
// ส่วนของตัวแปรข้อมูลพื้นฐาน
  Usermodel? _user;
  String _id = '';
  String _firstname = '';
  String _lastname = '';
  late double screen;
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
    _id = _user!.memberId;
    _firstname = _user!.firstName;
    _lastname = _user!.lastName;
  }

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    // ใช้งาน provider
    UserProvider userProvider = context.read<UserProvider>();
    return Scaffold(
/*        appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Icon(Icons.notifications),
          )
        ],
        title: Text("Home"),
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 17, 148, 242),
      
      ),  */
        // drawer: SideMenu(),
        body: FutureBuilder<bool>(
      future: userProvider.getLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                Color.fromARGB(255, 5, 131, 227),
                Color.fromARGB(255, 76, 164, 227),
                Color.fromARGB(255, 38, 134, 218)
              ]),
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(40),
                      child: Icon(Icons.menu, size: 20, color: Colors.white),
                    ),
                    Expanded(
                        child: Container(
                            //child: Text('data'),
                            )),
                    IconButton(
                      iconSize: 30,
                      color: Color.fromARGB(255, 246, 242, 242),
                      icon: const Icon(
                        Icons.login_outlined,
                      ),
                      // the method which is called
                      // when button is pressed
                      onPressed: () async {
                        await userProvider.logout();
                        setState(() {
                          _loginSuccess = false;
                        });
                      },
                    ),
                    SizedBox(width: 12),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: screen * 0.5,
                  child: Image.asset('images/hispeed.png'),
                ),
                Center(
                  child: Text(
                    "TMN SUPER HISPEED",
                    style: TextStyle(color: Colors.white, fontSize: 23),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                /*     Visibility(
                  visible: _loginSuccess,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Center(
                      child: Text(
                        "Welcome $_firstname $_lastname",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ), */
                Visibility(
                  visible: !_loginSuccess,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Center(
                      child: Text(
                        "Welcome to TMN Hipeed",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60),
                          )),
                      child: SingleChildScrollView(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Visibility(
                                  visible: _loginSuccess,
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    height: 150,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                            Colors.blue,
                                            Color.fromARGB(255, 120, 184, 248),
                                            Color.fromARGB(255, 164, 218, 247),
                                            Color.fromARGB(255, 170, 206, 252)
                                            //add more colors for gradient
                                          ],
                                          begin: Alignment
                                              .topLeft, //begin of the gradient color
                                          end: Alignment
                                              .bottomRight, //end of the gradient color
                                          stops: [
                                            0,
                                            0.2,
                                            0.5,
                                            0.8
                                          ] //stops for individual color
                                          //set the stops number equal to numbers of color
                                          ),

                                      borderRadius: BorderRadius.circular(
                                          25), //border corner radius
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Column(
                                        children: [
                                          const Text(
                                            'Welcome',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color:
                                                    Colors.white), //Textstyle
                                          ), //Text
                                          const SizedBox(
                                            height: 10,
                                          ),

                                          Text(
                                            'รหัสสมาชิก $_id',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Color.fromARGB(255, 7,
                                                    77, 135)), //Textstyle
                                          ),
                                          Text(
                                            '$_firstname $_lastname',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Color.fromARGB(255, 7,
                                                    77, 135)), //Textstyle
                                          ),
                                          //Text
                                          const SizedBox(
                                            height: 20,
                                          ),
                                     /*      ElevatedButton(
                                            onPressed: () async {
                                              // เมื่อล็อกเอาท์
                                              // ทำการออกจากระบบ
                                              await userProvider.logout();
                                              setState(() {
                                                _loginSuccess = false;
                                              });
                                            },
                                            child: Text('Logout'),
                                          ), */
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: !_loginSuccess,
                                  child: Container(
                                    margin: EdgeInsets.all(20),
                                    height: 200,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                            Colors.blue,
                                            Color.fromARGB(255, 120, 184, 248),
                                            Color.fromARGB(255, 164, 218, 247),
                                            Color.fromARGB(255, 170, 206, 252)
                                            //add more colors for gradient
                                          ],
                                          begin: Alignment
                                              .topLeft, //begin of the gradient color
                                          end: Alignment
                                              .bottomRight, //end of the gradient color
                                          stops: [
                                            0,
                                            0.2,
                                            0.5,
                                            0.8
                                          ] //stops for individual color
                                          //set the stops number equal to numbers of color
                                          ),

                                      borderRadius: BorderRadius.circular(
                                          30), //border corner radius
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Column(
                                        children: [
                                          const Text(
                                            'Please login member',
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.w500,
                                                color:
                                                    Colors.white), //Textstyle
                                          ), //Text
                                          const SizedBox(
                                            height: 10,
                                          ),

                                          Text(
                                            'กรุณาเข้าสูระบบสมาชิก',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Color.fromARGB(255, 7,
                                                    77, 135)), //Textstyle
                                          ),

                                          const SizedBox(
                                            height: 20,
                                          ),
                                          ElevatedButton(
                                              onPressed: () async {
                                                // กำหดให้รอค่า หลังจากเปิดไปหน้า lgoin
                                                final result =
                                                    await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              Login(),
                                                          settings:
                                                              RouteSettings(
                                                                  arguments:
                                                                      null),
                                                        ));

                                                // ถ้ามีการปิดหน้มที่เปิด และส่งค่ากลับมาเป็น true
                                                if (result == true) {
                                                  // ทำคำสั่งดึงข้อมูลผู้ใช้ เมื่อล็อกอินผ่าน
                                                  fetchUser();
                                                }
                                              },
                                              child: Text('Go to Login')),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  // ส่วนที่แสดงกรณีล็อกอินแล้ว
                                  visible:
                                      _loginSuccess, // ใช้สถานะการล็อกอินกำหนดกรแสดง

                                  child: Column(
                                    children: <Widget>[
                                      /*  FlutterLogo(
                                        size: 50,
                                      ), */
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.asset(
                                                'images/food1.jpg',
                                                fit: BoxFit.cover,
                                                height: 120,
                                              ),
                                            ),
                                          ),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.asset(
                                              'images/food2.jpg',
                                              fit: BoxFit.cover,
                                              height: 120,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.asset(
                                                'images/food1.jpg',
                                                fit: BoxFit.cover,
                                                height: 120,
                                              ),
                                            ),
                                          ),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.asset(
                                              'images/food2.jpg',
                                              fit: BoxFit.cover,
                                              height: 120,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Card(
                                          elevation: 4.0,
                                          child: Column(
                                            children: [
                                              ListTile(
                                                title: Text('2300 per month'),
                                                subtitle: Text(
                                                    '2 bed, 1 bath, 1300 sqft'),
                                                trailing: Icon(
                                                    Icons.favorite_outline),
                                              ),
                                              Container(
                                                height: 200.0,
                                                child: Image.network(
                                                    'https://tmncabletv.com/app_flutter/Net/net-tmn.png',
                                                    fit: BoxFit.cover),
                                                margin: EdgeInsets.all(5),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(16.0),
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                    'Beautiful home to rent, recently refurbished with modern appliances...'),
                                              ),
                                              ButtonBar(
                                                children: [
                                                  /*   TextButton(
                                                    child: const Text(
                                                        'CONTACT AGENT'),
                                                    onPressed: () {/* ... */},
                                                  ), */
                                                  TextButton(
                                                    child: const Text(
                                                        'LEARN MORE'),
                                                    onPressed: () async {
                                                      Navigator.push(
                                                          // ไปหน้าล็อกอิน
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    Member(),
                                                            settings:
                                                                RouteSettings(
                                                                    arguments:
                                                                        null),
                                                          ));
                                                    },
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                          //Text(_email), // แสดงอีเมล
                                          /*           ElevatedButton(
                                        onPressed: () async {
                                          Navigator.push(
                                              // ไปหน้าล็อกอิน
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Member(),
                                                settings: RouteSettings(
                                                    arguments: null),
                                              ));
                                        },
                                        child: Text('GO TO MEMBER'), */
                                          ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          // ถ้ามี error
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    ));
  }
}
