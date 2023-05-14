import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ghb_benefits/All_Page/Child_Allowances/add_child_allowance.dart';
import 'package:ghb_benefits/All_Providers/provider_child_allowance.dart';
import 'package:ghb_benefits/All_Providers/provider_dashboard.dart';
import 'package:ghb_benefits/All_Providers/provider_master.dart';
import 'package:ghb_benefits/All_Providers/provider_notifications.dart';
import 'package:ghb_benefits/child_allowance/viewtestb.dart';
import 'package:ghb_benefits/All_Page/Cremation_Service/add_cremation_service.dart';
import 'package:ghb_benefits/All_Page/Cremation_Service/list_cremation_service.dart';
import 'package:ghb_benefits/All_Providers/provider_cremation.dart';
import 'package:ghb_benefits/All_Page/House_Allowance/add_house_allowance.dart';
import 'package:ghb_benefits/All_Providers/provider_house.dart';
import 'package:ghb_benefits/color.dart';

import 'package:ghb_benefits/login/main_switch_page.dart';
import 'package:ghb_benefits/All_Page/Medical/add_medical_page.dart';
import 'package:ghb_benefits/All_Providers/provider_medical.dart';
import 'package:ghb_benefits/All_Providers/provider_education.dart';
import 'package:ghb_benefits/All_Page/Education/add_education_page.dart';

import 'package:ghb_benefits/pdf/uploadfiles.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {

    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
    FirebaseAuth.instance
  .authStateChanges()
  .listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
      // do something when user logged out.
    } else {
      print('User is signed in!');
      // todo to load user profile.
    }
  });
    runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ChildAllowanceProviders()),  
      ChangeNotifierProvider(create: (context) => flieChildAllowanceModal()),
      ChangeNotifierProvider(create: (context) => flieCremationServiceModal()),
      ChangeNotifierProvider(create: (context) => CremationServiceProviders()),
      ChangeNotifierProvider(create: (context) => flieHouseAllowanceModal()),
      ChangeNotifierProvider(create: (context) => HouseAllowanceProviders()),
      ChangeNotifierProvider(create: (context) => MedicalProviders()),
      ChangeNotifierProvider(create: (context) => flieMedicalModal()),
      ChangeNotifierProvider(create: (context) => EducationProviders()),
      ChangeNotifierProvider(create: (context) => flieEducationModal()),
      ChangeNotifierProvider(create: (context) => MyDashboardProviders()),
      ChangeNotifierProvider(create: (context) => EmployeeProviders()),
      ChangeNotifierProvider(create: (context) => ChilderProviders()),      
      ChangeNotifierProvider(create: (context) => filedEmployeeProviders()),      
      ChangeNotifierProvider(create: (context) => NotificationsProviders()),      
    ],
    child: MyApp(),
  ));

 }

  class MyApp extends StatelessWidget {
     // This widget is the root of your application . 
     @override 
     Widget build (BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainSwitchPage(),
                theme: ThemeData(
            primaryColor: Color.fromARGB(255, 9, 28, 235),
            ),
/*
title: 'BELL',
home: NavBar(),
*/
           routes: {
          '/1': (context) => UploadFiles(),
          '/2': (context) => ListCremationServicePage(),
          '/3': (context) => ListCremationServicePage(),
          '/4': (context) => ListCremationServicePage(),
          '/5': (context) => AddHouseAllowancePage(),
          '/6': (context) => ListCremationServicePage(),
          '/7': (context) => ListCremationServicePage(),  
        //  '/7': (context) => SubDetailStatusPage(),
        //  '/8': (context) => UpdateStatusAdminPage(),
        //  '/9': (context) => DetailProfliePage(),
        //  '/10': (context) => NavBar(),

        }
        
        ); // MaterialApp

       } 
       
}

