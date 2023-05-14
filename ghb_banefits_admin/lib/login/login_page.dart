
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ghb_banefits_admin/color.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future singIn() async {
    try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _usernameController.text.trim(), 
      password: _passwordController.text.trim(), 
      );
      
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context, 
        builder: (context) {
          return AlertDialog(
              content: Text('กรุณาตรวจสอบข้อมูลการเข้าระบบ'),
              actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
          );
        }
        
        );
    }
  }
  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
  super.dispose();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: iWhiteColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                 Image.asset(
                            'assets/logo.png',
                            height: 150,
                          ),
                          SizedBox(height: 15),
                Text(
                          'GHB Welfare Admin',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: iBlueColor,fontFamily: 'Sarabun',
                          ),
                        ),
              // username
              SizedBox(height: 75),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: iGreyColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: iOrangeColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'ชื่อผู้ใช้งาน',
                      fillColor: iWhiteColor,
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                          // password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: iGreyColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: iOrangeColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'รหัสผ่าน',
                      fillColor: iWhiteColor,
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: singIn,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(      
                        color: iOrangeColor,
                        borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'เข้าสู่ระบบ',
                            style: TextStyle(
                              color: iWhiteColor,
                              fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                              fontSize: 18
                            ),
                          ),
                        ),
                      ),
                  ),
                  ),

              ],
            ),
          ),
        ),
      ),
    );


    
  }
}