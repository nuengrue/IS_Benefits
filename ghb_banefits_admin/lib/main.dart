import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Child_Allowances/list_child_allowance.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Cremation_Service/list_cremation_service.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Education/list_education_page.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/House_Allowance/list_house_allowance.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Medical/list_medical_page.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_child_allowance.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_cremation.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_education.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_house.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_medical.dart';
import 'package:ghb_banefits_admin/Dashborad/all_dashborad.dart';
import 'package:ghb_banefits_admin/Dashborad/child_allowances_dashborad.dart';
import 'package:ghb_banefits_admin/Dashborad/cremation_service_dashborad.dart';
import 'package:ghb_banefits_admin/Dashborad/education_dashborad.dart';
import 'package:ghb_banefits_admin/Dashborad/house_allowance_dashborad.dart';
import 'package:ghb_banefits_admin/Dashborad/medical_dashborad.dart';
import 'package:ghb_banefits_admin/firebase_options.dart';
import 'package:ghb_banefits_admin/main_home_admin_page.dart';
import 'package:provider/provider.dart';


 Future<void> main () async { 
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
     runApp(MultiProvider(
    providers: [
     ChangeNotifierProvider(create: (context) => ChildAllowanceAdminProviders()),  
     ChangeNotifierProvider(create: (context) => CremationServiceAdminProviders()),
     ChangeNotifierProvider(create: (context) => EducationAdminProviders()),
     ChangeNotifierProvider(create: (context) => HouseAllowanceAdminProviders()),
     ChangeNotifierProvider(create: (context) => MedicalAdminProviders()),
    ],
    child: MyApp(),
  ));

 } 
  class MyApp extends StatelessWidget {
     // This widget is the root of your application . 
     @override 
     Widget build (BuildContext context) {
      return MaterialApp(

title: 'BELL',
home: MainHomeAdminPage(),
routes: {
          '/1': (context) => AllDashboradPage(),
          '/2': (context) => ListMedicalAdminPage(),
          '/3': (context) => ListEducationAdminPage(),
          '/4': (context) => ListChildAllowanceAdminPage(),
          '/5': (context) => ListHouseAllowanceAdminPage(),
          '/6': (context) => ListCremationServiceAdminPage(),
          '/7': (context) => ChildAllowancesDashboradPage(),
          '/8': (context) => MedicalDashboradPage(),
          '/9': (context) => EducationDashboradPage(),
          '/10': (context) => ChildAllowancesDashboradPage(),
          '/11': (context) => HouseAllowanceDashboradPage(),
          '/12': (context) => CremationServiceDashboradPage(),          
        }
           ); // MaterialApp

       } 
       
       
       
}

