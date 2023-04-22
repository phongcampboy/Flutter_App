// ignore_for_file: prefer_const_constructors, override_on_non_overriding_member, avoid_print, unused_field, prefer_final_fields, unused_local_variable, unnecessary_null_comparison, use_build_context_synchronously, unnecessary_brace_in_string_interps, sort_child_properties_last

import 'package:app_flutter/screen/register.dart';
import 'package:app_flutter/utils/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // สร้างฟอร์ม key หรือ id ของฟอร์มสำหรับอ้างอิง
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // กำหนดสถานะการแสดงแบบรหัสผ่าน
  bool _isHidden = true;
  bool _authenticatingStatus = false;

  @override
  void dispose() {
    nameController.dispose(); // ยกเลิกการใช้งานที่เกี่ยวข้องทั้งหมดถ้ามี
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ใช้งาน provider
    UserProvider userProvider = context.read<UserProvider>();
    return Scaffold(
      appBar: AppBar(
        title: (Text("Login")),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Hispeed',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
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
                  controller:
                      passwordController, // ผูกกับ TextFormField ที่จะใช้
                  obscureText:
                      _isHidden, // ก่อนซ่อนหรือแสดงข้อความในรูปแบบรหัสผ่าน
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Login'),
                    onPressed: () async {
                      /* print(nameController.text);
                      print(passwordController.text); */
                      // อ้างอิงฟอร์มที่กำลังใช้งาน ตรวจสอบความถูกต้องข้อมูลในฟอร์ม
                      if (_formKey.currentState!.validate()) {
                        //หากผ่าน
                        FocusScope.of(context)
                            .unfocus(); // ยกเลิดโฟกัส ให้แป้นพิมพ์ซ่อนไป

                        String username = nameController.text;
                        String password = passwordController.text;
                        var result =
                            await userProvider.authen(username, password);
                        // จำลองเปรียบเทียบค่า เพื่อทำการล็อกอิน
                        if (result['success'] != null) {
                          // ล็อกอินผ่าน
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Login Successful')),
                          );
                          // Navigator.pop(context, true); // ปิดหน้านี้พร้อมคืนค่า true
                        } else {
                          if (result['error'] != null) {
                            print(result);
                            // ล็อกอินไม่ผ่านมี error
                            String error = result['error'];
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${error}..  try agin!')),
                            );
                            setState(() {
                              _authenticatingStatus = !_authenticatingStatus;
                            });
                          } else {
                            // ล็อกอินไม่ผ่าน อื่นๆ
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error..  try agin!')),
                            );
                            setState(() {
                              _authenticatingStatus = !_authenticatingStatus;
                            });
                          }
                        }
                      }
                    },
                  )),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    const Text('Does not have account?'),
                    TextButton(
                      onPressed: () async {
                        // เปิดหน้า สมัครสมาชิก โดย แทนที่ route ล็อกอินเดิม
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Register(),
                            settings: RouteSettings(arguments: null),
                          ),
                        );
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
