// ignore_for_file: prefer_const_constructors, unused_field, unused_local_variable, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
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
                  decoration: InputDecoration(
                    hintText: 'MemberID',
                    icon: Icon(Icons.email_outlined),
                  ),
                  controller: _memberID, // ผูกกับ TextFormField ที่จะใช้
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Username',
                    icon: Icon(Icons.email_outlined),
                  ),
                  controller: _username, // ผูกกับ TextFormField ที่จะใช้
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Password',
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
                      // เปลี่ยนสถานะกำลังสมัครสมาชิก
                      setState(() {
                        _registeringStatus = !_registeringStatus;
                      });

                      if (_formKey.currentState!.validate()) {
                        //หากผ่าน
                        FocusScope.of(context)
                            .unfocus(); // ยกเลิดโฟกัส ให้แป้นพิมพ์ซ่อนไป

                        String memberID = _memberID.text;
                        String username = _username.text;
                        String password = _password.text;

                        // ใช้ provider ส่ง request สร้างบัญชีสมาชิกใหม่
                        /*       var result = await userProvider.create(email, password);
 
                                    if(result['success']!=null){ // สร้างบัญชีสำเร็จ
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Create new user Successful')),
                                      );    
                                      Navigator.pushReplacement( // ไปหน้าล็อกอิน
                                          context, 
                                          MaterialPageRoute(builder: (context) => Login(),
                                            settings: RouteSettings(
                                              arguments: null
                                            ),
                                          ),
                                      );       
                                    }else{
                                      if(result['error']!=null){ // สร้างบัญชีไม่ผ่าน
                                        String error = result['error'];
                                        ScaffoldMessenger.of(context).showSnackBar(
                                           SnackBar(content: Text('${error}..  try agin!')),
                                        );
                                        setState(() {
                                          _registeringStatus = !_registeringStatus;
                                        });                                           
                                      }else{ // สร้างบัญชีไม่ผ่าน อื่นๆ 
                                        ScaffoldMessenger.of(context).showSnackBar(
                                           SnackBar(content: Text('Error..  try agin!')),
                                        );
                                        setState(() {
                                          _registeringStatus = !_registeringStatus;
                                        });                                                                                
                                      }
                                    } */
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
