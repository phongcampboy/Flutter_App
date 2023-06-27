// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_local_variable, unused_field, avoid_print, use_build_context_synchronously, unnecessary_brace_in_string_interps, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../utils/user_provider.dart';

class AddMember extends StatefulWidget {
  const AddMember({super.key});

  @override
  State<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  late bool _loginSuccess; // กำหดตัวแปรสถานะการล็อกอิน
  Usermodel? _user;
  String _id = '';
  // สร้างฟอร์ม key หรือ id ของฟอร์มสำหรับอ้างอิง
  final _formKey = GlobalKey<FormState>();

  // กำหนดตัวแปรรับค่า
  final _AddId = TextEditingController();

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
    });
    // ดึงข้อมูลทั่วไปของผู้ใช้
    _user = await userProvider.getUser();

    setState(() {
      _id = _user!.memberId;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ใช้งาน provider
    UserProvider userProvider = context.read<UserProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADD MEMBER'),
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
                    Text('Add ID Screen'),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอกข้อมูล!';
                        }/* else if (!RegExp(r'^[A-Za-z0-9]+$').hasMatch(value)) {
                          return "ไม่อนุญาตภาษาไทย!";
                        } */

                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'MemberID',
                        icon: const FaIcon(FontAwesomeIcons.userGear),
                      ),
                      controller: _AddId, // ผูกกับ TextFormField ที่จะใช้
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: 50,
                        width: 120,
                        padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                        child: ElevatedButton(
                          child: const Text('Submit'),
                          onPressed: () async {
                            /* print(nameController.text);
                      print(passwordController.text); */
                            // อ้างอิงฟอร์มที่กำลังใช้งาน ตรวจสอบความถูกต้องข้อมูลในฟอร์ม
                            if (_formKey.currentState!.validate()) {
                              //หากผ่าน
                              FocusScope.of(context)
                                  .unfocus(); // ยกเลิดโฟกัส ให้แป้นพิมพ์ซ่อนไป

                              String add_id = _AddId.text;
                              String idsave = _id;
                              var result = await userProvider.addmemberPlus(
                                  add_id, idsave);
                              if (result['success'] != null) {
                                // ผ่าน
                                String success = result['success'];

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('${success}')),
                                );
                                Navigator.pop(context, true);
                              } else {
                                String error = result['error'];
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('${error}')));
                              }
                            }
                          },
                        )),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
