import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Child_Allowances/list_child_allowance.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Child_Allowances/list_child_allowance_where.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Cremation_Service/list_cremation_service.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Education/list_education_page.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/House_Allowance/list_house_allowance.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Medical/list_medical_page.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_child_allowance.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_cremation.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_education.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_house.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_master.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_medical.dart';
import 'package:ghb_banefits_admin/Dashborad/all_dashborad.dart';
import 'package:ghb_banefits_admin/Dashborad/child_allowances_dashborad.dart';
import 'package:ghb_banefits_admin/Dashborad/cremation_service_dashborad.dart';
import 'package:ghb_banefits_admin/Dashborad/education_dashborad.dart';
import 'package:ghb_banefits_admin/Dashborad/house_allowance_dashborad.dart';
import 'package:ghb_banefits_admin/Dashborad/list_Reports.dart';
import 'package:ghb_banefits_admin/Dashborad/medical_dashborad.dart';
import 'package:ghb_banefits_admin/firebase_options.dart';
import 'package:ghb_banefits_admin/login/main_switch_page.dart';
import 'package:ghb_banefits_admin/main_home_admin_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
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
      ChangeNotifierProvider(
          create: (context) => ChildAllowanceAdminProviders()),
      ChangeNotifierProvider(
          create: (context) => CremationServiceAdminProviders()),
      ChangeNotifierProvider(create: (context) => EducationAdminProviders()),
      ChangeNotifierProvider(
          create: (context) => HouseAllowanceAdminProviders()),
      ChangeNotifierProvider(create: (context) => MedicalAdminProviders()),
      ChangeNotifierProvider(create: (context) => EmployeeProviders()),
      ChangeNotifierProvider(create: (context) => filedEmployeeProviders()),
      ChangeNotifierProvider(create: (context) => NotificationsProviders()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application .
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,

// title: 'BELL',
        home: MainSwitchPage(),
        routes: {
          '/1': (context) => AllDashboradPage(),
          '/2': (context) => ListMedicalAdminPage(Status: "ร้องขอ"),
          '/3': (context) => ListEducationAdminPage(Status: "ร้องขอ"),
          '/4': (context) => ListChildAllowanceAdminPage(Status: "ร้องขอ"),
          '/5': (context) => ListHouseAllowanceAdminPage(Status: "ร้องขอ"),
          '/6': (context) => ListCremationServiceAdminPage(Status: "ร้องขอ"),
          '/7': (context) => ListReports(),
          '/8': (context) => MedicalDashboradPage(),
          '/9': (context) => EducationDashboradPage(),
          '/10': (context) => MyApp(),
          '/11': (context) => HouseAllowanceDashboradPage(),
          // '/12': (context) => CremationServiceDashboradPage(),
        }); // MaterialApp
  }
}
