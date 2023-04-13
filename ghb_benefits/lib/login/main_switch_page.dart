import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ghb_benefits/Nav_Bar.dart';
import 'package:ghb_benefits/login/login_page.dart';
import 'package:ghb_benefits/main_home_page.dart';



class MainSwitchPage extends StatelessWidget {
  const MainSwitchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return MainHomePage();
          } else {
            return LoginPage();
          }
          
        },
        ),
      
    );

    
  }
}