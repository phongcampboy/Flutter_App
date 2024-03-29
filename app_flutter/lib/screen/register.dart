// ignore_for_file: prefer_const_constructors, unused_field, unused_local_variable, prefer_const_literals_to_create_immutables, use_build_context_synchronously, unnecessary_brace_in_string_interps, unnecessary_new, unnecessary_null_comparison

import 'package:app_flutter/utils/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // สร้างฟอร์ม key หรือ id ของฟอร์มสำหรับอ้างอิง
  final _formKey = GlobalKey<FormState>();

  // กำหนดตัวแปรรับค่า
  final _memberID = TextEditingController();
  final _username = TextEditingController();
  final _password = TextEditingController();

  // กำหนดสถานะการแสดงแบบรหัสผ่าน
  bool _isHidden = true;
  bool _registeringStatus = false;

  @override
  void dispose() {
    _memberID.dispose(); // ยกเลิกการใช้งานที่เกี่ยวข้องทั้งหมดถ้ามี
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ใช้งาน provider
    UserProvider userProvider = context.read<UserProvider>();
    return Scaffold(
      appBar: AppBar(
        title: (Text("register")),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey, // กำหนด key
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                FlutterLogo(
                  size: 100,
                ),
                Text('Register Screen'),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'กรุณากรอกข้อมูล!';
                    } else if (!RegExp(r'^[A-Za-z0-9]+$').hasMatch(value)) {
                      return "ไม่อนุญาตภาษาไทย!";
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'MemberID',
                    icon: const FaIcon(FontAwesomeIcons.userGear),
                  ),
                  controller: _memberID, // ผูกกับ TextFormField ที่จะใช้
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  validator: (value) => EmailValidator.validate(value!)
                      ? null
                      : "กรุณากรอกอีเมล์ให้ถูกต้อง!",

                  decoration: InputDecoration(
                    hintText: 'Email',
                    icon: const FaIcon(FontAwesomeIcons.envelope),
                  ),
                  controller: _username, // ผูกกับ TextFormField ที่จะใช้
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'กรุณากรอกข้อมูล!';
                    } else if (value.length < 6) {
                      return 'พาสเวิร์ดควรมีอักขระอย่างน้อย 6 ตัวอักษร';
                    } else if (value.length > 10) {
                      return 'พาสเวิร์ดควรมีอักขระไม่เกิน 15 ตัวอักษร';
                    } else if (!RegExp(r'^[A-Za-z0-9]+$').hasMatch(value)) {
                      return "ไม่อนุญาตภาษาไทย!";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Password 6 ตัวอักษร',
                    icon: Icon(Icons.vpn_key),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isHidden =
                              !_isHidden; // เมื่อกดก็เปลี่ยนค่าตรงกันข้าม
                        });
                      },
                      icon: Icon(_isHidden // เงื่อนไขการสลับ icon
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                  controller: _password, // ผูกกับ TextFormField ที่จะใช้
                  obscureText:
                      _isHidden, // ก่อนซ่อนหรือแสดงข้อความในรูปแบบรหัสผ่าน
                ),
                SizedBox(
                  height: 10.0,
                ),
                Visibility(
                  visible: !_registeringStatus,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // เปลี่ยนสถานะกำลังสมัครสมาชิก
                        setState(() {
                          _registeringStatus = !_registeringStatus;
                        });
                        //หากผ่าน
                        FocusScope.of(context)
                            .unfocus(); // ยกเลิดโฟกัส ให้แป้นพิมพ์ซ่อนไป

                        String memberID = _memberID.text;
                        String username = _username.text;
                        String password = _password.text;

                        // ใช้ provider ส่ง request สร้างบัญชีสมาชิกใหม่
                        var result = await userProvider.create(
                            memberID, username, password);

                        if (result['success'] != null) {
                          // สร้างบัญชีสำเร็จ
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Create new user Successful')),
                          );
                          /*      Navigator.pushReplacement(
                            // ไปหน้าล็อกอิน
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login(),
                              settings: RouteSettings(arguments: null),
                            ),
                          ); */
                        } else {
                          if (result['error'] != null) {
                            // สร้างบัญชีไม่ผ่าน
                            String error = result['error'];
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${error}..  try agin!')),
                            );
                            setState(() {
                              _registeringStatus = !_registeringStatus;
                            });
                          } else {
                            // สร้างบัญชีไม่ผ่าน อื่นๆ
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error..  try agin!')),
                            );
                            setState(() {
                              _registeringStatus = !_registeringStatus;
                            });
                          }
                        }
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: const Text('Register'),
                    ),
                  ),
                ),
                Visibility(
                  visible: _registeringStatus,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(" Registering ... Please wait")
                    ],
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
