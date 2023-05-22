import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ghb_benefits/All_Controllers/Education_Controller.dart';
import 'package:ghb_benefits/All_Controllers/Medical_Controller.dart';
import 'package:ghb_benefits/All_Controllers/Notifications_controllers.dart';
import 'package:ghb_benefits/All_Controllers/master_controllers.dart';
import 'package:ghb_benefits/All_Providers/provider_dashboard.dart';
import 'package:ghb_benefits/All_Providers/provider_education.dart';
import 'package:ghb_benefits/All_Providers/provider_master.dart';
import 'package:ghb_benefits/All_Providers/provider_medical.dart';
import 'package:ghb_benefits/All_Providers/provider_notifications.dart';
import 'package:ghb_benefits/All_Services/servics.dart';
import 'package:ghb_benefits/Notification/notifications_page.dart';
import 'package:ghb_benefits/color.dart';
import 'package:ghb_benefits/login/main_switch_page.dart';
import 'package:ghb_benefits/my_drawer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';




class MainHomePage extends StatefulWidget {
  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  //final _formKey = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser!;


 double AMedical = 40000;
 double sMedical = 0;
 double Achild = 3;
 double schild = 0;
 int    Countnotishow = 0; 
   String    _year = DateFormat.y().format(DateTime.now());

  MedicalController medicalcontroller = MedicalController(FirebaseServices());
  EducationController educationcontroller = EducationController(FirebaseServices());
  MasterController mastecontroller = MasterController(FirebaseServices());
  NotificationsController controller = NotificationsController(FirebaseServices());

  void initState() {
    super.initState();
    _getDashboard(context);
  }

  void _getDashboard(BuildContext context) async {
    // Duration(seconds: 5);
        var newMedicalDashboard = await medicalcontroller.fetchMedical();
         var wherenewMedicalDashboard = newMedicalDashboard.where((x) => x.yearmed == _year);

      //  print(newMedicalDashboard.length);
    if(wherenewMedicalDashboard.length > 0){
    // get data  MedicalDashboard
    //var newMedicalDashboard = await medicalcontroller.fetchMedical();
    context.read<MedicalProviders>().MedicalList = newMedicalDashboard;
    final medical = [];
    for (var doc in wherenewMedicalDashboard) {
      double a = double.parse(doc.payamount);
      medical.add(a);
    }
    var sumamountmedical = medical.reduce((a, b) => a + b);
        // print(sumamountmedical);
    var RemainMedical = AMedical - sumamountmedical;
    print(RemainMedical);
    context.read<MyDashboardProviders>().SumMedicalModalChoice = sumamountmedical;
    context.read<MyDashboardProviders>().RemainMedicalModalChoice = RemainMedical;
    }
    else{
    context.read<MyDashboardProviders>().SumMedicalModalChoice = sMedical;
    context.read<MyDashboardProviders>().RemainMedicalModalChoice = AMedical;
    }
        // get data  EducationDashboard
    var newEducationDashboard = await educationcontroller.fetchEducation();
           var wherenewEducationDashboard = newEducationDashboard.where((x) => x.yearedu == _year);
     //print(newEducationDashboard.length);
        if(wherenewEducationDashboard.length > 0){
    context.read<EducationProviders>().EducationList = newEducationDashboard;
    final education = [];
    for (var doc in wherenewEducationDashboard) {
      double a = double.parse(doc.payamount);
      education.add(a);
    }
    var sumamounteducation = education.reduce((a, b) => a + b);
    // print(sumamounteducation);
    var RemainEducation = AMedical - sumamounteducation;
    context.read<MyDashboardProviders>().SumEducationModalChoice = sumamounteducation;
    context.read<MyDashboardProviders>().RemainEducationModalChoice = RemainEducation;
        }
    else{
    context.read<MyDashboardProviders>().SumEducationModalChoice = sMedical;
    context.read<MyDashboardProviders>().RemainEducationModalChoice = AMedical;
    }

    var newEmployee = await mastecontroller.fetchEmployee();

    context.read<EmployeeProviders>().EmployeeList = newEmployee;
    
    //newEmployee = context.read<EmployeeProviders>().EmployeeList ;

     context.read<filedEmployeeProviders>().Empno = newEmployee.first.no;
     context.read<filedEmployeeProviders>().Empempcode = newEmployee.first.empcode;
     context.read<filedEmployeeProviders>().Empnameemp = newEmployee.first.nameemp;
     context.read<filedEmployeeProviders>().Empdepartment = newEmployee.first.department;
     context.read<filedEmployeeProviders>().Empdivisionment = newEmployee.first.divisionment;
     context.read<filedEmployeeProviders>().Empdate = newEmployee.first.date;   
     context.read<filedEmployeeProviders>().Empuid = newEmployee.first.uid;         
      //      print(context.read<filedEmployeeProviders>().Empempcode);
      // print(context.read<filedEmployeeProviders>().Empnameemp);
    var newChilder = await mastecontroller.fetchChilder();
    context.read<ChilderProviders>().ChilderList = newChilder;
    // print(newChilder);

                var newNotification = await controller.fetchNotifications();
                var countshow = newNotification.where((x) => x.read == 0);
  //               setState(() {
  // Countnotishow = countshow.length;                
  //               });
                // print(Countnotishow);
//                 int vRequests = countshow.length;
//                 print(vRequests);
//  context.read<NotificationsProviders>().countnoti = vRequests;
          context.read<NotificationsProviders>().NotificationsList = newNotification;
       context.read<NotificationsProviders>().countnoti =  context.read<NotificationsProviders>().NotificationsList.where((x) => x.read == 0).length ;

                               print(context.watch<NotificationsProviders>().countnoti.toString());
  }

  @override

 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GHB Welfare',textAlign: TextAlign.center,style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                            color: iWhiteColor,
                          ),),
      backgroundColor: iBlueColor,
      
      actions: [
        
        if(context.watch<NotificationsProviders>().countnoti > 0)...[
          
         IconButton(
                  
                        icon: Badge(badgeContent: Text(context.watch<NotificationsProviders>().countnoti.toString()),
                          child: Icon(Icons.notifications)
                          ),
                        color: iWhiteColor,
                        onPressed: () {
                            // FirebaseAuth.instance.signOut();
                            Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NotificationsPage()));
                        },
                      ),
                              IconButton(
                        icon: Icon(Icons.logout),
                        color: iWhiteColor,
                        onPressed: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MainSwitchPage()));
                        },
                      ),
        ]
                      else ...[
         IconButton(
                  
                        icon:  Icon(Icons.notifications),
                          
                        color: iWhiteColor,
                        onPressed: () {
                            // FirebaseAuth.instance.signOut();
                            Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NotificationsPage()));
                        },
                      ),
                              IconButton(
                        icon: Icon(Icons.logout),
                        color: iWhiteColor,
                        onPressed: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MainSwitchPage()));
                        },
                      ),
                        

                      ]
                // IconButton(
                  
                //         icon: Badge(badgeContent: Text(''),
                //           child: Icon(Icons.notifications)
                //           ),
                //         color: iWhiteColor,
                //         onPressed: () {
                //             // FirebaseAuth.instance.signOut();
                //             Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => NotificationsPage()));
                //         },
                //       ),

      ],),


      body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                SizedBox(height: 10),
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'สวัสดี คุณ ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: iBlueColor,fontFamily: 'Sarabun',
                          ),
                        ),
                        Text(
                          // '  ' 
                          // + 
                           //user.email! 

                                                                context
                                          .watch<filedEmployeeProviders>()
                                          .Empnameemp
                                          .toString(),
                          
                          style: TextStyle(fontSize: 18, color:iBlueColor,fontFamily: 'Sarabun',),
                        ),

                      ],
                    ),
                   
                  ],
                ),
              ),
              
              SizedBox(height: 10),
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  'My Dashboard',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                      color: iBlueColor),
                ),
              ),
            ),

            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(5.0),
                      padding: const EdgeInsets.all(5.0),
                      //height: double.infinity,
                      width: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.white,
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 6.0,
                            spreadRadius: 2.0,
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                          )
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'ค่ารักษาพยาบาล',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 9, 28, 235),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Divider(),
                          SizedBox(
                            height: 70,

                            child: PieChart(
                              PieChartData(
                                startDegreeOffset: 20,
                                sections: [
                                  //
                                   if (context.watch<MyDashboardProviders>()
                                          .RemainMedicalModalChoice != 0.0) ...[
                                  if(context.watch<MyDashboardProviders>()
                                          .RemainMedicalModalChoice == 0.0) ...[
                                  PieChartSectionData(
                                    color: Colors.blue,
                                   value:  
                                  //  39960,
                                   context
                                          .watch<MyDashboardProviders>()
                                          .RemainMedicalModalChoice,
                                    showTitle: false,
                                    radius: 10,
                                  ),
                                  PieChartSectionData(
                                    color: Colors.green,
                                    value: 
                                    // 40,
                                    context
                                          .watch<MyDashboardProviders>()
                                          .SumMedicalModalChoice,
                                    showTitle: false,
                                    radius: 10,
                                  ),

                                          ]
                                  else ...[
                                  PieChartSectionData(
                                    color: Colors.blue,
                                   value:  
                                   39960,
                                   
                                    showTitle: false,
                                    radius: 10,
                                  ),
                                  PieChartSectionData(
                                    color: Colors.green,
                                    value: 40,
                                    showTitle: false,
                                    radius: 10,
                                  ),

                                  ]
                                   ] 
                                   else if (context.watch<MyDashboardProviders>()
                                          .RemainMedicalModalChoice == 0.0) ...[
 PieChartSectionData(
                                    color: Colors.green,
                                    value: 40000,
                                    showTitle: false,
                                    radius: 10,
                                  ),
    ]
                                   else ...[
                                    
                   PieChartSectionData(
                                    color: Colors.blue,
                                    value:  40000,
                                    showTitle: false,
                                    radius: 10,
                                  ),


              ]
                                         
                                ], //
                              ),
                            ),
                          ),
                          const Divider(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'เงินที่ใช้ได้',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      context
                                          .watch<MyDashboardProviders>()
                                          .RemainMedicalModalChoice
                                          .toString(),
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'เงินที่ใช้ไป',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      context
                                          .watch<MyDashboardProviders>()
                                          .SumMedicalModalChoice
                                          .toString(),
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'วงเงินตามสิทธิ',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      AMedical.toString(),
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    ///
                    Container(
                      margin: const EdgeInsets.all(5.0),
                      padding: const EdgeInsets.all(5.0),
                      //height: double.infinity,
                      width: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.white,
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 6.0,
                            spreadRadius: 2.0,
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                          )
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'ค่าช่วยเหลือการศึกษาบุตร',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 9, 28, 235),
                              fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                            ),
                          ),
                          const Divider(),
                           SizedBox(
                            height: 70,
                            child: PieChart(
                              PieChartData(
                                startDegreeOffset: 20,
                                sections: [
                                           if (context.watch<MyDashboardProviders>()
                                          .RemainEducationModalChoice != 0.0) ...[
                                  if(context.watch<MyDashboardProviders>()
                                          .RemainEducationModalChoice == 0.0) ...[
                                  PieChartSectionData(
                                    color: Colors.blue,
                                   value:  
                                  //  39960,
                                   context
                                          .watch<MyDashboardProviders>()
                                          .RemainEducationModalChoice,
                                    showTitle: false,
                                    radius: 10,
                                  ),
                                  PieChartSectionData(
                                    color: Colors.green,
                                    value: 
                                    // 40,
                                    context
                                          .watch<MyDashboardProviders>()
                                          .SumEducationModalChoice,
                                    showTitle: false,
                                    radius: 10,
                                  ),

                                          ]
                                  else ...[
                                  PieChartSectionData(
                                    color: Colors.blue,
                                   value:  
                                   39960,
                                   
                                    showTitle: false,
                                    radius: 10,
                                  ),
                                  PieChartSectionData(
                                    color: Colors.green,
                                    value: 40,
                                    showTitle: false,
                                    radius: 10,
                                  ),

                                  ]
                                   ] 
                                   else if (context.watch<MyDashboardProviders>()
                                          .RemainEducationModalChoice == 0.0) ...[
 PieChartSectionData(
                                    color: Colors.green,
                                    value: 40000,
                                    showTitle: false,
                                    radius: 10,
                                  ),
    ]
                                   else ...[
                                    
                   PieChartSectionData(
                                    color: Colors.blue,
                                    value:  40000,
                                    showTitle: false,
                                    radius: 10,
                                  ),


              ]
                                ], //
                              ),
                            ),
                          ),
                          const Divider(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'เงินที่ใช้ได้',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      context
                                          .watch<MyDashboardProviders>()
                                          .RemainEducationModalChoice
                                          .toString(),
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'เงินที่ใช้ไป',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                           context
                                          .watch<MyDashboardProviders>()
                                          .SumEducationModalChoice
                                          .toString(),
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'วงเงินตามสิทธิ',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      AMedical.toString(),
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Text(context.watch<NotificationsProviders>().countnoti.toString())
              //          Container(
              //         margin: const EdgeInsets.all(5.0),
              //         padding: const EdgeInsets.all(5.0),
              //         //height: double.infinity,
              //         width: 400,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(5),
              //           border: Border.all(
              //             color: Colors.white,
              //           ),
              //           color: Colors.white,
              //           boxShadow: [
              //             BoxShadow(
              //               blurRadius: 6.0,
              //               spreadRadius: 2.0,
              //               color: Colors.grey,
              //               offset: Offset(0.0, 0.0),
              //             )
              //           ],
              //         ),
              //         child: Column(
              //           children: <Widget>[
              //             Text(
              //               'เงินช่วยเหลือบุตร',
              //               style: TextStyle(
              //                 fontSize: 16,
              //                 color: Color.fromARGB(255, 9, 28, 235),
              //                 fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
              //               ),
              //             ),
              //             const Divider(),
              //              SizedBox(
              //               height: 70,
              //               child: PieChart(
              //                 PieChartData(
              //                   startDegreeOffset: 20,
              //                   sections: [
              //                     //
              //                                                        if (context.watch<MyDashboardProviders>()
              //                             .RemainEducationModalChoice != 0.0) ...[
              //                     if(context.watch<MyDashboardProviders>()
              //                             .RemainEducationModalChoice == 0.0) ...[
              //                     PieChartSectionData(
              //                       color: Colors.blue,
              //                      value:  
              //                     //  39960,
              //                      context
              //                             .watch<MyDashboardProviders>()
              //                             .RemainEducationModalChoice,
              //                       showTitle: false,
              //                       radius: 10,
              //                     ),
              //                     PieChartSectionData(
              //                       color: Colors.green,
              //                       value: 
              //                       // 40,
              //                       context
              //                             .watch<MyDashboardProviders>()
              //                             .SumEducationModalChoice,
              //                       showTitle: false,
              //                       radius: 10,
              //                     ),

              //                             ]
              //                     else ...[
              //                     PieChartSectionData(
              //                       color: Colors.blue,
              //                      value:  
              //                      39960,
                                   
              //                       showTitle: false,
              //                       radius: 10,
              //                     ),
              //                     PieChartSectionData(
              //                       color: Colors.green,
              //                       value: 40,
              //                       showTitle: false,
              //                       radius: 10,
              //                     ),

              //                     ]
              //                      ] 
                                   
              //                      else ...[
              //      PieChartSectionData(
              //                       color: Colors.blue,
              //                       value:  context
              //                             .watch<MyDashboardProviders>()
              //                             .RemainEducationModalChoice,
              //                       showTitle: false,
              //                       radius: 10,
              //                     ),
              // ]
              //                   ], //
              //                 ),
              //               ),
              //             ),
              //             const Divider(),
              //             Column(
              //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //               children: [
              //                 Row(
              //                   children: [
              //                     Expanded(
              //                       child: Text(
              //                         'จำนวนบุตรที่ขอเบิกได้',
              //                         textAlign: TextAlign.left,
              //                         style: TextStyle(
              //                             fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
              //                       ),
              //                     ),
              //                     Expanded(
              //                       child: Text(
              //                         context
              //                             .watch<MyDashboardProviders>()
              //                             .RemainEducationModalChoice
              //                             .toString(),
              //                         textAlign: TextAlign.end,
              //                         style: TextStyle(
              //                           fontSize: 18,
              //                           color: Colors.blue,
              //                           fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
              //                         ),
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //                 Row(
              //                   children: [
              //                     Expanded(
              //                       child: Text(
              //                         'จำนวนบุตรที่ขอเบิก',
              //                         textAlign: TextAlign.left,
              //                         style: TextStyle(
              //                             fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
              //                       ),
              //                     ),
              //                     Expanded(
              //                       child: Text(
              //                              context
              //                             .watch<MyDashboardProviders>()
              //                             .SumEducationModalChoice
              //                             .toString(),
              //                         textAlign: TextAlign.end,
              //                         style: TextStyle(
              //                           fontSize: 18,
              //                           color: Colors.green,
              //                           fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
              //                         ),
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //                 Row(
              //                   children: [
              //                     Expanded(
              //                       child: Text(
              //                         'จำนวนบุตรตามสิทธิ์',
              //                         textAlign: TextAlign.left,
              //                         style: TextStyle(
              //                             fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
              //                       ),
              //                     ),
              //                     Expanded(
              //                       child: Text(
              //                         AMedical.toString(),
              //                         textAlign: TextAlign.end,
              //                         style: TextStyle(
              //                           fontSize: 18,
              //                           color: Colors.black,
              //                           fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
              //                         ),
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ],
              //             ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),

            ],
            
          ),

        ),
       drawer: MyDrawer(),
      //bottomNavigationBar: _buildbottomNavigationBar(),
       //bottomNavigationBar:  
       /*
       NavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      elevation: 0,
      backgroundColor: iBlueColor,
        onPressed: () {
          
          
          
        },
        child: Icon(Icons.add,size: 35,),
      ),
      */
    ); 
  }

  /*
   Widget buildcars(List<carInfo> cars) => PageView.builder(
    scrollDirection: Axis.horizontal,
    controller: _controller,
    itemCount: !cars.isEmpty ? cars.length : 1,
    itemBuilder: (context, index) {
        //return InkWell(
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        width: 300,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cars[index].Brand.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Image.asset(
                  cars[index].Img.toString(),
                  height: 50,
                )
              ],
            ),
            SizedBox(height: 10),
            Text(
              cars[index].Model.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cars[index].Color.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  cars[index].Licence.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  cars[index].Refeul.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
       // );
          },
          );
          */
}


Widget _buildbottomNavigationBar() { 
  
    int _selectedIndex = 0;
    final List<Widget> screens = [];
    
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      boxShadow: [
        BoxShadow(
          color: iGreyColor,
          spreadRadius: 5,
          blurRadius: 10
        )
      ]),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),

        ),
        
        child: BottomNavigationBar(
          backgroundColor: iWhiteColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: iOrangeColor,
          unselectedItemColor: iGreyColor,

          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home_rounded,size: 30),
               ),
                        BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(Icons.person_rounded,
              size: 30)
              ),

          ],
            currentIndex: _selectedIndex, //New
            //onTap: _onItemTapped, 
              
        ),

        
      ),

  );
  

}






// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:ghb_benefits/All_Controllers/Education_Controller.dart';
// import 'package:ghb_benefits/All_Controllers/Medical_Controller.dart';
// import 'package:ghb_benefits/All_Controllers/master_controllers.dart';
// import 'package:ghb_benefits/All_Models/employee_model.dart';
// import 'package:ghb_benefits/All_Providers/provider_dashboard.dart';
// import 'package:ghb_benefits/All_Providers/provider_education.dart';
// import 'package:ghb_benefits/All_Providers/provider_master.dart';
// import 'package:ghb_benefits/All_Providers/provider_medical.dart';
// import 'package:ghb_benefits/All_Services/servics.dart';
// import 'package:ghb_benefits/button_menu.dart';
// import 'package:ghb_benefits/color.dart';
// import 'package:ghb_benefits/login/main_switch_page.dart';
// import 'package:ghb_benefits/my_drawer.dart';
// import 'package:provider/provider.dart';




// class MainHomePage extends StatefulWidget {
//   @override
//   State<MainHomePage> createState() => _MainHomePageState();
// }

// class _MainHomePageState extends State<MainHomePage> {
//   //final _formKey = GlobalKey<FormState>();
//   final user = FirebaseAuth.instance.currentUser!;


//  double AMedical = 40000.0;
//  double sMedical = 0.0;
//  double Achild = 3;
//  double schild = 0.0;

//   MedicalController medicalcontroller = MedicalController(FirebaseServices());
//   EducationController educationcontroller = EducationController(FirebaseServices());
//   MasterController mastecontroller = MasterController(FirebaseServices());

//   void initState() {
//     super.initState();
//     _getDashboard(context);
//   }

//   void _getDashboard(BuildContext context) async {
//         var newMedicalDashboard = await medicalcontroller.fetchMedical();
//        print(newMedicalDashboard.length);
//     if(newMedicalDashboard.length > 0){
//     // get data  MedicalDashboard
//     //var newMedicalDashboard = await medicalcontroller.fetchMedical();
//     context.read<MedicalProviders>().MedicalList = newMedicalDashboard;
//     final medical = [];
//     for (var doc in newMedicalDashboard) {
//       double a = double.parse(doc.payamount);
//       medical.add(a);
//     }
//     var sumamountmedical = medical.reduce((a, b) => a + b);
//         print(sumamountmedical);
//     var RemainMedical = AMedical - sumamountmedical;
//     print(RemainMedical);
//     context.read<MyDashboardProviders>().SumMedicalModalChoice = sumamountmedical;
//     context.read<MyDashboardProviders>().RemainMedicalModalChoice = RemainMedical;
//     }
//     else{
//     context.read<MyDashboardProviders>().SumMedicalModalChoice = sMedical;
//     context.read<MyDashboardProviders>().RemainMedicalModalChoice = AMedical;
//     }
//         // get data  EducationDashboard
//     var newEducationDashboard = await educationcontroller.fetchEducation();
//      print(newEducationDashboard.length);
//         if(newEducationDashboard.length > 0){
//     context.read<EducationProviders>().EducationList = newEducationDashboard;
//     final education = [];
//     for (var doc in newEducationDashboard) {
//       double a = double.parse(doc.payamount);
//       education.add(a);
//     }
//     var sumamounteducation = education.reduce((a, b) => a + b);
//     print(sumamounteducation);
//     var RemainEducation = AMedical - sumamounteducation;
//     context.read<MyDashboardProviders>().SumEducationModalChoice = sumamounteducation;
//     context.read<MyDashboardProviders>().RemainEducationModalChoice = RemainEducation;
//         }
//     else{
//     context.read<MyDashboardProviders>().SumEducationModalChoice = sMedical;
//     context.read<MyDashboardProviders>().RemainEducationModalChoice = AMedical;
//     }

//     var newEmployee = await mastecontroller.fetchEmployee();

//     context.read<EmployeeProviders>().EmployeeList = newEmployee;
    
//     //newEmployee = context.read<EmployeeProviders>().EmployeeList ;

//      context.read<filedEmployeeProviders>().Empno = newEmployee.first.no;
//      context.read<filedEmployeeProviders>().Empempcode = newEmployee.first.empcode;
//      context.read<filedEmployeeProviders>().Empnameemp = newEmployee.first.nameemp;
//      context.read<filedEmployeeProviders>().Empdepartment = newEmployee.first.department;
//      context.read<filedEmployeeProviders>().Empdivisionment = newEmployee.first.divisionment;
//      context.read<filedEmployeeProviders>().Empdate = newEmployee.first.date;   
//      context.read<filedEmployeeProviders>().Empuid = newEmployee.first.uid;         
//       //      print(context.read<filedEmployeeProviders>().Empempcode);
//       // print(context.read<filedEmployeeProviders>().Empnameemp);
//     var newChilder = await mastecontroller.fetchChilder();
//     context.read<ChilderProviders>().ChilderList = newChilder;
//     print(newChilder);
//   }

//   @override

//  Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('GHB Benefit',textAlign: TextAlign.center,style: TextStyle(
//                             fontSize: 28,
//                             fontWeight: FontWeight.bold,
//                             color: iOrangeColor,
//                           ),),
//       backgroundColor: iBlueColor,
      
//       actions: [
//         IconButton(
//                         icon: Icon(Icons.logout),
//                         color: iWhiteColor,
//                         onPressed: () {
//                             FirebaseAuth.instance.signOut();
//                             Navigator.of(context).push(MaterialPageRoute(
//                     builder: (context) => MainSwitchPage()));
//                         },
//                       ),
//       ],),


//       body: SingleChildScrollView(

//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//                 SizedBox(height: 10),
//                 Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           'สวัสดี คุณ ',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: iBlueColor,
//                           ),
//                         ),
//                         Text(
//                           // '  ' 
//                           // + 
//                            //user.email! 

//                           context
//                                           .watch<filedEmployeeProviders>()
//                                           .Empnameemp
//                                           .toString(),
                          
//                           style: TextStyle(fontSize: 18, color:iBlueColor),
//                         ),
//                       ],
//                     ),
                   
//                   ],
//                 ),
//               ),
              
//               SizedBox(height: 10),

//             Container(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                 child: Text(
//                   'My Dashboard',
//                   textAlign: TextAlign.left,
//                   style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: iBlueColor),
//                 ),
//               ),
//             ),

// // if (context.read<MyDashboardProviders>().RemainMedicalModalChoice == 0)  ...[
//   // Padding(
//   //             padding: const EdgeInsets.all(8.0),
//   //             child: Container(
//   //               child: Column(
//   //                 mainAxisAlignment: MainAxisAlignment.center,
//   //                 children: <Widget>[
//   //                   Container(
//   //                     margin: const EdgeInsets.all(5.0),
//   //                     padding: const EdgeInsets.all(5.0),
//   //                     //height: double.infinity,
//   //                     width: 400,
//   //                     decoration: BoxDecoration(
//   //                       borderRadius: BorderRadius.circular(5),
//   //                       border: Border.all(
//   //                         color: Colors.white,
//   //                       ),
//   //                       color: Colors.white,
//   //                       boxShadow: [
//   //                         BoxShadow(
//   //                           blurRadius: 6.0,
//   //                           spreadRadius: 2.0,
//   //                           color: Colors.grey,
//   //                           offset: Offset(0.0, 0.0),
//   //                         )
//   //                       ],
//   //                     ),
//   //                     child: Column(
//   //                       children: <Widget>[
//   //                         Text(
//   //                           'ค่ารักษาพยาบาล',
//   //                           style: TextStyle(
//   //                             fontSize: 16,
//   //                             color: Color.fromARGB(255, 9, 28, 235),
//   //                             fontWeight: FontWeight.bold,
//   //                           ),
//   //                         ),
//   //                         const Divider(),
//   //                         SizedBox(
//   //                           height: 70,

//   //                           child: PieChart(
//   //                             PieChartData(
//   //                               startDegreeOffset: 20,
//   //                               sections: [
//   //                                 //
                         
//   //                                PieChartSectionData(
//   //                                   color: Colors.blue,
//   //                                  value:  200,
//   //                                   showTitle: false,
//   //                                   radius: 10,
//   //                                 ),
//   //                                 PieChartSectionData(
//   //                                   color: Colors.green,
//   //                                   value: 800,
//   //                                   showTitle: false,
//   //                                   radius: 10,
//   //                                 ),
                       
 

                                         
//   //                               ], //
//   //                             ),
//   //                           ),
//   //                         ),
//   //                         const Divider(),
//   //                         Column(
//   //                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   //                           children: [
//   //                             Row(
//   //                               children: [
//   //                                 Expanded(
//   //                                   child: Text(
//   //                                     'เงินที่ใช้ได้',
//   //                                     textAlign: TextAlign.left,
//   //                                     style: TextStyle(
//   //                                         fontWeight: FontWeight.bold),
//   //                                   ),
//   //                                 ),
//   //                                 Expanded(
//   //                                   child: Text(
//   //                                     context
//   //                                         .watch<MyDashboardProviders>()
//   //                                         .RemainMedicalModalChoice
//   //                                         .toString(),
//   //                                     textAlign: TextAlign.end,
//   //                                     style: TextStyle(
//   //                                       fontSize: 18,
//   //                                       color: Colors.blue,
//   //                                       fontWeight: FontWeight.bold,
//   //                                     ),
//   //                                   ),
//   //                                 ),
//   //                               ],
//   //                             ),
//   //                             Row(
//   //                               children: [
//   //                                 Expanded(
//   //                                   child: Text(
//   //                                     'เงินที่ใช้ไป',
//   //                                     textAlign: TextAlign.left,
//   //                                     style: TextStyle(
//   //                                         fontWeight: FontWeight.bold),
//   //                                   ),
//   //                                 ),
//   //                                 Expanded(
//   //                                   child: Text(
//   //                                     context
//   //                                         .watch<MyDashboardProviders>()
//   //                                         .SumMedicalModalChoice
//   //                                         .toString(),
//   //                                     textAlign: TextAlign.end,
//   //                                     style: TextStyle(
//   //                                       fontSize: 18,
//   //                                       color: Colors.green,
//   //                                       fontWeight: FontWeight.bold,
//   //                                     ),
//   //                                   ),
//   //                                 ),
//   //                               ],
//   //                             ),
//   //                             Row(
//   //                               children: [
//   //                                 Expanded(
//   //                                   child: Text(
//   //                                     'วงเงินตามสิทธิ',
//   //                                     textAlign: TextAlign.left,
//   //                                     style: TextStyle(
//   //                                         fontWeight: FontWeight.bold),
//   //                                   ),
//   //                                 ),
//   //                                 Expanded(
//   //                                   child: Text(
//   //                                     AMedical.toString(),
//   //                                     textAlign: TextAlign.end,
//   //                                     style: TextStyle(
//   //                                       fontSize: 18,
//   //                                       color: Colors.black,
//   //                                       fontWeight: FontWeight.bold,
//   //                                     ),
//   //                                   ),
//   //                                 ),
//   //                               ],
//   //                             ),
//   //                           ],
//   //                         ),
//   //                       ],
//   //                     ),
//   //                   ),

//   //                   ///
//   //                   Container(
//   //                     margin: const EdgeInsets.all(5.0),
//   //                     padding: const EdgeInsets.all(5.0),
//   //                     //height: double.infinity,
//   //                     width: 400,
//   //                     decoration: BoxDecoration(
//   //                       borderRadius: BorderRadius.circular(5),
//   //                       border: Border.all(
//   //                         color: Colors.white,
//   //                       ),
//   //                       color: Colors.white,
//   //                       boxShadow: [
//   //                         BoxShadow(
//   //                           blurRadius: 6.0,
//   //                           spreadRadius: 2.0,
//   //                           color: Colors.grey,
//   //                           offset: Offset(0.0, 0.0),
//   //                         )
//   //                       ],
//   //                     ),
//   //                     child: Column(
//   //                       children: <Widget>[
//   //                         Text(
//   //                           'ค่าช่วยเหลือการศึกษาบุตร',
//   //                           style: TextStyle(
//   //                             fontSize: 16,
//   //                             color: Color.fromARGB(255, 9, 28, 235),
//   //                             fontWeight: FontWeight.bold,
//   //                           ),
//   //                         ),
//   //                         const Divider(),
//   //                          SizedBox(
//   //                           height: 70,
//   //                              child: PieChart(
//   //                             PieChartData(
//   //                               startDegreeOffset: 20,
//   //                               sections: [
//   //                                 //
                         
//   //                                    PieChartSectionData(
//   //                                   color: Colors.blue,
//   //                                  value:  200,
//   //                                   showTitle: false,
//   //                                   radius: 10,
//   //                                 ),
//   //                                 PieChartSectionData(
//   //                                   color: Colors.green,
//   //                                   value: 800,
//   //                                   showTitle: false,
//   //                                   radius: 10,
//   //                                 ),
 

                                         
//   //                               ], //
//   //                             ),
//   //                           ),
//   //                         ),
//   //                         const Divider(),
//   //                         Column(
//   //                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   //                           children: [
//   //                             Row(
//   //                               children: [
//   //                                 Expanded(
//   //                                   child: Text(
//   //                                     'เงินที่ใช้ได้',
//   //                                     textAlign: TextAlign.left,
//   //                                     style: TextStyle(
//   //                                         fontWeight: FontWeight.bold),
//   //                                   ),
//   //                                 ),
//   //                                 Expanded(
//   //                                   child: Text(
//   //                                     context
//   //                                         .watch<MyDashboardProviders>()
//   //                                         .RemainEducationModalChoice
//   //                                         .toString(),
//   //                                     textAlign: TextAlign.end,
//   //                                     style: TextStyle(
//   //                                       fontSize: 18,
//   //                                       color: Colors.blue,
//   //                                       fontWeight: FontWeight.bold,
//   //                                     ),
//   //                                   ),
//   //                                 ),
//   //                               ],
//   //                             ),
//   //                             Row(
//   //                               children: [
//   //                                 Expanded(
//   //                                   child: Text(
//   //                                     'เงินที่ใช้ไป',
//   //                                     textAlign: TextAlign.left,
//   //                                     style: TextStyle(
//   //                                         fontWeight: FontWeight.bold),
//   //                                   ),
//   //                                 ),
//   //                                 Expanded(
//   //                                   child: Text(
//   //                                          context
//   //                                         .watch<MyDashboardProviders>()
//   //                                         .SumEducationModalChoice
//   //                                         .toString(),
//   //                                     textAlign: TextAlign.end,
//   //                                     style: TextStyle(
//   //                                       fontSize: 18,
//   //                                       color: Colors.green,
//   //                                       fontWeight: FontWeight.bold,
//   //                                     ),
//   //                                   ),
//   //                                 ),
//   //                               ],
//   //                             ),
//   //                             Row(
//   //                               children: [
//   //                                 Expanded(
//   //                                   child: Text(
//   //                                     'วงเงินตามสิทธิ',
//   //                                     textAlign: TextAlign.left,
//   //                                     style: TextStyle(
//   //                                         fontWeight: FontWeight.bold),
//   //                                   ),
//   //                                 ),
//   //                                 Expanded(
//   //                                   child: Text(
//   //                                     AMedical.toString(),
//   //                                     textAlign: TextAlign.end,
//   //                                     style: TextStyle(
//   //                                       fontSize: 18,
//   //                                       color: Colors.black,
//   //                                       fontWeight: FontWeight.bold,
//   //                                     ),
//   //                                   ),
//   //                                 ),
//   //                               ],
//   //                             ),
//   //                           ],
//   //                         ),
//   //                       ],
//   //                     ),
//   //                   ),
//   //                      Container(
//   //                     margin: const EdgeInsets.all(5.0),
//   //                     padding: const EdgeInsets.all(5.0),
//   //                     //height: double.infinity,
//   //                     width: 400,
//   //                     decoration: BoxDecoration(
//   //                       borderRadius: BorderRadius.circular(5),
//   //                       border: Border.all(
//   //                         color: Colors.white,
//   //                       ),
//   //                       color: Colors.white,
//   //                       boxShadow: [
//   //                         BoxShadow(
//   //                           blurRadius: 6.0,
//   //                           spreadRadius: 2.0,
//   //                           color: Colors.grey,
//   //                           offset: Offset(0.0, 0.0),
//   //                         )
//   //                       ],
//   //                     ),
//   //                     child: Column(
//   //                       children: <Widget>[
//   //                         Text(
//   //                           'เงินช่วยเหลือบุตร',
//   //                           style: TextStyle(
//   //                             fontSize: 16,
//   //                             color: Color.fromARGB(255, 9, 28, 235),
//   //                             fontWeight: FontWeight.bold,
//   //                           ),
//   //                         ),
//   //                         const Divider(),
//   //                          SizedBox(
//   //                           height: 70,
//   //                          child: PieChart(
//   //                             PieChartData(
//   //                               startDegreeOffset: 20,
//   //                               sections: [
//   //                                 //
                         
//   //                                PieChartSectionData(
//   //                                   color: Colors.blue,
//   //                                  value:  200,
//   //                                   showTitle: false,
//   //                                   radius: 10,
//   //                                 ),
//   //                                 PieChartSectionData(
//   //                                   color: Colors.green,
//   //                                   value: 800,
//   //                                   showTitle: false,
//   //                                   radius: 10,
//   //                                 ),
                       
 

                                         
//   //                               ], //
//   //                             ),
//   //                           ),
//   //                         ),
//   //                         const Divider(),
//   //                         Column(
//   //                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   //                           children: [
//   //                             Row(
//   //                               children: [
//   //                                 Expanded(
//   //                                   child: Text(
//   //                                     'จำนวนบุตรที่ขอเบิกได้',
//   //                                     textAlign: TextAlign.left,
//   //                                     style: TextStyle(
//   //                                         fontWeight: FontWeight.bold),
//   //                                   ),
//   //                                 ),
//   //                                 Expanded(
//   //                                   child: Text(
//   //                                     context
//   //                                         .watch<MyDashboardProviders>()
//   //                                         .RemainEducationModalChoice
//   //                                         .toString(),
//   //                                     textAlign: TextAlign.end,
//   //                                     style: TextStyle(
//   //                                       fontSize: 18,
//   //                                       color: Colors.blue,
//   //                                       fontWeight: FontWeight.bold,
//   //                                     ),
//   //                                   ),
//   //                                 ),
//   //                               ],
//   //                             ),
//   //                             Row(
//   //                               children: [
//   //                                 Expanded(
//   //                                   child: Text(
//   //                                     'จำนวนบุตรที่ขอเบิก',
//   //                                     textAlign: TextAlign.left,
//   //                                     style: TextStyle(
//   //                                         fontWeight: FontWeight.bold),
//   //                                   ),
//   //                                 ),
//   //                                 Expanded(
//   //                                   child: Text(
//   //                                          context
//   //                                         .watch<MyDashboardProviders>()
//   //                                         .SumEducationModalChoice
//   //                                         .toString(),
//   //                                     textAlign: TextAlign.end,
//   //                                     style: TextStyle(
//   //                                       fontSize: 18,
//   //                                       color: Colors.green,
//   //                                       fontWeight: FontWeight.bold,
//   //                                     ),
//   //                                   ),
//   //                                 ),
//   //                               ],
//   //                             ),
//   //                             Row(
//   //                               children: [
//   //                                 Expanded(
//   //                                   child: Text(
//   //                                     'จำนวนบุตรตามสิทธิ์',
//   //                                     textAlign: TextAlign.left,
//   //                                     style: TextStyle(
//   //                                         fontWeight: FontWeight.bold),
//   //                                   ),
//   //                                 ),
//   //                                 Expanded(
//   //                                   child: Text(
//   //                                     AMedical.toString(),
//   //                                     textAlign: TextAlign.end,
//   //                                     style: TextStyle(
//   //                                       fontSize: 18,
//   //                                       color: Colors.black,
//   //                                       fontWeight: FontWeight.bold,
//   //                                     ),
//   //                                   ),
//   //                                 ),
//   //                               ],
//   //                             ),
//   //                           ],
//   //                         ),
//   //                       ],
//   //                     ),
//   //                   ),
//   //                 ],
//   //               ),
//   //             ),
//   //           ),

// //  ] else ...[


//    Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Container(
//                       margin: const EdgeInsets.all(5.0),
//                       padding: const EdgeInsets.all(5.0),
//                       //height: double.infinity,
//                       width: 400,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(5),
//                         border: Border.all(
//                           color: Colors.white,
//                         ),
//                         color: Colors.white,
//                         boxShadow: [
//                           BoxShadow(
//                             blurRadius: 6.0,
//                             spreadRadius: 2.0,
//                             color: Colors.grey,
//                             offset: Offset(0.0, 0.0),
//                           )
//                         ],
//                       ),
//                       child: Column(
//                         children: <Widget>[
//                           Text(
//                             'ค่ารักษาพยาบาล',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Color.fromARGB(255, 9, 28, 235),
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const Divider(),
//                           SizedBox(
//                             height: 70,

//                             child: PieChart(
//                               PieChartData(
//                                 startDegreeOffset: 20,
//                                 sections: [
//                                   //
//                                    if (context.watch<MyDashboardProviders>()
//                                           .RemainMedicalModalChoice != 0.0) ...[
//                                   PieChartSectionData(
//                                     color: Colors.blue,
//                                    value:  context
//                                           .watch<MyDashboardProviders>()
//                                           .RemainMedicalModalChoice,
//                                     showTitle: false,
//                                     radius: 10,
//                                   ),
//                                   PieChartSectionData(
//                                     color: Colors.green,
//                                     value: context
//                                           .watch<MyDashboardProviders>()
//                                           .SumMedicalModalChoice,
//                                     showTitle: false,
//                                     radius: 10,
//                                   ),
//                                    ] 
//                                    else if (context.watch<MyDashboardProviders>()
//                                           .RemainMedicalModalChoice == 0.0) ...[
//  PieChartSectionData(
//                                     color: Colors.green,
//                                     value: context
//                                           .watch<MyDashboardProviders>()
//                                           .SumMedicalModalChoice,
//                                     showTitle: false,
//                                     radius: 10,
//                                   ),
//     ]
//                                    else ...[
                                    
//                    PieChartSectionData(
//                                     color: Colors.blue,
//                                     value:  context
//                                           .watch<MyDashboardProviders>()
//                                           .RemainEducationModalChoice,
//                                     showTitle: false,
//                                     radius: 10,
//                                   ),


//               ]
                                         
//                                 ], //
//                               ),
//                             ),
//                           ),
//                           const Divider(),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       'เงินที่ใช้ได้',
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Text(
//                                       context
//                                           .watch<MyDashboardProviders>()
//                                           .RemainMedicalModalChoice
//                                           .toString(),
//                                       textAlign: TextAlign.end,
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         color: Colors.blue,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       'เงินที่ใช้ไป',
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Text(
//                                       context
//                                           .watch<MyDashboardProviders>()
//                                           .SumMedicalModalChoice
//                                           .toString(),
//                                       textAlign: TextAlign.end,
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         color: Colors.green,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       'วงเงินตามสิทธิ',
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Text(
//                                       AMedical.toString(),
//                                       textAlign: TextAlign.end,
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),

//                     ///
//                     Container(
//                       margin: const EdgeInsets.all(5.0),
//                       padding: const EdgeInsets.all(5.0),
//                       //height: double.infinity,
//                       width: 400,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(5),
//                         border: Border.all(
//                           color: Colors.white,
//                         ),
//                         color: Colors.white,
//                         boxShadow: [
//                           BoxShadow(
//                             blurRadius: 6.0,
//                             spreadRadius: 2.0,
//                             color: Colors.grey,
//                             offset: Offset(0.0, 0.0),
//                           )
//                         ],
//                       ),
//                       child: Column(
//                         children: <Widget>[
//                           Text(
//                             'ค่าช่วยเหลือการศึกษาบุตร',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Color.fromARGB(255, 9, 28, 235),
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const Divider(),
//                            SizedBox(
//                             height: 70,
//                             child: PieChart(
//                               PieChartData(
//                                 startDegreeOffset: 20,
//                                 sections: [
//                                   //
//                                    if (context.watch<MyDashboardProviders>()
//                                           .RemainEducationModalChoice != 0.0) ...[
//                                   PieChartSectionData(
//                                     color: Colors.blue,
//                                    value:  context
//                                           .watch<MyDashboardProviders>()
//                                           .RemainEducationModalChoice,
//                                     showTitle: false,
//                                     radius: 10,
//                                   ),
//                                   PieChartSectionData(
//                                     color: Colors.green,
//                                     value: context
//                                           .watch<MyDashboardProviders>()
//                                           .SumEducationModalChoice,
//                                     showTitle: false,
//                                     radius: 10,
//                                   ),
                                  
//                                    ]
//                                      else if (context.watch<MyDashboardProviders>()
//                                           .RemainEducationModalChoice == 0.0) ...[
//  PieChartSectionData(
//                                     color: Colors.green,
//                                     value: context
//                                           .watch<MyDashboardProviders>()
//                                           .SumMedicalModalChoice,
//                                     showTitle: false,
//                                     radius: 10,
//                                   ),
//     ]
//                                     else ...[
//                    PieChartSectionData(
//                                     color: Colors.blue,
//                                     value:  context
//                                           .watch<MyDashboardProviders>()
//                                           .RemainEducationModalChoice,
//                                     showTitle: false,
//                                     radius: 10,
//                                   ),
//               ]
//                                 ], //
//                               ),
//                             ),
//                           ),
//                           const Divider(),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       'เงินที่ใช้ได้',
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Text(
//                                       context
//                                           .watch<MyDashboardProviders>()
//                                           .RemainEducationModalChoice
//                                           .toString(),
//                                       textAlign: TextAlign.end,
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         color: Colors.blue,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       'เงินที่ใช้ไป',
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Text(
//                                            context
//                                           .watch<MyDashboardProviders>()
//                                           .SumEducationModalChoice
//                                           .toString(),
//                                       textAlign: TextAlign.end,
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         color: Colors.green,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       'วงเงินตามสิทธิ',
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Text(
//                                       AMedical.toString(),
//                                       textAlign: TextAlign.end,
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                        Container(
//                       margin: const EdgeInsets.all(5.0),
//                       padding: const EdgeInsets.all(5.0),
//                       //height: double.infinity,
//                       width: 400,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(5),
//                         border: Border.all(
//                           color: Colors.white,
//                         ),
//                         color: Colors.white,
//                         boxShadow: [
//                           BoxShadow(
//                             blurRadius: 6.0,
//                             spreadRadius: 2.0,
//                             color: Colors.grey,
//                             offset: Offset(0.0, 0.0),
//                           )
//                         ],
//                       ),
//                       child: Column(
//                         children: <Widget>[
//                           Text(
//                             'เงินช่วยเหลือบุตร',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Color.fromARGB(255, 9, 28, 235),
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const Divider(),
//                            SizedBox(
//                             height: 70,
//                             child: PieChart(
//                               PieChartData(
//                                 startDegreeOffset: 20,
//                                 sections: [
//                                   //
//                                    if (context.watch<MyDashboardProviders>()
//                                           .RemainEducationModalChoice != 0.0) ...[
//                                   PieChartSectionData(
//                                     color: Colors.blue,
//                                    value:  context
//                                           .watch<MyDashboardProviders>()
//                                           .RemainEducationModalChoice,
//                                     showTitle: false,
//                                     radius: 10,
//                                   ),
//                                   PieChartSectionData(
//                                     color: Colors.green,
//                                     value: context
//                                           .watch<MyDashboardProviders>()
//                                           .SumEducationModalChoice,
//                                     showTitle: false,
//                                     radius: 10,
//                                   ),
//                                    ]   else if (context.watch<MyDashboardProviders>()
//                                           .RemainEducationModalChoice == 0.0) ...[
//  PieChartSectionData(
//                                     color: Colors.green,
//                                     value: context
//                                           .watch<MyDashboardProviders>()
//                                           .SumMedicalModalChoice,
//                                     showTitle: false,
//                                     radius: 10,
//                                   ),
//     ]
                                   
//                                    else ...[
//                    PieChartSectionData(
//                                     color: Colors.blue,
//                                     value:  context
//                                           .watch<MyDashboardProviders>()
//                                           .RemainEducationModalChoice,
//                                     showTitle: false,
//                                     radius: 10,
//                                   ),
//               ]
//                                 ], //
//                               ),
//                             ),
//                           ),
//                           const Divider(),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       'จำนวนบุตรที่ขอเบิกได้',
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Text(
//                                       context
//                                           .watch<MyDashboardProviders>()
//                                           .RemainEducationModalChoice
//                                           .toString(),
//                                       textAlign: TextAlign.end,
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         color: Colors.blue,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       'จำนวนบุตรที่ขอเบิก',
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Text(
//                                            context
//                                           .watch<MyDashboardProviders>()
//                                           .SumEducationModalChoice
//                                           .toString(),
//                                       textAlign: TextAlign.end,
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         color: Colors.green,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       'จำนวนบุตรตามสิทธิ์',
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Text(
//                                       AMedical.toString(),
//                                       textAlign: TextAlign.end,
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
// //  ]  ////--------------------------------------------

            
// //             Padding(
// //               padding: const EdgeInsets.all(8.0),
// //               child: Container(
// //                 child: Column(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: <Widget>[
// //                     Container(
// //                       margin: const EdgeInsets.all(5.0),
// //                       padding: const EdgeInsets.all(5.0),
// //                       //height: double.infinity,
// //                       width: 400,
// //                       decoration: BoxDecoration(
// //                         borderRadius: BorderRadius.circular(5),
// //                         border: Border.all(
// //                           color: Colors.white,
// //                         ),
// //                         color: Colors.white,
// //                         boxShadow: [
// //                           BoxShadow(
// //                             blurRadius: 6.0,
// //                             spreadRadius: 2.0,
// //                             color: Colors.grey,
// //                             offset: Offset(0.0, 0.0),
// //                           )
// //                         ],
// //                       ),
// //                       child: Column(
// //                         children: <Widget>[
// //                           Text(
// //                             'ค่ารักษาพยาบาล',
// //                             style: TextStyle(
// //                               fontSize: 16,
// //                               color: Color.fromARGB(255, 9, 28, 235),
// //                               fontWeight: FontWeight.bold,
// //                             ),
// //                           ),
// //                           const Divider(),
// //                           SizedBox(
// //                             height: 70,

// //                             child: PieChart(
// //                               PieChartData(
// //                                 startDegreeOffset: 20,
// //                                 sections: [
// //                                   //
// //                                    if (context.watch<MyDashboardProviders>()
// //                                           .RemainMedicalModalChoice != 0.0) ...[
// //                                   PieChartSectionData(
// //                                     color: Colors.blue,
// //                                    value:  context
// //                                           .watch<MyDashboardProviders>()
// //                                           .RemainMedicalModalChoice,
// //                                     showTitle: false,
// //                                     radius: 10,
// //                                   ),
// //                                   PieChartSectionData(
// //                                     color: Colors.green,
// //                                     value: context
// //                                           .watch<MyDashboardProviders>()
// //                                           .SumMedicalModalChoice,
// //                                     showTitle: false,
// //                                     radius: 10,
// //                                   ),
// //                                    ] 
// //                                    else if (context.watch<MyDashboardProviders>()
// //                                           .RemainMedicalModalChoice == 0.0) ...[
// //  PieChartSectionData(
// //                                     color: Colors.green,
// //                                     value: context
// //                                           .watch<MyDashboardProviders>()
// //                                           .SumMedicalModalChoice,
// //                                     showTitle: false,
// //                                     radius: 10,
// //                                   ),
// //     ]
// //                                    else ...[
                                    
// //                    PieChartSectionData(
// //                                     color: Colors.blue,
// //                                     value:  context
// //                                           .watch<MyDashboardProviders>()
// //                                           .RemainEducationModalChoice,
// //                                     showTitle: false,
// //                                     radius: 10,
// //                                   ),


// //               ]
                                         
// //                                 ], //
// //                               ),
// //                             ),
// //                           ),
// //                           const Divider(),
// //                           Column(
// //                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                             children: [
// //                               Row(
// //                                 children: [
// //                                   Expanded(
// //                                     child: Text(
// //                                       'เงินที่ใช้ได้',
// //                                       textAlign: TextAlign.left,
// //                                       style: TextStyle(
// //                                           fontWeight: FontWeight.bold),
// //                                     ),
// //                                   ),
// //                                   Expanded(
// //                                     child: Text(
// //                                       context
// //                                           .watch<MyDashboardProviders>()
// //                                           .RemainMedicalModalChoice
// //                                           .toString(),
// //                                       textAlign: TextAlign.end,
// //                                       style: TextStyle(
// //                                         fontSize: 18,
// //                                         color: Colors.blue,
// //                                         fontWeight: FontWeight.bold,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                               Row(
// //                                 children: [
// //                                   Expanded(
// //                                     child: Text(
// //                                       'เงินที่ใช้ไป',
// //                                       textAlign: TextAlign.left,
// //                                       style: TextStyle(
// //                                           fontWeight: FontWeight.bold),
// //                                     ),
// //                                   ),
// //                                   Expanded(
// //                                     child: Text(
// //                                       context
// //                                           .watch<MyDashboardProviders>()
// //                                           .SumMedicalModalChoice
// //                                           .toString(),
// //                                       textAlign: TextAlign.end,
// //                                       style: TextStyle(
// //                                         fontSize: 18,
// //                                         color: Colors.green,
// //                                         fontWeight: FontWeight.bold,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                               Row(
// //                                 children: [
// //                                   Expanded(
// //                                     child: Text(
// //                                       'วงเงินตามสิทธิ',
// //                                       textAlign: TextAlign.left,
// //                                       style: TextStyle(
// //                                           fontWeight: FontWeight.bold),
// //                                     ),
// //                                   ),
// //                                   Expanded(
// //                                     child: Text(
// //                                       AMedical.toString(),
// //                                       textAlign: TextAlign.end,
// //                                       style: TextStyle(
// //                                         fontSize: 18,
// //                                         color: Colors.black,
// //                                         fontWeight: FontWeight.bold,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                             ],
// //                           ),
// //                         ],
// //                       ),
// //                     ),

// //                     ///
// //                     Container(
// //                       margin: const EdgeInsets.all(5.0),
// //                       padding: const EdgeInsets.all(5.0),
// //                       //height: double.infinity,
// //                       width: 400,
// //                       decoration: BoxDecoration(
// //                         borderRadius: BorderRadius.circular(5),
// //                         border: Border.all(
// //                           color: Colors.white,
// //                         ),
// //                         color: Colors.white,
// //                         boxShadow: [
// //                           BoxShadow(
// //                             blurRadius: 6.0,
// //                             spreadRadius: 2.0,
// //                             color: Colors.grey,
// //                             offset: Offset(0.0, 0.0),
// //                           )
// //                         ],
// //                       ),
// //                       child: Column(
// //                         children: <Widget>[
// //                           Text(
// //                             'ค่าช่วยเหลือการศึกษาบุตร',
// //                             style: TextStyle(
// //                               fontSize: 16,
// //                               color: Color.fromARGB(255, 9, 28, 235),
// //                               fontWeight: FontWeight.bold,
// //                             ),
// //                           ),
// //                           const Divider(),
// //                            SizedBox(
// //                             height: 70,
// //                             child: PieChart(
// //                               PieChartData(
// //                                 startDegreeOffset: 20,
// //                                 sections: [
// //                                   //
// //                                    if (context.watch<MyDashboardProviders>()
// //                                           .RemainEducationModalChoice != 0.0) ...[
// //                                   PieChartSectionData(
// //                                     color: Colors.blue,
// //                                    value:  context
// //                                           .watch<MyDashboardProviders>()
// //                                           .RemainEducationModalChoice,
// //                                     showTitle: false,
// //                                     radius: 10,
// //                                   ),
// //                                   PieChartSectionData(
// //                                     color: Colors.green,
// //                                     value: context
// //                                           .watch<MyDashboardProviders>()
// //                                           .SumEducationModalChoice,
// //                                     showTitle: false,
// //                                     radius: 10,
// //                                   ),
                                  
// //                                    ]
// //                                      else if (context.watch<MyDashboardProviders>()
// //                                           .RemainEducationModalChoice == 0.0) ...[
// //  PieChartSectionData(
// //                                     color: Colors.green,
// //                                     value: context
// //                                           .watch<MyDashboardProviders>()
// //                                           .SumMedicalModalChoice,
// //                                     showTitle: false,
// //                                     radius: 10,
// //                                   ),
// //     ]
// //                                     else ...[
// //                    PieChartSectionData(
// //                                     color: Colors.blue,
// //                                     value:  context
// //                                           .watch<MyDashboardProviders>()
// //                                           .RemainEducationModalChoice,
// //                                     showTitle: false,
// //                                     radius: 10,
// //                                   ),
// //               ]
// //                                 ], //
// //                               ),
// //                             ),
// //                           ),
// //                           const Divider(),
// //                           Column(
// //                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                             children: [
// //                               Row(
// //                                 children: [
// //                                   Expanded(
// //                                     child: Text(
// //                                       'เงินที่ใช้ได้',
// //                                       textAlign: TextAlign.left,
// //                                       style: TextStyle(
// //                                           fontWeight: FontWeight.bold),
// //                                     ),
// //                                   ),
// //                                   Expanded(
// //                                     child: Text(
// //                                       context
// //                                           .watch<MyDashboardProviders>()
// //                                           .RemainEducationModalChoice
// //                                           .toString(),
// //                                       textAlign: TextAlign.end,
// //                                       style: TextStyle(
// //                                         fontSize: 18,
// //                                         color: Colors.blue,
// //                                         fontWeight: FontWeight.bold,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                               Row(
// //                                 children: [
// //                                   Expanded(
// //                                     child: Text(
// //                                       'เงินที่ใช้ไป',
// //                                       textAlign: TextAlign.left,
// //                                       style: TextStyle(
// //                                           fontWeight: FontWeight.bold),
// //                                     ),
// //                                   ),
// //                                   Expanded(
// //                                     child: Text(
// //                                            context
// //                                           .watch<MyDashboardProviders>()
// //                                           .SumEducationModalChoice
// //                                           .toString(),
// //                                       textAlign: TextAlign.end,
// //                                       style: TextStyle(
// //                                         fontSize: 18,
// //                                         color: Colors.green,
// //                                         fontWeight: FontWeight.bold,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                               Row(
// //                                 children: [
// //                                   Expanded(
// //                                     child: Text(
// //                                       'วงเงินตามสิทธิ',
// //                                       textAlign: TextAlign.left,
// //                                       style: TextStyle(
// //                                           fontWeight: FontWeight.bold),
// //                                     ),
// //                                   ),
// //                                   Expanded(
// //                                     child: Text(
// //                                       AMedical.toString(),
// //                                       textAlign: TextAlign.end,
// //                                       style: TextStyle(
// //                                         fontSize: 18,
// //                                         color: Colors.black,
// //                                         fontWeight: FontWeight.bold,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                             ],
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                        Container(
// //                       margin: const EdgeInsets.all(5.0),
// //                       padding: const EdgeInsets.all(5.0),
// //                       //height: double.infinity,
// //                       width: 400,
// //                       decoration: BoxDecoration(
// //                         borderRadius: BorderRadius.circular(5),
// //                         border: Border.all(
// //                           color: Colors.white,
// //                         ),
// //                         color: Colors.white,
// //                         boxShadow: [
// //                           BoxShadow(
// //                             blurRadius: 6.0,
// //                             spreadRadius: 2.0,
// //                             color: Colors.grey,
// //                             offset: Offset(0.0, 0.0),
// //                           )
// //                         ],
// //                       ),
// //                       child: Column(
// //                         children: <Widget>[
// //                           Text(
// //                             'เงินช่วยเหลือบุตร',
// //                             style: TextStyle(
// //                               fontSize: 16,
// //                               color: Color.fromARGB(255, 9, 28, 235),
// //                               fontWeight: FontWeight.bold,
// //                             ),
// //                           ),
// //                           const Divider(),
// //                            SizedBox(
// //                             height: 70,
// //                             child: PieChart(
// //                               PieChartData(
// //                                 startDegreeOffset: 20,
// //                                 sections: [
// //                                   //
// //                                    if (context.watch<MyDashboardProviders>()
// //                                           .RemainEducationModalChoice != 0.0) ...[
// //                                   PieChartSectionData(
// //                                     color: Colors.blue,
// //                                    value:  context
// //                                           .watch<MyDashboardProviders>()
// //                                           .RemainEducationModalChoice,
// //                                     showTitle: false,
// //                                     radius: 10,
// //                                   ),
// //                                   PieChartSectionData(
// //                                     color: Colors.green,
// //                                     value: context
// //                                           .watch<MyDashboardProviders>()
// //                                           .SumEducationModalChoice,
// //                                     showTitle: false,
// //                                     radius: 10,
// //                                   ),
// //                                    ]   else if (context.watch<MyDashboardProviders>()
// //                                           .RemainEducationModalChoice == 0.0) ...[
// //  PieChartSectionData(
// //                                     color: Colors.green,
// //                                     value: context
// //                                           .watch<MyDashboardProviders>()
// //                                           .SumMedicalModalChoice,
// //                                     showTitle: false,
// //                                     radius: 10,
// //                                   ),
// //     ]
                                   
// //                                    else ...[
// //                    PieChartSectionData(
// //                                     color: Colors.blue,
// //                                     value:  context
// //                                           .watch<MyDashboardProviders>()
// //                                           .RemainEducationModalChoice,
// //                                     showTitle: false,
// //                                     radius: 10,
// //                                   ),
// //               ]
// //                                 ], //
// //                               ),
// //                             ),
// //                           ),
// //                           const Divider(),
// //                           Column(
// //                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                             children: [
// //                               Row(
// //                                 children: [
// //                                   Expanded(
// //                                     child: Text(
// //                                       'จำนวนบุตรที่ขอเบิกได้',
// //                                       textAlign: TextAlign.left,
// //                                       style: TextStyle(
// //                                           fontWeight: FontWeight.bold),
// //                                     ),
// //                                   ),
// //                                   Expanded(
// //                                     child: Text(
// //                                       context
// //                                           .watch<MyDashboardProviders>()
// //                                           .RemainEducationModalChoice
// //                                           .toString(),
// //                                       textAlign: TextAlign.end,
// //                                       style: TextStyle(
// //                                         fontSize: 18,
// //                                         color: Colors.blue,
// //                                         fontWeight: FontWeight.bold,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                               Row(
// //                                 children: [
// //                                   Expanded(
// //                                     child: Text(
// //                                       'จำนวนบุตรที่ขอเบิก',
// //                                       textAlign: TextAlign.left,
// //                                       style: TextStyle(
// //                                           fontWeight: FontWeight.bold),
// //                                     ),
// //                                   ),
// //                                   Expanded(
// //                                     child: Text(
// //                                            context
// //                                           .watch<MyDashboardProviders>()
// //                                           .SumEducationModalChoice
// //                                           .toString(),
// //                                       textAlign: TextAlign.end,
// //                                       style: TextStyle(
// //                                         fontSize: 18,
// //                                         color: Colors.green,
// //                                         fontWeight: FontWeight.bold,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                               Row(
// //                                 children: [
// //                                   Expanded(
// //                                     child: Text(
// //                                       'จำนวนบุตรตามสิทธิ์',
// //                                       textAlign: TextAlign.left,
// //                                       style: TextStyle(
// //                                           fontWeight: FontWeight.bold),
// //                                     ),
// //                                   ),
// //                                   Expanded(
// //                                     child: Text(
// //                                       AMedical.toString(),
// //                                       textAlign: TextAlign.end,
// //                                       style: TextStyle(
// //                                         fontSize: 18,
// //                                         color: Colors.black,
// //                                         fontWeight: FontWeight.bold,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                             ],
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //  ],
//              ],
            
//           ),

//         ),
//        drawer: MyDrawer(),
//       //bottomNavigationBar: _buildbottomNavigationBar(),
//        //bottomNavigationBar:  
//        /*
//        NavBar(),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: FloatingActionButton(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10)
//       ),
//       elevation: 0,
//       backgroundColor: iBlueColor,
//         onPressed: () {
          
          
          
//         },
//         child: Icon(Icons.add,size: 35,),
//       ),
//       */
//     ); 
//   }

//   /*
//    Widget buildcars(List<carInfo> cars) => PageView.builder(
//     scrollDirection: Axis.horizontal,
//     controller: _controller,
//     itemCount: !cars.isEmpty ? cars.length : 1,
//     itemBuilder: (context, index) {
//         //return InkWell(
//     return  Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 25),
//       child: Container(
//         width: 300,
//         padding: EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           color: Colors.blue,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   cars[index].Brand.toString(),
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//                 Image.asset(
//                   cars[index].Img.toString(),
//                   height: 50,
//                 )
//               ],
//             ),
//             SizedBox(height: 10),
//             Text(
//               cars[index].Model.toString(),
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 24,
//               ),
//             ),
//             SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   cars[index].Color.toString(),
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//                 Text(
//                   cars[index].Licence.toString(),
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//                 Text(
//                   cars[index].Refeul.toString(),
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//        // );

//           },
//           );
//           */
// }


// Widget _buildbottomNavigationBar() { 
  
//     int _selectedIndex = 0;
//     final List<Widget> screens = [];
    
//   return Container(
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(30),
//         topRight: Radius.circular(30),
//       ),
//       boxShadow: [
//         BoxShadow(
//           color: iGreyColor,
//           spreadRadius: 5,
//           blurRadius: 10
//         )
//       ]),
//       child: ClipRRect(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(30),
//           topRight: Radius.circular(30),

//         ),
        
//         child: BottomNavigationBar(
//           backgroundColor: iWhiteColor,
//           showSelectedLabels: false,
//           showUnselectedLabels: false,
//           selectedItemColor: iOrangeColor,
//           unselectedItemColor: iGreyColor,

//           items: [
//             BottomNavigationBarItem(
//               label: 'Home',
//               icon: Icon(Icons.home_rounded,size: 30),
//                ),
//                         BottomNavigationBarItem(
//               label: 'Profile',
//               icon: Icon(Icons.person_rounded,
//               size: 30)
//               ),

//           ],
//             currentIndex: _selectedIndex, //New
//             //onTap: _onItemTapped, 
              
//         ),

        
//       ),

//   );
  

// }







// /*


//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('GHB Benefits'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               margin: const EdgeInsets.all(10.0),
//               padding: const EdgeInsets.all(10.0),
//               //height: double.infinity,
//               width: 450,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(5),
//                 border: Border.all(
//                   color: Colors.white,
//                 ),
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     blurRadius: 6.0,
//                     spreadRadius: 2.0,
//                     color: Colors.grey,
//                     offset: Offset(0.0, 0.0),
//                   )
//                 ],
//               ),
//               child: Column(
//                 children: <Widget>[
//                   Text(
//                     'ค่ารักษาพยาบาล',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Color.fromARGB(255, 9, 28, 235),
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const Divider(),
//                           SizedBox(
//                             height: 100,
//                             child: PieChart(
//                               PieChartData(
//                                 sections: [
//                                   //
//                                   PieChartSectionData(
//                                     color: Colors.blue,
//                                     value: 80,
//                                     showTitle: false,
//                                     radius: 25,
//                                   ),
//                                   PieChartSectionData(
//                                     color: Colors.green,
//                                     value: 20,
//                                     showTitle: false,
//                                     radius: 25,
//                                   ),
//                                 ], //
//                               ),
//                             ),
//                           ),
//                   const Divider(),
//                   Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Column(
//                                   children: [
//                                     const Text(
//                                       'เงินที่ใช้ได้',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     const Text(''),
//                                     const Text(
//                                       '32,000',
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         color: Colors.blue,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                                             Column(
//                                   children: [
//                                     const Text(
//                                       'เงินที่ใช้ไป',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     const Text(''),
//                                     const Text(
//                                       '8,000',
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         color: Colors.green,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                  Column(
//                                   children: [
//                                     const Text(
//                                       'วงเงินตามสิทธิ',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     const Text(''),
//                                     const Text(
//                                       '40,000',
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ), 
//                                 ],   
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                          Padding(
//                            padding: const EdgeInsets.all(8.0),
//                            child: ElevatedButton(
//                               onPressed: () {
//                                 Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (context) => AddMedPage()));
//                               },
//                               child: const Text('ยื่นคำขอเบิกค่ารักษาพยาบาล'),
//                             ),
//                          ),  
//                           ],                 
//                   ),
//                 ],
//               ),
//             ),
 
//             ///
//             Container(
//               margin: const EdgeInsets.all(10.0),
//               padding: const EdgeInsets.all(10.0),
//               //height: double.infinity,
//               width: 450,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(5),
//                 border: Border.all(
//                   color: Colors.white,
//                 ),
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     blurRadius: 6.0,
//                     spreadRadius: 2.0,
//                     color: Colors.grey,
//                     offset: Offset(0.0, 0.0),
//                   )
//                 ],
//               ),
//               child: Column(
//                 children: <Widget>[
//                   Text(
//                     'ค่าช่วยเหลือการศึกษาบุตร',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Color.fromARGB(255, 9, 28, 235),
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const Divider(),
//                           SizedBox(
//                             height: 100,
//                             child: PieChart(
//                               PieChartData(
//                                 sections: [
//                                   //
//                                   PieChartSectionData(
//                                     color: Colors.blue,
//                                     value: 80,
//                                     showTitle: false,
//                                     radius: 25,
//                                   ),
//                                   PieChartSectionData(
//                                     color: Colors.green,
//                                     value: 20,
//                                     showTitle: false,
//                                     radius: 25,
//                                   ),
//                                 ], //
//                               ),
//                             ),
//                           ),
//                   const Divider(),
//                   Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Column(
//                                   children: [
//                                     const Text(
//                                       'เงินที่ใช้ได้',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     const Text(''),
//                                     const Text(
//                                       '32,000',
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         color: Colors.blue,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                                             Column(
//                                   children: [
//                                     const Text(
//                                       'เงินที่ใช้ไป',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     const Text(''),
//                                     const Text(
//                                       '8,000',
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         color: Colors.green,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                  Column(
//                                   children: [
//                                     const Text(
//                                       'วงเงินตามสิทธิ',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     const Text(''),
//                                     const Text(
//                                       '40,000',
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ), 
//                                 ],   
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                          Padding(
//                            padding: const EdgeInsets.all(8.0),
//                            child: ElevatedButton(
//                               onPressed: () {
//                                 Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (context) => AddEduPage()));
//                               },
//                               child: const Text('ยื่นคำขอเบิกค่าช่วยเหลือการศึกษาบุตร'),
//                             ),
//                          ),  
//                           ],                 
//                   ),
//                 ],
//               ),
//             ),

 

   
 
  
   

// ////end
//           ],
//         ),
//       ),
//     );
//   }
// }

// void _onItemTapped(int index) {
//   setState(() {
//     _selectedIndex = index;
//   });
// }
// */



// import 'dart:developer';

// import 'package:badges/badges.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:ghb_benefits/All_Controllers/Education_Controller.dart';
// import 'package:ghb_benefits/All_Controllers/Medical_Controller.dart';
// import 'package:ghb_benefits/All_Controllers/Notifications_controllers.dart';
// import 'package:ghb_benefits/All_Controllers/child_allowance_controllers.dart';
// import 'package:ghb_benefits/All_Controllers/master_controllers.dart';
// import 'package:ghb_benefits/All_Providers/provider_dashboard.dart';
// import 'package:ghb_benefits/All_Providers/provider_education.dart';
// import 'package:ghb_benefits/All_Providers/provider_master.dart';
// import 'package:ghb_benefits/All_Providers/provider_medical.dart';
// import 'package:ghb_benefits/All_Providers/provider_notifications.dart';
// import 'package:ghb_benefits/All_Services/servics.dart';
// import 'package:ghb_benefits/Notification/notifications_page.dart';
// import 'package:ghb_benefits/color.dart';
// import 'package:ghb_benefits/login/main_switch_page.dart';
// import 'package:ghb_benefits/my_drawer.dart';
// import 'package:provider/provider.dart';




// class MainHomePage extends StatefulWidget {
//   @override
//   State<MainHomePage> createState() => _MainHomePageState();
// }

// class _MainHomePageState extends State<MainHomePage> {
//   //final _formKey = GlobalKey<FormState>();
//   final user = FirebaseAuth.instance.currentUser!;


//  double AMedical = 40000;
//  double sMedical = 0;
//  double Achild = 3;
//  double schild = 0;
//  int    Countnotishow = 0; 

//   MedicalController medicalcontroller = MedicalController(FirebaseServices());
//   EducationController educationcontroller = EducationController(FirebaseServices());
//   MasterController mastecontroller = MasterController(FirebaseServices());
//   NotificationsController controller = NotificationsController(FirebaseServices());
//   ChildAllowanceController childcontroller =
//       ChildAllowanceController(FirebaseServices());
//   void initState() {
//     super.initState();
//     _getDashboard(context);
//   }

//   void _getDashboard(BuildContext context) async {
//     // Duration(seconds: 5);
//         var newMedicalDashboard = await medicalcontroller.fetchMedical();
//       //  print(newMedicalDashboard.length);
//     if(newMedicalDashboard.length > 0){
//     // get data  MedicalDashboard
//     //var newMedicalDashboard = await medicalcontroller.fetchMedical();
//               var nnewMedicalDashboarddApp = newMedicalDashboard.where((x) => x.status == "อนุมัติ");
//     context.read<MedicalProviders>().MedicalList = newMedicalDashboard;
//     final medical = [];
//     for (var doc in nnewMedicalDashboarddApp) {
//       double a = double.parse(doc.payamount);
//       medical.add(a);
//     }
//     var sumamountmedical = medical.reduce((a, b) => a + b);
//         // print(sumamountmedical);
//     var RemainMedical = AMedical - sumamountmedical;
//     print(RemainMedical);
//     context.read<MyDashboardProviders>().SumMedicalModalChoice = sumamountmedical;
//     context.read<MyDashboardProviders>().RemainMedicalModalChoice = RemainMedical;
//     }
//     else{
//     context.read<MyDashboardProviders>().SumMedicalModalChoice = sMedical;
//     context.read<MyDashboardProviders>().RemainMedicalModalChoice = AMedical;
//     }
//         // get data  EducationDashboard
//     var newEducationDashboard = await educationcontroller.fetchEducation();
//      //print(newEducationDashboard.length);
//         if(newEducationDashboard.length > 0){
//           var newEducationDashboardApp = newEducationDashboard.where((x) => x.status == "อนุมัติ");
//     context.read<EducationProviders>().EducationList = newEducationDashboard;
//     final education = [];
//     for (var doc in newEducationDashboardApp) {
//       double a = double.parse(doc.payamount);
//       education.add(a);
//     }
//     var sumamounteducation = education.reduce((a, b) => a + b);
//     // print(sumamounteducation);
//     var RemainEducation = AMedical - sumamounteducation;
//     context.read<MyDashboardProviders>().SumEducationModalChoice = sumamounteducation;
//     context.read<MyDashboardProviders>().RemainEducationModalChoice = RemainEducation;
//         }
//     else{
//     context.read<MyDashboardProviders>().SumEducationModalChoice = sMedical;
//     context.read<MyDashboardProviders>().RemainEducationModalChoice = AMedical;
//     }
//     // var newChildAllowanceDashboard = await childcontroller.fetchChildAllowance();
//      //print(newEducationDashboard.length);
// //         if(newChildAllowanceDashboard.length > 0){
// //           var newEducationDashboardApp = newChildAllowanceDashboard.where((x) => x.status == "อนุมัติ");

// //     int sumchilddd = newEducationDashboardApp.length;
// // double sumchild (sumchilddd.toDouble());
// //     // double ff = double.parse(sumchild);
// //     // print(sumamounteducation);
// //     double Remainchild = AMedical - sumchild;
// //     context.read<MyDashboardProviders>().SumchildnModalChoice = sumchild;
// //     context.read<MyDashboardProviders>().RemainchildModalChoice = Remainchild;
// //         }
// //     else{
// //     context.read<MyDashboardProviders>().SumchildnModalChoice = schild;
// //     context.read<MyDashboardProviders>().RemainchildModalChoice = Achild;
// //     }


//     var newEmployee = await mastecontroller.fetchEmployee();

//     context.read<EmployeeProviders>().EmployeeList = newEmployee;
//         print(newEmployee.length);
//     //newEmployee = context.read<EmployeeProviders>().EmployeeList ;

//      context.read<filedEmployeeProviders>().Empno = newEmployee.first.no;
//      context.read<filedEmployeeProviders>().Empempcode = newEmployee.first.empcode;
//      context.read<filedEmployeeProviders>().Empnameemp = newEmployee.first.nameemp;
//      context.read<filedEmployeeProviders>().Empdepartment = newEmployee.first.department;
//      context.read<filedEmployeeProviders>().Empdivisionment = newEmployee.first.divisionment;
//      context.read<filedEmployeeProviders>().Empdate = newEmployee.first.date;   
//      context.read<filedEmployeeProviders>().Empuid = newEmployee.first.uid;         
//       //      print(context.read<filedEmployeeProviders>().Empempcode);
//       print(context.read<filedEmployeeProviders>().Empnameemp);
//     var newChilder = await mastecontroller.fetchChilder();
//     context.read<ChilderProviders>().ChilderList = newChilder;
//     // print(newChilder);

//                 var newNotification = await controller.fetchNotifications();
//                 var countshow = newNotification.where((x) => x.read == 0);
//   //               setState(() {
//   // Countnotishow = countshow.length;                
//   //               });
//                 // print(Countnotishow);
// //                 int vRequests = countshow.length;
// //                 print(vRequests);
// //  context.read<NotificationsProviders>().countnoti = vRequests;
//           context.read<NotificationsProviders>().NotificationsList = newNotification;
//        context.read<NotificationsProviders>().countnoti =  context.read<NotificationsProviders>().NotificationsList.where((x) => x.read == 0).length ;

//                                print(context.watch<NotificationsProviders>().countnoti.toString());
//   }

//   @override

//  Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('GHB Welfare',textAlign: TextAlign.center,style: TextStyle(
//                             fontSize: 28,
//                             fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
//                             color: iWhiteColor,
//                           ),),
//       backgroundColor: iBlueColor,
      
//       actions: [
        
//         if(context.watch<NotificationsProviders>().countnoti > 0)...[
          
//          IconButton(
                  
//                         icon: Badge(badgeContent: Text(context.watch<NotificationsProviders>().countnoti.toString()),
//                           child: Icon(Icons.notifications)
//                           ),
//                         color: iWhiteColor,
//                         onPressed: () {
//                             // FirebaseAuth.instance.signOut();
//                             Navigator.of(context).push(MaterialPageRoute(
//                     builder: (context) => NotificationsPage()));
//                         },
//                       ),
//                               IconButton(
//                         icon: Icon(Icons.logout),
//                         color: iWhiteColor,
//                         onPressed: () {
//                             FirebaseAuth.instance.signOut();
//                             Navigator.of(context).push(MaterialPageRoute(
//                     builder: (context) => MainSwitchPage()));
//                         },
//                       ),
//         ]
//                       else ...[
//          IconButton(
                  
//                         icon:  Icon(Icons.notifications),
                          
//                         color: iWhiteColor,
//                         onPressed: () {
//                             // FirebaseAuth.instance.signOut();
//                             Navigator.of(context).push(MaterialPageRoute(
//                     builder: (context) => NotificationsPage()));
//                         },
//                       ),
//                               IconButton(
//                         icon: Icon(Icons.logout),
//                         color: iWhiteColor,
//                         onPressed: () {
//                             FirebaseAuth.instance.signOut();
//                             Navigator.of(context).push(MaterialPageRoute(
//                     builder: (context) => MainSwitchPage()));
//                         },
//                       ),
                        

//                       ]
//                 // IconButton(
                  
//                 //         icon: Badge(badgeContent: Text(''),
//                 //           child: Icon(Icons.notifications)
//                 //           ),
//                 //         color: iWhiteColor,
//                 //         onPressed: () {
//                 //             // FirebaseAuth.instance.signOut();
//                 //             Navigator.of(context).push(MaterialPageRoute(
//                 //     builder: (context) => NotificationsPage()));
//                 //         },
//                 //       ),

//       ],),


//       body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//                 SizedBox(height: 10),
//                 Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           'สวัสดี คุณ ',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: iBlueColor,fontFamily: 'Sarabun',
//                           ),
//                         ),
//                         Text(
//                           // '  ' 
//                           // + 
//                            //user.email! 

//                                                                 context
//                                           .watch<filedEmployeeProviders>()
//                                           .Empnameemp
//                                           .toString(),
                          
//                           style: TextStyle(fontSize: 18, color:iBlueColor,fontFamily: 'Sarabun',),
//                         ),

//                       ],
//                     ),
                   
//                   ],
//                 ),
//               ),
              
//               SizedBox(height: 10),
//             Container(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                 child: Text(
//                   'My Dashboard',
//                   textAlign: TextAlign.left,
//                   style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
//                       color: iBlueColor),
//                 ),
//               ),
//             ),

            
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Container(
//                       margin: const EdgeInsets.all(5.0),
//                       padding: const EdgeInsets.all(5.0),
//                       //height: double.infinity,
//                       width: 400,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(5),
//                         border: Border.all(
//                           color: Colors.white,
//                         ),
//                         color: Colors.white,
//                         boxShadow: [
//                           BoxShadow(
//                             blurRadius: 6.0,
//                             spreadRadius: 2.0,
//                             color: Colors.grey,
//                             offset: Offset(0.0, 0.0),
//                           )
//                         ],
//                       ),
//                       child: Column(
//                         children: <Widget>[
//                           Text(
//                             'ค่ารักษาพยาบาล',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Color.fromARGB(255, 9, 28, 235),
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const Divider(),
//                           SizedBox(
//                             height: 70,

//                             child: PieChart(
//                               PieChartData(
//                                 startDegreeOffset: 20,
//                                 sections: [
//                                   //
//                                    if (context.watch<MyDashboardProviders>()
//                                           .RemainMedicalModalChoice != 0.0) ...[
//                                   if(context.watch<MyDashboardProviders>()
//                                           .RemainMedicalModalChoice == 0.0) ...[
//                                   PieChartSectionData(
//                                     color: Colors.blue,
//                                    value:  
//                                   //  39960,
//                                    context
//                                           .watch<MyDashboardProviders>()
//                                           .RemainMedicalModalChoice,
//                                     showTitle: false,
//                                     radius: 10,
//                                   ),
//                                   PieChartSectionData(
//                                     color: Colors.green,
//                                     value: 
//                                     // 40,
//                                     context
//                                           .watch<MyDashboardProviders>()
//                                           .SumMedicalModalChoice,
//                                     showTitle: false,
//                                     radius: 10,
//                                   ),

//                                           ]
//                                   else ...[
//                                   PieChartSectionData(
//                                     color: Colors.blue,
//                                    value:  
//                                    39960,
                                   
//                                     showTitle: false,
//                                     radius: 10,
//                                   ),
//                                   PieChartSectionData(
//                                     color: Colors.green,
//                                     value: 40,
//                                     showTitle: false,
//                                     radius: 10,
//                                   ),

//                                   ]
//                                    ] 
//                                    else if (context.watch<MyDashboardProviders>()
//                                           .SumMedicalModalChoice == 40000.0) ...[
//  PieChartSectionData(
//                                     color: Colors.green,
//                                     value: 40000,
//                                     showTitle: false,
//                                     radius: 10,
//                                   ),
//     ]
//                                    else ...[
                                    
//                    PieChartSectionData(
//                                     color: Colors.blue,
//                                     value:  40000,
//                                     showTitle: false,
//                                     radius: 10,
//                                   ),


//               ]
                                         
//                                 ], //
//                               ),
//                             ),
//                           ),
//                           const Divider(),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       'เงินที่ใช้ได้',
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Text(
//                                       context
//                                           .watch<MyDashboardProviders>()
//                                           .RemainMedicalModalChoice
//                                           .toString(),
//                                       textAlign: TextAlign.end,
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         color: Colors.blue,
//                                         fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       'เงินที่ใช้ไป',
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Text(
//                                       context
//                                           .watch<MyDashboardProviders>()
//                                           .SumMedicalModalChoice
//                                           .toString(),
//                                       textAlign: TextAlign.end,
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         color: Colors.green,
//                                         fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       'วงเงินตามสิทธิ',
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Text(
//                                       AMedical.toString(),
//                                       textAlign: TextAlign.end,
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),

//                     ///
//                     Container(
//                       margin: const EdgeInsets.all(5.0),
//                       padding: const EdgeInsets.all(5.0),
//                       //height: double.infinity,
//                       width: 400,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(5),
//                         border: Border.all(
//                           color: Colors.white,
//                         ),
//                         color: Colors.white,
//                         boxShadow: [
//                           BoxShadow(
//                             blurRadius: 6.0,
//                             spreadRadius: 2.0,
//                             color: Colors.grey,
//                             offset: Offset(0.0, 0.0),
//                           )
//                         ],
//                       ),
//                       child: Column(
//                         children: <Widget>[
//                           Text(
//                             'ค่าช่วยเหลือการศึกษาบุตร',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Color.fromARGB(255, 9, 28, 235),
//                               fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
//                             ),
//                           ),
//                           const Divider(),
//                            SizedBox(
//                             height: 70,
//                             child: PieChart(
//                               PieChartData(
//                                 startDegreeOffset: 20,
//                                 sections: [
//                                     if (context.watch<MyDashboardProviders>()
//                                           .RemainEducationModalChoice != 0.0) ...[
//                                   if(context.watch<MyDashboardProviders>()
//                                           .RemainEducationModalChoice == 0.0) ...[
//                                   PieChartSectionData(
//                                     color: Colors.blue,
//                                    value:  
//                                   //  39960,
//                                    context
//                                           .watch<MyDashboardProviders>()
//                                           .RemainEducationModalChoice,
//                                     showTitle: false,
//                                     radius: 10,
//                                   ),
//                                   PieChartSectionData(
//                                     color: Colors.green,
//                                     value: 
//                                     // 40,
//                                     context
//                                           .watch<MyDashboardProviders>()
//                                           .SumEducationModalChoice,
//                                     showTitle: false,
//                                     radius: 10,
//                                   ),

//                                           ]
//                                   else ...[
//                                   PieChartSectionData(
//                                     color: Colors.blue,
//                                    value:  
//                                    39960,
                                   
//                                     showTitle: false,
//                                     radius: 10,
//                                   ),
//                                   PieChartSectionData(
//                                     color: Colors.green,
//                                     value: 40,
//                                     showTitle: false,
//                                     radius: 10,
//                                   ),

//                                   ]
//                                    ] 
//                                   //

//                                     else ...[
//                    PieChartSectionData(
//                                     color: Colors.blue,
//                                     value:  context
//                                           .watch<MyDashboardProviders>()
//                                           .RemainEducationModalChoice,
//                                     showTitle: false,
//                                     radius: 10,
//                                   ),
//               ]
//                                 ], //
//                               ),
//                             ),
//                           ),
//                           const Divider(),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       'เงินที่ใช้ได้',
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Text(
//                                       context
//                                           .watch<MyDashboardProviders>()
//                                           .RemainEducationModalChoice
//                                           .toString(),
//                                       textAlign: TextAlign.end,
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         color: Colors.blue,
//                                         fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       'เงินที่ใช้ไป',
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Text(
//                                            context
//                                           .watch<MyDashboardProviders>()
//                                           .SumEducationModalChoice
//                                           .toString(),
//                                       textAlign: TextAlign.end,
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         color: Colors.green,
//                                         fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       'วงเงินตามสิทธิ',
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Text(
//                                       AMedical.toString(),
//                                       textAlign: TextAlign.end,
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Text(context.watch<NotificationsProviders>().countnoti.toString())
//                        Container(
//                       margin: const EdgeInsets.all(5.0),
//                       padding: const EdgeInsets.all(5.0),
//                       //height: double.infinity,
//                       width: 400,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(5),
//                         border: Border.all(
//                           color: Colors.white,
//                         ),
//                         color: Colors.white,
//                         boxShadow: [
//                           BoxShadow(
//                             blurRadius: 6.0,
//                             spreadRadius: 2.0,
//                             color: Colors.grey,
//                             offset: Offset(0.0, 0.0),
//                           )
//                         ],
//                       ),
//                       child: Column(
//                         children: <Widget>[
//                           Text(
//                             'เงินช่วยเหลือบุตร',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Color.fromARGB(255, 9, 28, 235),
//                               fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
//                             ),
//                           ),
//                           const Divider(),
//                            SizedBox(
//                             height: 70,
//                             child: PieChart(
//                               PieChartData(
//                                 startDegreeOffset: 20,
//                                 sections: [
//                                   //
//                                                                      if (context.watch<MyDashboardProviders>()
//                                           .RemainchildModalChoice != 0.0) ...[
//                                   if(context.watch<MyDashboardProviders>()
//                                           .RemainchildModalChoice == 0.0) ...[
//                                   PieChartSectionData(
//                                     color: Colors.blue,
//                                    value:  
//                                   //  39960,
//                                    context
//                                           .watch<MyDashboardProviders>()
//                                           .RemainchildModalChoice,
//                                     showTitle: false,
//                                     radius: 10,
//                                   ),
//                                   PieChartSectionData(
//                                     color: Colors.green,
//                                     value: 
//                                     // 40,
//                                     context
//                                           .watch<MyDashboardProviders>()
//                                           .SumchildnModalChoice,
//                                     showTitle: false,
//                                     radius: 10,
//                                   ),

//                                           ]
//                                   else ...[
//                                   PieChartSectionData(
//                                     color: Colors.blue,
//                                    value:  
//                                    39960,
                                   
//                                     showTitle: false,
//                                     radius: 10,
//                                   ),
//                                   PieChartSectionData(
//                                     color: Colors.green,
//                                     value: 40,
//                                     showTitle: false,
//                                     radius: 10,
//                                   ),

//                                   ]
//                                    ] 
                                   
//                                    else ...[
//                    PieChartSectionData(
//                                     color: Colors.blue,
//                                     value:  context
//                                           .watch<MyDashboardProviders>()
//                                           .RemainchildModalChoice,
//                                     showTitle: false,
//                                     radius: 10,
//                                   ),
//               ]
//                                 ], //
//                               ),
//                             ),
//                           ),
//                           const Divider(),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       'จำนวนบุตรที่ขอเบิกได้',
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Text(
//                                       context
//                                           .watch<MyDashboardProviders>()
//                                           .RemainchildModalChoice
//                                           .toString(),
//                                       textAlign: TextAlign.end,
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         color: Colors.blue,
//                                         fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       'จำนวนบุตรที่ขอเบิก',
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Text(
//                                            context
//                                           .watch<MyDashboardProviders>()
//                                           .SumchildnModalChoice
//                                           .toString(),
//                                       textAlign: TextAlign.end,
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         color: Colors.green,
//                                         fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       'จำนวนบุตรตามสิทธิ์',
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Text(
//                                       Achild.toString(),
//                                       textAlign: TextAlign.end,
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             ],
            
//           ),

//         ),
//        drawer: MyDrawer(),
//       //bottomNavigationBar: _buildbottomNavigationBar(),
//        //bottomNavigationBar:  
//        /*
//        NavBar(),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: FloatingActionButton(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10)
//       ),
//       elevation: 0,
//       backgroundColor: iBlueColor,
//         onPressed: () {
          
          
          
//         },
//         child: Icon(Icons.add,size: 35,),
//       ),
//       */
//     ); 
//   }

//   /*
//    Widget buildcars(List<carInfo> cars) => PageView.builder(
//     scrollDirection: Axis.horizontal,
//     controller: _controller,
//     itemCount: !cars.isEmpty ? cars.length : 1,
//     itemBuilder: (context, index) {
//         //return InkWell(
//     return  Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 25),
//       child: Container(
//         width: 300,
//         padding: EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           color: Colors.blue,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   cars[index].Brand.toString(),
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//                 Image.asset(
//                   cars[index].Img.toString(),
//                   height: 50,
//                 )
//               ],
//             ),
//             SizedBox(height: 10),
//             Text(
//               cars[index].Model.toString(),
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 24,
//               ),
//             ),
//             SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   cars[index].Color.toString(),
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//                 Text(
//                   cars[index].Licence.toString(),
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//                 Text(
//                   cars[index].Refeul.toString(),
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//        // );
//           },
//           );
//           */
// }


// Widget _buildbottomNavigationBar() { 
  
//     int _selectedIndex = 0;
//     final List<Widget> screens = [];
    
//   return Container(
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(30),
//         topRight: Radius.circular(30),
//       ),
//       boxShadow: [
//         BoxShadow(
//           color: iGreyColor,
//           spreadRadius: 5,
//           blurRadius: 10
//         )
//       ]),
//       child: ClipRRect(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(30),
//           topRight: Radius.circular(30),

//         ),
        
//         child: BottomNavigationBar(
//           backgroundColor: iWhiteColor,
//           showSelectedLabels: false,
//           showUnselectedLabels: false,
//           selectedItemColor: iOrangeColor,
//           unselectedItemColor: iGreyColor,

//           items: [
//             BottomNavigationBarItem(
//               label: 'Home',
//               icon: Icon(Icons.home_rounded,size: 30),
//                ),
//                         BottomNavigationBarItem(
//               label: 'Profile',
//               icon: Icon(Icons.person_rounded,
//               size: 30)
//               ),

//           ],
//             currentIndex: _selectedIndex, //New
//             //onTap: _onItemTapped, 
              
//         ),

        
//       ),

//   );
  

// }






// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:fl_chart/fl_chart.dart';
// // import 'package:flutter/material.dart';
// // import 'package:ghb_benefits/All_Controllers/Education_Controller.dart';
// // import 'package:ghb_benefits/All_Controllers/Medical_Controller.dart';
// // import 'package:ghb_benefits/All_Controllers/master_controllers.dart';
// // import 'package:ghb_benefits/All_Models/employee_model.dart';
// // import 'package:ghb_benefits/All_Providers/provider_dashboard.dart';
// // import 'package:ghb_benefits/All_Providers/provider_education.dart';
// // import 'package:ghb_benefits/All_Providers/provider_master.dart';
// // import 'package:ghb_benefits/All_Providers/provider_medical.dart';
// // import 'package:ghb_benefits/All_Services/servics.dart';
// // import 'package:ghb_benefits/button_menu.dart';
// // import 'package:ghb_benefits/color.dart';
// // import 'package:ghb_benefits/login/main_switch_page.dart';
// // import 'package:ghb_benefits/my_drawer.dart';
// // import 'package:provider/provider.dart';




// // class MainHomePage extends StatefulWidget {
// //   @override
// //   State<MainHomePage> createState() => _MainHomePageState();
// // }

// // class _MainHomePageState extends State<MainHomePage> {
// //   //final _formKey = GlobalKey<FormState>();
// //   final user = FirebaseAuth.instance.currentUser!;


// //  double AMedical = 40000.0;
// //  double sMedical = 0.0;
// //  double Achild = 3;
// //  double schild = 0.0;

// //   MedicalController medicalcontroller = MedicalController(FirebaseServices());
// //   EducationController educationcontroller = EducationController(FirebaseServices());
// //   MasterController mastecontroller = MasterController(FirebaseServices());

// //   void initState() {
// //     super.initState();
// //     _getDashboard(context);
// //   }

// //   void _getDashboard(BuildContext context) async {
// //         var newMedicalDashboard = await medicalcontroller.fetchMedical();
// //        print(newMedicalDashboard.length);
// //     if(newMedicalDashboard.length > 0){
// //     // get data  MedicalDashboard
// //     //var newMedicalDashboard = await medicalcontroller.fetchMedical();
// //     context.read<MedicalProviders>().MedicalList = newMedicalDashboard;
// //     final medical = [];
// //     for (var doc in newMedicalDashboard) {
// //       double a = double.parse(doc.payamount);
// //       medical.add(a);
// //     }
// //     var sumamountmedical = medical.reduce((a, b) => a + b);
// //         print(sumamountmedical);
// //     var RemainMedical = AMedical - sumamountmedical;
// //     print(RemainMedical);
// //     context.read<MyDashboardProviders>().SumMedicalModalChoice = sumamountmedical;
// //     context.read<MyDashboardProviders>().RemainMedicalModalChoice = RemainMedical;
// //     }
// //     else{
// //     context.read<MyDashboardProviders>().SumMedicalModalChoice = sMedical;
// //     context.read<MyDashboardProviders>().RemainMedicalModalChoice = AMedical;
// //     }
// //         // get data  EducationDashboard
// //     var newEducationDashboard = await educationcontroller.fetchEducation();
// //      print(newEducationDashboard.length);
// //         if(newEducationDashboard.length > 0){
// //     context.read<EducationProviders>().EducationList = newEducationDashboard;
// //     final education = [];
// //     for (var doc in newEducationDashboard) {
// //       double a = double.parse(doc.payamount);
// //       education.add(a);
// //     }
// //     var sumamounteducation = education.reduce((a, b) => a + b);
// //     print(sumamounteducation);
// //     var RemainEducation = AMedical - sumamounteducation;
// //     context.read<MyDashboardProviders>().SumEducationModalChoice = sumamounteducation;
// //     context.read<MyDashboardProviders>().RemainEducationModalChoice = RemainEducation;
// //         }
// //     else{
// //     context.read<MyDashboardProviders>().SumEducationModalChoice = sMedical;
// //     context.read<MyDashboardProviders>().RemainEducationModalChoice = AMedical;
// //     }

// //     var newEmployee = await mastecontroller.fetchEmployee();

// //     context.read<EmployeeProviders>().EmployeeList = newEmployee;
    
// //     //newEmployee = context.read<EmployeeProviders>().EmployeeList ;

// //      context.read<filedEmployeeProviders>().Empno = newEmployee.first.no;
// //      context.read<filedEmployeeProviders>().Empempcode = newEmployee.first.empcode;
// //      context.read<filedEmployeeProviders>().Empnameemp = newEmployee.first.nameemp;
// //      context.read<filedEmployeeProviders>().Empdepartment = newEmployee.first.department;
// //      context.read<filedEmployeeProviders>().Empdivisionment = newEmployee.first.divisionment;
// //      context.read<filedEmployeeProviders>().Empdate = newEmployee.first.date;   
// //      context.read<filedEmployeeProviders>().Empuid = newEmployee.first.uid;         
// //       //      print(context.read<filedEmployeeProviders>().Empempcode);
// //       // print(context.read<filedEmployeeProviders>().Empnameemp);
// //     var newChilder = await mastecontroller.fetchChilder();
// //     context.read<ChilderProviders>().ChilderList = newChilder;
// //     print(newChilder);
// //   }

// //   @override

// //  Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text('GHB Benefit',textAlign: TextAlign.center,style: TextStyle(
// //                             fontSize: 28,
// //                             fontWeight: FontWeight.bold,
// //                             color: iOrangeColor,
// //                           ),),
// //       backgroundColor: iBlueColor,
      
// //       actions: [
// //         IconButton(
// //                         icon: Icon(Icons.logout),
// //                         color: iWhiteColor,
// //                         onPressed: () {
// //                             FirebaseAuth.instance.signOut();
// //                             Navigator.of(context).push(MaterialPageRoute(
// //                     builder: (context) => MainSwitchPage()));
// //                         },
// //                       ),
// //       ],),


// //       body: SingleChildScrollView(

// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //                 SizedBox(height: 10),
// //                 Padding(
// //                 padding: const EdgeInsets.symmetric(horizontal: 25.0),
// //                 child: Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     Row(
// //                       children: [
// //                         Text(
// //                           'สวัสดี คุณ ',
// //                           style: TextStyle(
// //                             fontSize: 18,
// //                             fontWeight: FontWeight.bold,
// //                             color: iBlueColor,
// //                           ),
// //                         ),
// //                         Text(
// //                           // '  ' 
// //                           // + 
// //                            //user.email! 

// //                           context
// //                                           .watch<filedEmployeeProviders>()
// //                                           .Empnameemp
// //                                           .toString(),
                          
// //                           style: TextStyle(fontSize: 18, color:iBlueColor),
// //                         ),
// //                       ],
// //                     ),
                   
// //                   ],
// //                 ),
// //               ),
              
// //               SizedBox(height: 10),

// //             Container(
// //               child: Padding(
// //                 padding: const EdgeInsets.symmetric(horizontal: 25.0),
// //                 child: Text(
// //                   'My Dashboard',
// //                   textAlign: TextAlign.left,
// //                   style: TextStyle(
// //                       fontSize: 20,
// //                       fontWeight: FontWeight.bold,
// //                       color: iBlueColor),
// //                 ),
// //               ),
// //             ),

// // // if (context.read<MyDashboardProviders>().RemainMedicalModalChoice == 0)  ...[
// //   // Padding(
// //   //             padding: const EdgeInsets.all(8.0),
// //   //             child: Container(
// //   //               child: Column(
// //   //                 mainAxisAlignment: MainAxisAlignment.center,
// //   //                 children: <Widget>[
// //   //                   Container(
// //   //                     margin: const EdgeInsets.all(5.0),
// //   //                     padding: const EdgeInsets.all(5.0),
// //   //                     //height: double.infinity,
// //   //                     width: 400,
// //   //                     decoration: BoxDecoration(
// //   //                       borderRadius: BorderRadius.circular(5),
// //   //                       border: Border.all(
// //   //                         color: Colors.white,
// //   //                       ),
// //   //                       color: Colors.white,
// //   //                       boxShadow: [
// //   //                         BoxShadow(
// //   //                           blurRadius: 6.0,
// //   //                           spreadRadius: 2.0,
// //   //                           color: Colors.grey,
// //   //                           offset: Offset(0.0, 0.0),
// //   //                         )
// //   //                       ],
// //   //                     ),
// //   //                     child: Column(
// //   //                       children: <Widget>[
// //   //                         Text(
// //   //                           'ค่ารักษาพยาบาล',
// //   //                           style: TextStyle(
// //   //                             fontSize: 16,
// //   //                             color: Color.fromARGB(255, 9, 28, 235),
// //   //                             fontWeight: FontWeight.bold,
// //   //                           ),
// //   //                         ),
// //   //                         const Divider(),
// //   //                         SizedBox(
// //   //                           height: 70,

// //   //                           child: PieChart(
// //   //                             PieChartData(
// //   //                               startDegreeOffset: 20,
// //   //                               sections: [
// //   //                                 //
                         
// //   //                                PieChartSectionData(
// //   //                                   color: Colors.blue,
// //   //                                  value:  200,
// //   //                                   showTitle: false,
// //   //                                   radius: 10,
// //   //                                 ),
// //   //                                 PieChartSectionData(
// //   //                                   color: Colors.green,
// //   //                                   value: 800,
// //   //                                   showTitle: false,
// //   //                                   radius: 10,
// //   //                                 ),
                       
 

                                         
// //   //                               ], //
// //   //                             ),
// //   //                           ),
// //   //                         ),
// //   //                         const Divider(),
// //   //                         Column(
// //   //                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //   //                           children: [
// //   //                             Row(
// //   //                               children: [
// //   //                                 Expanded(
// //   //                                   child: Text(
// //   //                                     'เงินที่ใช้ได้',
// //   //                                     textAlign: TextAlign.left,
// //   //                                     style: TextStyle(
// //   //                                         fontWeight: FontWeight.bold),
// //   //                                   ),
// //   //                                 ),
// //   //                                 Expanded(
// //   //                                   child: Text(
// //   //                                     context
// //   //                                         .watch<MyDashboardProviders>()
// //   //                                         .RemainMedicalModalChoice
// //   //                                         .toString(),
// //   //                                     textAlign: TextAlign.end,
// //   //                                     style: TextStyle(
// //   //                                       fontSize: 18,
// //   //                                       color: Colors.blue,
// //   //                                       fontWeight: FontWeight.bold,
// //   //                                     ),
// //   //                                   ),
// //   //                                 ),
// //   //                               ],
// //   //                             ),
// //   //                             Row(
// //   //                               children: [
// //   //                                 Expanded(
// //   //                                   child: Text(
// //   //                                     'เงินที่ใช้ไป',
// //   //                                     textAlign: TextAlign.left,
// //   //                                     style: TextStyle(
// //   //                                         fontWeight: FontWeight.bold),
// //   //                                   ),
// //   //                                 ),
// //   //                                 Expanded(
// //   //                                   child: Text(
// //   //                                     context
// //   //                                         .watch<MyDashboardProviders>()
// //   //                                         .SumMedicalModalChoice
// //   //                                         .toString(),
// //   //                                     textAlign: TextAlign.end,
// //   //                                     style: TextStyle(
// //   //                                       fontSize: 18,
// //   //                                       color: Colors.green,
// //   //                                       fontWeight: FontWeight.bold,
// //   //                                     ),
// //   //                                   ),
// //   //                                 ),
// //   //                               ],
// //   //                             ),
// //   //                             Row(
// //   //                               children: [
// //   //                                 Expanded(
// //   //                                   child: Text(
// //   //                                     'วงเงินตามสิทธิ',
// //   //                                     textAlign: TextAlign.left,
// //   //                                     style: TextStyle(
// //   //                                         fontWeight: FontWeight.bold),
// //   //                                   ),
// //   //                                 ),
// //   //                                 Expanded(
// //   //                                   child: Text(
// //   //                                     AMedical.toString(),
// //   //                                     textAlign: TextAlign.end,
// //   //                                     style: TextStyle(
// //   //                                       fontSize: 18,
// //   //                                       color: Colors.black,
// //   //                                       fontWeight: FontWeight.bold,
// //   //                                     ),
// //   //                                   ),
// //   //                                 ),
// //   //                               ],
// //   //                             ),
// //   //                           ],
// //   //                         ),
// //   //                       ],
// //   //                     ),
// //   //                   ),

// //   //                   ///
// //   //                   Container(
// //   //                     margin: const EdgeInsets.all(5.0),
// //   //                     padding: const EdgeInsets.all(5.0),
// //   //                     //height: double.infinity,
// //   //                     width: 400,
// //   //                     decoration: BoxDecoration(
// //   //                       borderRadius: BorderRadius.circular(5),
// //   //                       border: Border.all(
// //   //                         color: Colors.white,
// //   //                       ),
// //   //                       color: Colors.white,
// //   //                       boxShadow: [
// //   //                         BoxShadow(
// //   //                           blurRadius: 6.0,
// //   //                           spreadRadius: 2.0,
// //   //                           color: Colors.grey,
// //   //                           offset: Offset(0.0, 0.0),
// //   //                         )
// //   //                       ],
// //   //                     ),
// //   //                     child: Column(
// //   //                       children: <Widget>[
// //   //                         Text(
// //   //                           'ค่าช่วยเหลือการศึกษาบุตร',
// //   //                           style: TextStyle(
// //   //                             fontSize: 16,
// //   //                             color: Color.fromARGB(255, 9, 28, 235),
// //   //                             fontWeight: FontWeight.bold,
// //   //                           ),
// //   //                         ),
// //   //                         const Divider(),
// //   //                          SizedBox(
// //   //                           height: 70,
// //   //                              child: PieChart(
// //   //                             PieChartData(
// //   //                               startDegreeOffset: 20,
// //   //                               sections: [
// //   //                                 //
                         
// //   //                                    PieChartSectionData(
// //   //                                   color: Colors.blue,
// //   //                                  value:  200,
// //   //                                   showTitle: false,
// //   //                                   radius: 10,
// //   //                                 ),
// //   //                                 PieChartSectionData(
// //   //                                   color: Colors.green,
// //   //                                   value: 800,
// //   //                                   showTitle: false,
// //   //                                   radius: 10,
// //   //                                 ),
 

                                         
// //   //                               ], //
// //   //                             ),
// //   //                           ),
// //   //                         ),
// //   //                         const Divider(),
// //   //                         Column(
// //   //                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //   //                           children: [
// //   //                             Row(
// //   //                               children: [
// //   //                                 Expanded(
// //   //                                   child: Text(
// //   //                                     'เงินที่ใช้ได้',
// //   //                                     textAlign: TextAlign.left,
// //   //                                     style: TextStyle(
// //   //                                         fontWeight: FontWeight.bold),
// //   //                                   ),
// //   //                                 ),
// //   //                                 Expanded(
// //   //                                   child: Text(
// //   //                                     context
// //   //                                         .watch<MyDashboardProviders>()
// //   //                                         .RemainEducationModalChoice
// //   //                                         .toString(),
// //   //                                     textAlign: TextAlign.end,
// //   //                                     style: TextStyle(
// //   //                                       fontSize: 18,
// //   //                                       color: Colors.blue,
// //   //                                       fontWeight: FontWeight.bold,
// //   //                                     ),
// //   //                                   ),
// //   //                                 ),
// //   //                               ],
// //   //                             ),
// //   //                             Row(
// //   //                               children: [
// //   //                                 Expanded(
// //   //                                   child: Text(
// //   //                                     'เงินที่ใช้ไป',
// //   //                                     textAlign: TextAlign.left,
// //   //                                     style: TextStyle(
// //   //                                         fontWeight: FontWeight.bold),
// //   //                                   ),
// //   //                                 ),
// //   //                                 Expanded(
// //   //                                   child: Text(
// //   //                                          context
// //   //                                         .watch<MyDashboardProviders>()
// //   //                                         .SumEducationModalChoice
// //   //                                         .toString(),
// //   //                                     textAlign: TextAlign.end,
// //   //                                     style: TextStyle(
// //   //                                       fontSize: 18,
// //   //                                       color: Colors.green,
// //   //                                       fontWeight: FontWeight.bold,
// //   //                                     ),
// //   //                                   ),
// //   //                                 ),
// //   //                               ],
// //   //                             ),
// //   //                             Row(
// //   //                               children: [
// //   //                                 Expanded(
// //   //                                   child: Text(
// //   //                                     'วงเงินตามสิทธิ',
// //   //                                     textAlign: TextAlign.left,
// //   //                                     style: TextStyle(
// //   //                                         fontWeight: FontWeight.bold),
// //   //                                   ),
// //   //                                 ),
// //   //                                 Expanded(
// //   //                                   child: Text(
// //   //                                     AMedical.toString(),
// //   //                                     textAlign: TextAlign.end,
// //   //                                     style: TextStyle(
// //   //                                       fontSize: 18,
// //   //                                       color: Colors.black,
// //   //                                       fontWeight: FontWeight.bold,
// //   //                                     ),
// //   //                                   ),
// //   //                                 ),
// //   //                               ],
// //   //                             ),
// //   //                           ],
// //   //                         ),
// //   //                       ],
// //   //                     ),
// //   //                   ),
// //   //                      Container(
// //   //                     margin: const EdgeInsets.all(5.0),
// //   //                     padding: const EdgeInsets.all(5.0),
// //   //                     //height: double.infinity,
// //   //                     width: 400,
// //   //                     decoration: BoxDecoration(
// //   //                       borderRadius: BorderRadius.circular(5),
// //   //                       border: Border.all(
// //   //                         color: Colors.white,
// //   //                       ),
// //   //                       color: Colors.white,
// //   //                       boxShadow: [
// //   //                         BoxShadow(
// //   //                           blurRadius: 6.0,
// //   //                           spreadRadius: 2.0,
// //   //                           color: Colors.grey,
// //   //                           offset: Offset(0.0, 0.0),
// //   //                         )
// //   //                       ],
// //   //                     ),
// //   //                     child: Column(
// //   //                       children: <Widget>[
// //   //                         Text(
// //   //                           'เงินช่วยเหลือบุตร',
// //   //                           style: TextStyle(
// //   //                             fontSize: 16,
// //   //                             color: Color.fromARGB(255, 9, 28, 235),
// //   //                             fontWeight: FontWeight.bold,
// //   //                           ),
// //   //                         ),
// //   //                         const Divider(),
// //   //                          SizedBox(
// //   //                           height: 70,
// //   //                          child: PieChart(
// //   //                             PieChartData(
// //   //                               startDegreeOffset: 20,
// //   //                               sections: [
// //   //                                 //
                         
// //   //                                PieChartSectionData(
// //   //                                   color: Colors.blue,
// //   //                                  value:  200,
// //   //                                   showTitle: false,
// //   //                                   radius: 10,
// //   //                                 ),
// //   //                                 PieChartSectionData(
// //   //                                   color: Colors.green,
// //   //                                   value: 800,
// //   //                                   showTitle: false,
// //   //                                   radius: 10,
// //   //                                 ),
                       
 

                                         
// //   //                               ], //
// //   //                             ),
// //   //                           ),
// //   //                         ),
// //   //                         const Divider(),
// //   //                         Column(
// //   //                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //   //                           children: [
// //   //                             Row(
// //   //                               children: [
// //   //                                 Expanded(
// //   //                                   child: Text(
// //   //                                     'จำนวนบุตรที่ขอเบิกได้',
// //   //                                     textAlign: TextAlign.left,
// //   //                                     style: TextStyle(
// //   //                                         fontWeight: FontWeight.bold),
// //   //                                   ),
// //   //                                 ),
// //   //                                 Expanded(
// //   //                                   child: Text(
// //   //                                     context
// //   //                                         .watch<MyDashboardProviders>()
// //   //                                         .RemainEducationModalChoice
// //   //                                         .toString(),
// //   //                                     textAlign: TextAlign.end,
// //   //                                     style: TextStyle(
// //   //                                       fontSize: 18,
// //   //                                       color: Colors.blue,
// //   //                                       fontWeight: FontWeight.bold,
// //   //                                     ),
// //   //                                   ),
// //   //                                 ),
// //   //                               ],
// //   //                             ),
// //   //                             Row(
// //   //                               children: [
// //   //                                 Expanded(
// //   //                                   child: Text(
// //   //                                     'จำนวนบุตรที่ขอเบิก',
// //   //                                     textAlign: TextAlign.left,
// //   //                                     style: TextStyle(
// //   //                                         fontWeight: FontWeight.bold),
// //   //                                   ),
// //   //                                 ),
// //   //                                 Expanded(
// //   //                                   child: Text(
// //   //                                          context
// //   //                                         .watch<MyDashboardProviders>()
// //   //                                         .SumEducationModalChoice
// //   //                                         .toString(),
// //   //                                     textAlign: TextAlign.end,
// //   //                                     style: TextStyle(
// //   //                                       fontSize: 18,
// //   //                                       color: Colors.green,
// //   //                                       fontWeight: FontWeight.bold,
// //   //                                     ),
// //   //                                   ),
// //   //                                 ),
// //   //                               ],
// //   //                             ),
// //   //                             Row(
// //   //                               children: [
// //   //                                 Expanded(
// //   //                                   child: Text(
// //   //                                     'จำนวนบุตรตามสิทธิ์',
// //   //                                     textAlign: TextAlign.left,
// //   //                                     style: TextStyle(
// //   //                                         fontWeight: FontWeight.bold),
// //   //                                   ),
// //   //                                 ),
// //   //                                 Expanded(
// //   //                                   child: Text(
// //   //                                     AMedical.toString(),
// //   //                                     textAlign: TextAlign.end,
// //   //                                     style: TextStyle(
// //   //                                       fontSize: 18,
// //   //                                       color: Colors.black,
// //   //                                       fontWeight: FontWeight.bold,
// //   //                                     ),
// //   //                                   ),
// //   //                                 ),
// //   //                               ],
// //   //                             ),
// //   //                           ],
// //   //                         ),
// //   //                       ],
// //   //                     ),
// //   //                   ),
// //   //                 ],
// //   //               ),
// //   //             ),
// //   //           ),

// // //  ] else ...[


// //    Padding(
// //               padding: const EdgeInsets.all(8.0),
// //               child: Container(
// //                 child: Column(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: <Widget>[
// //                     Container(
// //                       margin: const EdgeInsets.all(5.0),
// //                       padding: const EdgeInsets.all(5.0),
// //                       //height: double.infinity,
// //                       width: 400,
// //                       decoration: BoxDecoration(
// //                         borderRadius: BorderRadius.circular(5),
// //                         border: Border.all(
// //                           color: Colors.white,
// //                         ),
// //                         color: Colors.white,
// //                         boxShadow: [
// //                           BoxShadow(
// //                             blurRadius: 6.0,
// //                             spreadRadius: 2.0,
// //                             color: Colors.grey,
// //                             offset: Offset(0.0, 0.0),
// //                           )
// //                         ],
// //                       ),
// //                       child: Column(
// //                         children: <Widget>[
// //                           Text(
// //                             'ค่ารักษาพยาบาล',
// //                             style: TextStyle(
// //                               fontSize: 16,
// //                               color: Color.fromARGB(255, 9, 28, 235),
// //                               fontWeight: FontWeight.bold,
// //                             ),
// //                           ),
// //                           const Divider(),
// //                           SizedBox(
// //                             height: 70,

// //                             child: PieChart(
// //                               PieChartData(
// //                                 startDegreeOffset: 20,
// //                                 sections: [
// //                                   //
// //                                    if (context.watch<MyDashboardProviders>()
// //                                           .RemainMedicalModalChoice != 0.0) ...[
// //                                   PieChartSectionData(
// //                                     color: Colors.blue,
// //                                    value:  context
// //                                           .watch<MyDashboardProviders>()
// //                                           .RemainMedicalModalChoice,
// //                                     showTitle: false,
// //                                     radius: 10,
// //                                   ),
// //                                   PieChartSectionData(
// //                                     color: Colors.green,
// //                                     value: context
// //                                           .watch<MyDashboardProviders>()
// //                                           .SumMedicalModalChoice,
// //                                     showTitle: false,
// //                                     radius: 10,
// //                                   ),
// //                                    ] 
// //                                    else if (context.watch<MyDashboardProviders>()
// //                                           .RemainMedicalModalChoice == 0.0) ...[
// //  PieChartSectionData(
// //                                     color: Colors.green,
// //                                     value: context
// //                                           .watch<MyDashboardProviders>()
// //                                           .SumMedicalModalChoice,
// //                                     showTitle: false,
// //                                     radius: 10,
// //                                   ),
// //     ]
// //                                    else ...[
                                    
// //                    PieChartSectionData(
// //                                     color: Colors.blue,
// //                                     value:  context
// //                                           .watch<MyDashboardProviders>()
// //                                           .RemainEducationModalChoice,
// //                                     showTitle: false,
// //                                     radius: 10,
// //                                   ),


// //               ]
                                         
// //                                 ], //
// //                               ),
// //                             ),
// //                           ),
// //                           const Divider(),
// //                           Column(
// //                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                             children: [
// //                               Row(
// //                                 children: [
// //                                   Expanded(
// //                                     child: Text(
// //                                       'เงินที่ใช้ได้',
// //                                       textAlign: TextAlign.left,
// //                                       style: TextStyle(
// //                                           fontWeight: FontWeight.bold),
// //                                     ),
// //                                   ),
// //                                   Expanded(
// //                                     child: Text(
// //                                       context
// //                                           .watch<MyDashboardProviders>()
// //                                           .RemainMedicalModalChoice
// //                                           .toString(),
// //                                       textAlign: TextAlign.end,
// //                                       style: TextStyle(
// //                                         fontSize: 18,
// //                                         color: Colors.blue,
// //                                         fontWeight: FontWeight.bold,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                               Row(
// //                                 children: [
// //                                   Expanded(
// //                                     child: Text(
// //                                       'เงินที่ใช้ไป',
// //                                       textAlign: TextAlign.left,
// //                                       style: TextStyle(
// //                                           fontWeight: FontWeight.bold),
// //                                     ),
// //                                   ),
// //                                   Expanded(
// //                                     child: Text(
// //                                       context
// //                                           .watch<MyDashboardProviders>()
// //                                           .SumMedicalModalChoice
// //                                           .toString(),
// //                                       textAlign: TextAlign.end,
// //                                       style: TextStyle(
// //                                         fontSize: 18,
// //                                         color: Colors.green,
// //                                         fontWeight: FontWeight.bold,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                               Row(
// //                                 children: [
// //                                   Expanded(
// //                                     child: Text(
// //                                       'วงเงินตามสิทธิ',
// //                                       textAlign: TextAlign.left,
// //                                       style: TextStyle(
// //                                           fontWeight: FontWeight.bold),
// //                                     ),
// //                                   ),
// //                                   Expanded(
// //                                     child: Text(
// //                                       AMedical.toString(),
// //                                       textAlign: TextAlign.end,
// //                                       style: TextStyle(
// //                                         fontSize: 18,
// //                                         color: Colors.black,
// //                                         fontWeight: FontWeight.bold,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                             ],
// //                           ),
// //                         ],
// //                       ),
// //                     ),

// //                     ///
// //                     Container(
// //                       margin: const EdgeInsets.all(5.0),
// //                       padding: const EdgeInsets.all(5.0),
// //                       //height: double.infinity,
// //                       width: 400,
// //                       decoration: BoxDecoration(
// //                         borderRadius: BorderRadius.circular(5),
// //                         border: Border.all(
// //                           color: Colors.white,
// //                         ),
// //                         color: Colors.white,
// //                         boxShadow: [
// //                           BoxShadow(
// //                             blurRadius: 6.0,
// //                             spreadRadius: 2.0,
// //                             color: Colors.grey,
// //                             offset: Offset(0.0, 0.0),
// //                           )
// //                         ],
// //                       ),
// //                       child: Column(
// //                         children: <Widget>[
// //                           Text(
// //                             'ค่าช่วยเหลือการศึกษาบุตร',
// //                             style: TextStyle(
// //                               fontSize: 16,
// //                               color: Color.fromARGB(255, 9, 28, 235),
// //                               fontWeight: FontWeight.bold,
// //                             ),
// //                           ),
// //                           const Divider(),
// //                            SizedBox(
// //                             height: 70,
// //                             child: PieChart(
// //                               PieChartData(
// //                                 startDegreeOffset: 20,
// //                                 sections: [
// //                                   //
// //                                    if (context.watch<MyDashboardProviders>()
// //                                           .RemainEducationModalChoice != 0.0) ...[
// //                                   PieChartSectionData(
// //                                     color: Colors.blue,
// //                                    value:  context
// //                                           .watch<MyDashboardProviders>()
// //                                           .RemainEducationModalChoice,
// //                                     showTitle: false,
// //                                     radius: 10,
// //                                   ),
// //                                   PieChartSectionData(
// //                                     color: Colors.green,
// //                                     value: context
// //                                           .watch<MyDashboardProviders>()
// //                                           .SumEducationModalChoice,
// //                                     showTitle: false,
// //                                     radius: 10,
// //                                   ),
                                  
// //                                    ]
// //                                      else if (context.watch<MyDashboardProviders>()
// //                                           .RemainEducationModalChoice == 0.0) ...[
// //  PieChartSectionData(
// //                                     color: Colors.green,
// //                                     value: context
// //                                           .watch<MyDashboardProviders>()
// //                                           .SumMedicalModalChoice,
// //                                     showTitle: false,
// //                                     radius: 10,
// //                                   ),
// //     ]
// //                                     else ...[
// //                    PieChartSectionData(
// //                                     color: Colors.blue,
// //                                     value:  context
// //                                           .watch<MyDashboardProviders>()
// //                                           .RemainEducationModalChoice,
// //                                     showTitle: false,
// //                                     radius: 10,
// //                                   ),
// //               ]
// //                                 ], //
// //                               ),
// //                             ),
// //                           ),
// //                           const Divider(),
// //                           Column(
// //                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                             children: [
// //                               Row(
// //                                 children: [
// //                                   Expanded(
// //                                     child: Text(
// //                                       'เงินที่ใช้ได้',
// //                                       textAlign: TextAlign.left,
// //                                       style: TextStyle(
// //                                           fontWeight: FontWeight.bold),
// //                                     ),
// //                                   ),
// //                                   Expanded(
// //                                     child: Text(
// //                                       context
// //                                           .watch<MyDashboardProviders>()
// //                                           .RemainEducationModalChoice
// //                                           .toString(),
// //                                       textAlign: TextAlign.end,
// //                                       style: TextStyle(
// //                                         fontSize: 18,
// //                                         color: Colors.blue,
// //                                         fontWeight: FontWeight.bold,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                               Row(
// //                                 children: [
// //                                   Expanded(
// //                                     child: Text(
// //                                       'เงินที่ใช้ไป',
// //                                       textAlign: TextAlign.left,
// //                                       style: TextStyle(
// //                                           fontWeight: FontWeight.bold),
// //                                     ),
// //                                   ),
// //                                   Expanded(
// //                                     child: Text(
// //                                            context
// //                                           .watch<MyDashboardProviders>()
// //                                           .SumEducationModalChoice
// //                                           .toString(),
// //                                       textAlign: TextAlign.end,
// //                                       style: TextStyle(
// //                                         fontSize: 18,
// //                                         color: Colors.green,
// //                                         fontWeight: FontWeight.bold,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                               Row(
// //                                 children: [
// //                                   Expanded(
// //                                     child: Text(
// //                                       'วงเงินตามสิทธิ',
// //                                       textAlign: TextAlign.left,
// //                                       style: TextStyle(
// //                                           fontWeight: FontWeight.bold),
// //                                     ),
// //                                   ),
// //                                   Expanded(
// //                                     child: Text(
// //                                       AMedical.toString(),
// //                                       textAlign: TextAlign.end,
// //                                       style: TextStyle(
// //                                         fontSize: 18,
// //                                         color: Colors.black,
// //                                         fontWeight: FontWeight.bold,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                             ],
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                        Container(
// //                       margin: const EdgeInsets.all(5.0),
// //                       padding: const EdgeInsets.all(5.0),
// //                       //height: double.infinity,
// //                       width: 400,
// //                       decoration: BoxDecoration(
// //                         borderRadius: BorderRadius.circular(5),
// //                         border: Border.all(
// //                           color: Colors.white,
// //                         ),
// //                         color: Colors.white,
// //                         boxShadow: [
// //                           BoxShadow(
// //                             blurRadius: 6.0,
// //                             spreadRadius: 2.0,
// //                             color: Colors.grey,
// //                             offset: Offset(0.0, 0.0),
// //                           )
// //                         ],
// //                       ),
// //                       child: Column(
// //                         children: <Widget>[
// //                           Text(
// //                             'เงินช่วยเหลือบุตร',
// //                             style: TextStyle(
// //                               fontSize: 16,
// //                               color: Color.fromARGB(255, 9, 28, 235),
// //                               fontWeight: FontWeight.bold,
// //                             ),
// //                           ),
// //                           const Divider(),
// //                            SizedBox(
// //                             height: 70,
// //                             child: PieChart(
// //                               PieChartData(
// //                                 startDegreeOffset: 20,
// //                                 sections: [
// //                                   //
// //                                    if (context.watch<MyDashboardProviders>()
// //                                           .RemainEducationModalChoice != 0.0) ...[
// //                                   PieChartSectionData(
// //                                     color: Colors.blue,
// //                                    value:  context
// //                                           .watch<MyDashboardProviders>()
// //                                           .RemainEducationModalChoice,
// //                                     showTitle: false,
// //                                     radius: 10,
// //                                   ),
// //                                   PieChartSectionData(
// //                                     color: Colors.green,
// //                                     value: context
// //                                           .watch<MyDashboardProviders>()
// //                                           .SumEducationModalChoice,
// //                                     showTitle: false,
// //                                     radius: 10,
// //                                   ),
// //                                    ]   else if (context.watch<MyDashboardProviders>()
// //                                           .RemainEducationModalChoice == 0.0) ...[
// //  PieChartSectionData(
// //                                     color: Colors.green,
// //                                     value: context
// //                                           .watch<MyDashboardProviders>()
// //                                           .SumMedicalModalChoice,
// //                                     showTitle: false,
// //                                     radius: 10,
// //                                   ),
// //     ]
                                   
// //                                    else ...[
// //                    PieChartSectionData(
// //                                     color: Colors.blue,
// //                                     value:  context
// //                                           .watch<MyDashboardProviders>()
// //                                           .RemainEducationModalChoice,
// //                                     showTitle: false,
// //                                     radius: 10,
// //                                   ),
// //               ]
// //                                 ], //
// //                               ),
// //                             ),
// //                           ),
// //                           const Divider(),
// //                           Column(
// //                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                             children: [
// //                               Row(
// //                                 children: [
// //                                   Expanded(
// //                                     child: Text(
// //                                       'จำนวนบุตรที่ขอเบิกได้',
// //                                       textAlign: TextAlign.left,
// //                                       style: TextStyle(
// //                                           fontWeight: FontWeight.bold),
// //                                     ),
// //                                   ),
// //                                   Expanded(
// //                                     child: Text(
// //                                       context
// //                                           .watch<MyDashboardProviders>()
// //                                           .RemainEducationModalChoice
// //                                           .toString(),
// //                                       textAlign: TextAlign.end,
// //                                       style: TextStyle(
// //                                         fontSize: 18,
// //                                         color: Colors.blue,
// //                                         fontWeight: FontWeight.bold,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                               Row(
// //                                 children: [
// //                                   Expanded(
// //                                     child: Text(
// //                                       'จำนวนบุตรที่ขอเบิก',
// //                                       textAlign: TextAlign.left,
// //                                       style: TextStyle(
// //                                           fontWeight: FontWeight.bold),
// //                                     ),
// //                                   ),
// //                                   Expanded(
// //                                     child: Text(
// //                                            context
// //                                           .watch<MyDashboardProviders>()
// //                                           .SumEducationModalChoice
// //                                           .toString(),
// //                                       textAlign: TextAlign.end,
// //                                       style: TextStyle(
// //                                         fontSize: 18,
// //                                         color: Colors.green,
// //                                         fontWeight: FontWeight.bold,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                               Row(
// //                                 children: [
// //                                   Expanded(
// //                                     child: Text(
// //                                       'จำนวนบุตรตามสิทธิ์',
// //                                       textAlign: TextAlign.left,
// //                                       style: TextStyle(
// //                                           fontWeight: FontWeight.bold),
// //                                     ),
// //                                   ),
// //                                   Expanded(
// //                                     child: Text(
// //                                       AMedical.toString(),
// //                                       textAlign: TextAlign.end,
// //                                       style: TextStyle(
// //                                         fontSize: 18,
// //                                         color: Colors.black,
// //                                         fontWeight: FontWeight.bold,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                             ],
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// // //  ]  ////--------------------------------------------

            
// // //             Padding(
// // //               padding: const EdgeInsets.all(8.0),
// // //               child: Container(
// // //                 child: Column(
// // //                   mainAxisAlignment: MainAxisAlignment.center,
// // //                   children: <Widget>[
// // //                     Container(
// // //                       margin: const EdgeInsets.all(5.0),
// // //                       padding: const EdgeInsets.all(5.0),
// // //                       //height: double.infinity,
// // //                       width: 400,
// // //                       decoration: BoxDecoration(
// // //                         borderRadius: BorderRadius.circular(5),
// // //                         border: Border.all(
// // //                           color: Colors.white,
// // //                         ),
// // //                         color: Colors.white,
// // //                         boxShadow: [
// // //                           BoxShadow(
// // //                             blurRadius: 6.0,
// // //                             spreadRadius: 2.0,
// // //                             color: Colors.grey,
// // //                             offset: Offset(0.0, 0.0),
// // //                           )
// // //                         ],
// // //                       ),
// // //                       child: Column(
// // //                         children: <Widget>[
// // //                           Text(
// // //                             'ค่ารักษาพยาบาล',
// // //                             style: TextStyle(
// // //                               fontSize: 16,
// // //                               color: Color.fromARGB(255, 9, 28, 235),
// // //                               fontWeight: FontWeight.bold,
// // //                             ),
// // //                           ),
// // //                           const Divider(),
// // //                           SizedBox(
// // //                             height: 70,

// // //                             child: PieChart(
// // //                               PieChartData(
// // //                                 startDegreeOffset: 20,
// // //                                 sections: [
// // //                                   //
// // //                                    if (context.watch<MyDashboardProviders>()
// // //                                           .RemainMedicalModalChoice != 0.0) ...[
// // //                                   PieChartSectionData(
// // //                                     color: Colors.blue,
// // //                                    value:  context
// // //                                           .watch<MyDashboardProviders>()
// // //                                           .RemainMedicalModalChoice,
// // //                                     showTitle: false,
// // //                                     radius: 10,
// // //                                   ),
// // //                                   PieChartSectionData(
// // //                                     color: Colors.green,
// // //                                     value: context
// // //                                           .watch<MyDashboardProviders>()
// // //                                           .SumMedicalModalChoice,
// // //                                     showTitle: false,
// // //                                     radius: 10,
// // //                                   ),
// // //                                    ] 
// // //                                    else if (context.watch<MyDashboardProviders>()
// // //                                           .RemainMedicalModalChoice == 0.0) ...[
// // //  PieChartSectionData(
// // //                                     color: Colors.green,
// // //                                     value: context
// // //                                           .watch<MyDashboardProviders>()
// // //                                           .SumMedicalModalChoice,
// // //                                     showTitle: false,
// // //                                     radius: 10,
// // //                                   ),
// // //     ]
// // //                                    else ...[
                                    
// // //                    PieChartSectionData(
// // //                                     color: Colors.blue,
// // //                                     value:  context
// // //                                           .watch<MyDashboardProviders>()
// // //                                           .RemainEducationModalChoice,
// // //                                     showTitle: false,
// // //                                     radius: 10,
// // //                                   ),


// // //               ]
                                         
// // //                                 ], //
// // //                               ),
// // //                             ),
// // //                           ),
// // //                           const Divider(),
// // //                           Column(
// // //                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // //                             children: [
// // //                               Row(
// // //                                 children: [
// // //                                   Expanded(
// // //                                     child: Text(
// // //                                       'เงินที่ใช้ได้',
// // //                                       textAlign: TextAlign.left,
// // //                                       style: TextStyle(
// // //                                           fontWeight: FontWeight.bold),
// // //                                     ),
// // //                                   ),
// // //                                   Expanded(
// // //                                     child: Text(
// // //                                       context
// // //                                           .watch<MyDashboardProviders>()
// // //                                           .RemainMedicalModalChoice
// // //                                           .toString(),
// // //                                       textAlign: TextAlign.end,
// // //                                       style: TextStyle(
// // //                                         fontSize: 18,
// // //                                         color: Colors.blue,
// // //                                         fontWeight: FontWeight.bold,
// // //                                       ),
// // //                                     ),
// // //                                   ),
// // //                                 ],
// // //                               ),
// // //                               Row(
// // //                                 children: [
// // //                                   Expanded(
// // //                                     child: Text(
// // //                                       'เงินที่ใช้ไป',
// // //                                       textAlign: TextAlign.left,
// // //                                       style: TextStyle(
// // //                                           fontWeight: FontWeight.bold),
// // //                                     ),
// // //                                   ),
// // //                                   Expanded(
// // //                                     child: Text(
// // //                                       context
// // //                                           .watch<MyDashboardProviders>()
// // //                                           .SumMedicalModalChoice
// // //                                           .toString(),
// // //                                       textAlign: TextAlign.end,
// // //                                       style: TextStyle(
// // //                                         fontSize: 18,
// // //                                         color: Colors.green,
// // //                                         fontWeight: FontWeight.bold,
// // //                                       ),
// // //                                     ),
// // //                                   ),
// // //                                 ],
// // //                               ),
// // //                               Row(
// // //                                 children: [
// // //                                   Expanded(
// // //                                     child: Text(
// // //                                       'วงเงินตามสิทธิ',
// // //                                       textAlign: TextAlign.left,
// // //                                       style: TextStyle(
// // //                                           fontWeight: FontWeight.bold),
// // //                                     ),
// // //                                   ),
// // //                                   Expanded(
// // //                                     child: Text(
// // //                                       AMedical.toString(),
// // //                                       textAlign: TextAlign.end,
// // //                                       style: TextStyle(
// // //                                         fontSize: 18,
// // //                                         color: Colors.black,
// // //                                         fontWeight: FontWeight.bold,
// // //                                       ),
// // //                                     ),
// // //                                   ),
// // //                                 ],
// // //                               ),
// // //                             ],
// // //                           ),
// // //                         ],
// // //                       ),
// // //                     ),

// // //                     ///
// // //                     Container(
// // //                       margin: const EdgeInsets.all(5.0),
// // //                       padding: const EdgeInsets.all(5.0),
// // //                       //height: double.infinity,
// // //                       width: 400,
// // //                       decoration: BoxDecoration(
// // //                         borderRadius: BorderRadius.circular(5),
// // //                         border: Border.all(
// // //                           color: Colors.white,
// // //                         ),
// // //                         color: Colors.white,
// // //                         boxShadow: [
// // //                           BoxShadow(
// // //                             blurRadius: 6.0,
// // //                             spreadRadius: 2.0,
// // //                             color: Colors.grey,
// // //                             offset: Offset(0.0, 0.0),
// // //                           )
// // //                         ],
// // //                       ),
// // //                       child: Column(
// // //                         children: <Widget>[
// // //                           Text(
// // //                             'ค่าช่วยเหลือการศึกษาบุตร',
// // //                             style: TextStyle(
// // //                               fontSize: 16,
// // //                               color: Color.fromARGB(255, 9, 28, 235),
// // //                               fontWeight: FontWeight.bold,
// // //                             ),
// // //                           ),
// // //                           const Divider(),
// // //                            SizedBox(
// // //                             height: 70,
// // //                             child: PieChart(
// // //                               PieChartData(
// // //                                 startDegreeOffset: 20,
// // //                                 sections: [
// // //                                   //
// // //                                    if (context.watch<MyDashboardProviders>()
// // //                                           .RemainEducationModalChoice != 0.0) ...[
// // //                                   PieChartSectionData(
// // //                                     color: Colors.blue,
// // //                                    value:  context
// // //                                           .watch<MyDashboardProviders>()
// // //                                           .RemainEducationModalChoice,
// // //                                     showTitle: false,
// // //                                     radius: 10,
// // //                                   ),
// // //                                   PieChartSectionData(
// // //                                     color: Colors.green,
// // //                                     value: context
// // //                                           .watch<MyDashboardProviders>()
// // //                                           .SumEducationModalChoice,
// // //                                     showTitle: false,
// // //                                     radius: 10,
// // //                                   ),
                                  
// // //                                    ]
// // //                                      else if (context.watch<MyDashboardProviders>()
// // //                                           .RemainEducationModalChoice == 0.0) ...[
// // //  PieChartSectionData(
// // //                                     color: Colors.green,
// // //                                     value: context
// // //                                           .watch<MyDashboardProviders>()
// // //                                           .SumMedicalModalChoice,
// // //                                     showTitle: false,
// // //                                     radius: 10,
// // //                                   ),
// // //     ]
// // //                                     else ...[
// // //                    PieChartSectionData(
// // //                                     color: Colors.blue,
// // //                                     value:  context
// // //                                           .watch<MyDashboardProviders>()
// // //                                           .RemainEducationModalChoice,
// // //                                     showTitle: false,
// // //                                     radius: 10,
// // //                                   ),
// // //               ]
// // //                                 ], //
// // //                               ),
// // //                             ),
// // //                           ),
// // //                           const Divider(),
// // //                           Column(
// // //                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // //                             children: [
// // //                               Row(
// // //                                 children: [
// // //                                   Expanded(
// // //                                     child: Text(
// // //                                       'เงินที่ใช้ได้',
// // //                                       textAlign: TextAlign.left,
// // //                                       style: TextStyle(
// // //                                           fontWeight: FontWeight.bold),
// // //                                     ),
// // //                                   ),
// // //                                   Expanded(
// // //                                     child: Text(
// // //                                       context
// // //                                           .watch<MyDashboardProviders>()
// // //                                           .RemainEducationModalChoice
// // //                                           .toString(),
// // //                                       textAlign: TextAlign.end,
// // //                                       style: TextStyle(
// // //                                         fontSize: 18,
// // //                                         color: Colors.blue,
// // //                                         fontWeight: FontWeight.bold,
// // //                                       ),
// // //                                     ),
// // //                                   ),
// // //                                 ],
// // //                               ),
// // //                               Row(
// // //                                 children: [
// // //                                   Expanded(
// // //                                     child: Text(
// // //                                       'เงินที่ใช้ไป',
// // //                                       textAlign: TextAlign.left,
// // //                                       style: TextStyle(
// // //                                           fontWeight: FontWeight.bold),
// // //                                     ),
// // //                                   ),
// // //                                   Expanded(
// // //                                     child: Text(
// // //                                            context
// // //                                           .watch<MyDashboardProviders>()
// // //                                           .SumEducationModalChoice
// // //                                           .toString(),
// // //                                       textAlign: TextAlign.end,
// // //                                       style: TextStyle(
// // //                                         fontSize: 18,
// // //                                         color: Colors.green,
// // //                                         fontWeight: FontWeight.bold,
// // //                                       ),
// // //                                     ),
// // //                                   ),
// // //                                 ],
// // //                               ),
// // //                               Row(
// // //                                 children: [
// // //                                   Expanded(
// // //                                     child: Text(
// // //                                       'วงเงินตามสิทธิ',
// // //                                       textAlign: TextAlign.left,
// // //                                       style: TextStyle(
// // //                                           fontWeight: FontWeight.bold),
// // //                                     ),
// // //                                   ),
// // //                                   Expanded(
// // //                                     child: Text(
// // //                                       AMedical.toString(),
// // //                                       textAlign: TextAlign.end,
// // //                                       style: TextStyle(
// // //                                         fontSize: 18,
// // //                                         color: Colors.black,
// // //                                         fontWeight: FontWeight.bold,
// // //                                       ),
// // //                                     ),
// // //                                   ),
// // //                                 ],
// // //                               ),
// // //                             ],
// // //                           ),
// // //                         ],
// // //                       ),
// // //                     ),
// // //                        Container(
// // //                       margin: const EdgeInsets.all(5.0),
// // //                       padding: const EdgeInsets.all(5.0),
// // //                       //height: double.infinity,
// // //                       width: 400,
// // //                       decoration: BoxDecoration(
// // //                         borderRadius: BorderRadius.circular(5),
// // //                         border: Border.all(
// // //                           color: Colors.white,
// // //                         ),
// // //                         color: Colors.white,
// // //                         boxShadow: [
// // //                           BoxShadow(
// // //                             blurRadius: 6.0,
// // //                             spreadRadius: 2.0,
// // //                             color: Colors.grey,
// // //                             offset: Offset(0.0, 0.0),
// // //                           )
// // //                         ],
// // //                       ),
// // //                       child: Column(
// // //                         children: <Widget>[
// // //                           Text(
// // //                             'เงินช่วยเหลือบุตร',
// // //                             style: TextStyle(
// // //                               fontSize: 16,
// // //                               color: Color.fromARGB(255, 9, 28, 235),
// // //                               fontWeight: FontWeight.bold,
// // //                             ),
// // //                           ),
// // //                           const Divider(),
// // //                            SizedBox(
// // //                             height: 70,
// // //                             child: PieChart(
// // //                               PieChartData(
// // //                                 startDegreeOffset: 20,
// // //                                 sections: [
// // //                                   //
// // //                                    if (context.watch<MyDashboardProviders>()
// // //                                           .RemainEducationModalChoice != 0.0) ...[
// // //                                   PieChartSectionData(
// // //                                     color: Colors.blue,
// // //                                    value:  context
// // //                                           .watch<MyDashboardProviders>()
// // //                                           .RemainEducationModalChoice,
// // //                                     showTitle: false,
// // //                                     radius: 10,
// // //                                   ),
// // //                                   PieChartSectionData(
// // //                                     color: Colors.green,
// // //                                     value: context
// // //                                           .watch<MyDashboardProviders>()
// // //                                           .SumEducationModalChoice,
// // //                                     showTitle: false,
// // //                                     radius: 10,
// // //                                   ),
// // //                                    ]   else if (context.watch<MyDashboardProviders>()
// // //                                           .RemainEducationModalChoice == 0.0) ...[
// // //  PieChartSectionData(
// // //                                     color: Colors.green,
// // //                                     value: context
// // //                                           .watch<MyDashboardProviders>()
// // //                                           .SumMedicalModalChoice,
// // //                                     showTitle: false,
// // //                                     radius: 10,
// // //                                   ),
// // //     ]
                                   
// // //                                    else ...[
// // //                    PieChartSectionData(
// // //                                     color: Colors.blue,
// // //                                     value:  context
// // //                                           .watch<MyDashboardProviders>()
// // //                                           .RemainEducationModalChoice,
// // //                                     showTitle: false,
// // //                                     radius: 10,
// // //                                   ),
// // //               ]
// // //                                 ], //
// // //                               ),
// // //                             ),
// // //                           ),
// // //                           const Divider(),
// // //                           Column(
// // //                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // //                             children: [
// // //                               Row(
// // //                                 children: [
// // //                                   Expanded(
// // //                                     child: Text(
// // //                                       'จำนวนบุตรที่ขอเบิกได้',
// // //                                       textAlign: TextAlign.left,
// // //                                       style: TextStyle(
// // //                                           fontWeight: FontWeight.bold),
// // //                                     ),
// // //                                   ),
// // //                                   Expanded(
// // //                                     child: Text(
// // //                                       context
// // //                                           .watch<MyDashboardProviders>()
// // //                                           .RemainEducationModalChoice
// // //                                           .toString(),
// // //                                       textAlign: TextAlign.end,
// // //                                       style: TextStyle(
// // //                                         fontSize: 18,
// // //                                         color: Colors.blue,
// // //                                         fontWeight: FontWeight.bold,
// // //                                       ),
// // //                                     ),
// // //                                   ),
// // //                                 ],
// // //                               ),
// // //                               Row(
// // //                                 children: [
// // //                                   Expanded(
// // //                                     child: Text(
// // //                                       'จำนวนบุตรที่ขอเบิก',
// // //                                       textAlign: TextAlign.left,
// // //                                       style: TextStyle(
// // //                                           fontWeight: FontWeight.bold),
// // //                                     ),
// // //                                   ),
// // //                                   Expanded(
// // //                                     child: Text(
// // //                                            context
// // //                                           .watch<MyDashboardProviders>()
// // //                                           .SumEducationModalChoice
// // //                                           .toString(),
// // //                                       textAlign: TextAlign.end,
// // //                                       style: TextStyle(
// // //                                         fontSize: 18,
// // //                                         color: Colors.green,
// // //                                         fontWeight: FontWeight.bold,
// // //                                       ),
// // //                                     ),
// // //                                   ),
// // //                                 ],
// // //                               ),
// // //                               Row(
// // //                                 children: [
// // //                                   Expanded(
// // //                                     child: Text(
// // //                                       'จำนวนบุตรตามสิทธิ์',
// // //                                       textAlign: TextAlign.left,
// // //                                       style: TextStyle(
// // //                                           fontWeight: FontWeight.bold),
// // //                                     ),
// // //                                   ),
// // //                                   Expanded(
// // //                                     child: Text(
// // //                                       AMedical.toString(),
// // //                                       textAlign: TextAlign.end,
// // //                                       style: TextStyle(
// // //                                         fontSize: 18,
// // //                                         color: Colors.black,
// // //                                         fontWeight: FontWeight.bold,
// // //                                       ),
// // //                                     ),
// // //                                   ),
// // //                                 ],
// // //                               ),
// // //                             ],
// // //                           ),
// // //                         ],
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ),
// // //  ],
// //              ],
            
// //           ),

// //         ),
// //        drawer: MyDrawer(),
// //       //bottomNavigationBar: _buildbottomNavigationBar(),
// //        //bottomNavigationBar:  
// //        /*
// //        NavBar(),
// //       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
// //       floatingActionButton: FloatingActionButton(
// //       shape: RoundedRectangleBorder(
// //         borderRadius: BorderRadius.circular(10)
// //       ),
// //       elevation: 0,
// //       backgroundColor: iBlueColor,
// //         onPressed: () {
          
          
          
// //         },
// //         child: Icon(Icons.add,size: 35,),
// //       ),
// //       */
// //     ); 
// //   }

// //   /*
// //    Widget buildcars(List<carInfo> cars) => PageView.builder(
// //     scrollDirection: Axis.horizontal,
// //     controller: _controller,
// //     itemCount: !cars.isEmpty ? cars.length : 1,
// //     itemBuilder: (context, index) {
// //         //return InkWell(
// //     return  Padding(
// //       padding: const EdgeInsets.symmetric(horizontal: 25),
// //       child: Container(
// //         width: 300,
// //         padding: EdgeInsets.all(20),
// //         decoration: BoxDecoration(
// //           color: Colors.blue,
// //           borderRadius: BorderRadius.circular(16),
// //         ),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: [
// //             SizedBox(height: 10),
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Text(
// //                   cars[index].Brand.toString(),
// //                   style: TextStyle(
// //                     color: Colors.white,
// //                   ),
// //                 ),
// //                 Image.asset(
// //                   cars[index].Img.toString(),
// //                   height: 50,
// //                 )
// //               ],
// //             ),
// //             SizedBox(height: 10),
// //             Text(
// //               cars[index].Model.toString(),
// //               style: TextStyle(
// //                 color: Colors.white,
// //                 fontSize: 24,
// //               ),
// //             ),
// //             SizedBox(height: 10),
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Text(
// //                   cars[index].Color.toString(),
// //                   style: TextStyle(
// //                     color: Colors.white,
// //                   ),
// //                 ),
// //                 Text(
// //                   cars[index].Licence.toString(),
// //                   style: TextStyle(
// //                     color: Colors.white,
// //                   ),
// //                 ),
// //                 Text(
// //                   cars[index].Refeul.toString(),
// //                   style: TextStyle(
// //                     color: Colors.white,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //        // );

// //           },
// //           );
// //           */
// // }


// // Widget _buildbottomNavigationBar() { 
  
// //     int _selectedIndex = 0;
// //     final List<Widget> screens = [];
    
// //   return Container(
// //     decoration: BoxDecoration(
// //       borderRadius: BorderRadius.only(
// //         topLeft: Radius.circular(30),
// //         topRight: Radius.circular(30),
// //       ),
// //       boxShadow: [
// //         BoxShadow(
// //           color: iGreyColor,
// //           spreadRadius: 5,
// //           blurRadius: 10
// //         )
// //       ]),
// //       child: ClipRRect(
// //         borderRadius: BorderRadius.only(
// //           topLeft: Radius.circular(30),
// //           topRight: Radius.circular(30),

// //         ),
        
// //         child: BottomNavigationBar(
// //           backgroundColor: iWhiteColor,
// //           showSelectedLabels: false,
// //           showUnselectedLabels: false,
// //           selectedItemColor: iOrangeColor,
// //           unselectedItemColor: iGreyColor,

// //           items: [
// //             BottomNavigationBarItem(
// //               label: 'Home',
// //               icon: Icon(Icons.home_rounded,size: 30),
// //                ),
// //                         BottomNavigationBarItem(
// //               label: 'Profile',
// //               icon: Icon(Icons.person_rounded,
// //               size: 30)
// //               ),

// //           ],
// //             currentIndex: _selectedIndex, //New
// //             //onTap: _onItemTapped, 
              
// //         ),

        
// //       ),

// //   );
  

// // }







// // /*


// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('GHB Benefits'),
// //       ),
// //       body: SingleChildScrollView(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: <Widget>[
// //             Container(
// //               margin: const EdgeInsets.all(10.0),
// //               padding: const EdgeInsets.all(10.0),
// //               //height: double.infinity,
// //               width: 450,
// //               decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(5),
// //                 border: Border.all(
// //                   color: Colors.white,
// //                 ),
// //                 color: Colors.white,
// //                 boxShadow: [
// //                   BoxShadow(
// //                     blurRadius: 6.0,
// //                     spreadRadius: 2.0,
// //                     color: Colors.grey,
// //                     offset: Offset(0.0, 0.0),
// //                   )
// //                 ],
// //               ),
// //               child: Column(
// //                 children: <Widget>[
// //                   Text(
// //                     'ค่ารักษาพยาบาล',
// //                     style: TextStyle(
// //                       fontSize: 16,
// //                       color: Color.fromARGB(255, 9, 28, 235),
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                   const Divider(),
// //                           SizedBox(
// //                             height: 100,
// //                             child: PieChart(
// //                               PieChartData(
// //                                 sections: [
// //                                   //
// //                                   PieChartSectionData(
// //                                     color: Colors.blue,
// //                                     value: 80,
// //                                     showTitle: false,
// //                                     radius: 25,
// //                                   ),
// //                                   PieChartSectionData(
// //                                     color: Colors.green,
// //                                     value: 20,
// //                                     showTitle: false,
// //                                     radius: 25,
// //                                   ),
// //                                 ], //
// //                               ),
// //                             ),
// //                           ),
// //                   const Divider(),
// //                   Row(
// //                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                               children: [
// //                                 Column(
// //                                   children: [
// //                                     const Text(
// //                                       'เงินที่ใช้ได้',
// //                                       style: TextStyle(
// //                                         fontWeight: FontWeight.bold,
// //                                       ),
// //                                     ),
// //                                     const Text(''),
// //                                     const Text(
// //                                       '32,000',
// //                                       style: TextStyle(
// //                                         fontSize: 18,
// //                                         color: Colors.blue,
// //                                         fontWeight: FontWeight.bold,
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),
// //                                                             Column(
// //                                   children: [
// //                                     const Text(
// //                                       'เงินที่ใช้ไป',
// //                                       style: TextStyle(
// //                                         fontWeight: FontWeight.bold,
// //                                       ),
// //                                     ),
// //                                     const Text(''),
// //                                     const Text(
// //                                       '8,000',
// //                                       style: TextStyle(
// //                                         fontSize: 18,
// //                                         color: Colors.green,
// //                                         fontWeight: FontWeight.bold,
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),
// //                                  Column(
// //                                   children: [
// //                                     const Text(
// //                                       'วงเงินตามสิทธิ',
// //                                       style: TextStyle(
// //                                         fontWeight: FontWeight.bold,
// //                                       ),
// //                                     ),
// //                                     const Text(''),
// //                                     const Text(
// //                                       '40,000',
// //                                       style: TextStyle(
// //                                         fontSize: 18,
// //                                         color: Colors.black,
// //                                         fontWeight: FontWeight.bold,
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ), 
// //                                 ],   
// //                   ),
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                          Padding(
// //                            padding: const EdgeInsets.all(8.0),
// //                            child: ElevatedButton(
// //                               onPressed: () {
// //                                 Navigator.of(context).push(MaterialPageRoute(
// //                                     builder: (context) => AddMedPage()));
// //                               },
// //                               child: const Text('ยื่นคำขอเบิกค่ารักษาพยาบาล'),
// //                             ),
// //                          ),  
// //                           ],                 
// //                   ),
// //                 ],
// //               ),
// //             ),
 
// //             ///
// //             Container(
// //               margin: const EdgeInsets.all(10.0),
// //               padding: const EdgeInsets.all(10.0),
// //               //height: double.infinity,
// //               width: 450,
// //               decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(5),
// //                 border: Border.all(
// //                   color: Colors.white,
// //                 ),
// //                 color: Colors.white,
// //                 boxShadow: [
// //                   BoxShadow(
// //                     blurRadius: 6.0,
// //                     spreadRadius: 2.0,
// //                     color: Colors.grey,
// //                     offset: Offset(0.0, 0.0),
// //                   )
// //                 ],
// //               ),
// //               child: Column(
// //                 children: <Widget>[
// //                   Text(
// //                     'ค่าช่วยเหลือการศึกษาบุตร',
// //                     style: TextStyle(
// //                       fontSize: 16,
// //                       color: Color.fromARGB(255, 9, 28, 235),
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                   const Divider(),
// //                           SizedBox(
// //                             height: 100,
// //                             child: PieChart(
// //                               PieChartData(
// //                                 sections: [
// //                                   //
// //                                   PieChartSectionData(
// //                                     color: Colors.blue,
// //                                     value: 80,
// //                                     showTitle: false,
// //                                     radius: 25,
// //                                   ),
// //                                   PieChartSectionData(
// //                                     color: Colors.green,
// //                                     value: 20,
// //                                     showTitle: false,
// //                                     radius: 25,
// //                                   ),
// //                                 ], //
// //                               ),
// //                             ),
// //                           ),
// //                   const Divider(),
// //                   Row(
// //                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                               children: [
// //                                 Column(
// //                                   children: [
// //                                     const Text(
// //                                       'เงินที่ใช้ได้',
// //                                       style: TextStyle(
// //                                         fontWeight: FontWeight.bold,
// //                                       ),
// //                                     ),
// //                                     const Text(''),
// //                                     const Text(
// //                                       '32,000',
// //                                       style: TextStyle(
// //                                         fontSize: 18,
// //                                         color: Colors.blue,
// //                                         fontWeight: FontWeight.bold,
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),
// //                                                             Column(
// //                                   children: [
// //                                     const Text(
// //                                       'เงินที่ใช้ไป',
// //                                       style: TextStyle(
// //                                         fontWeight: FontWeight.bold,
// //                                       ),
// //                                     ),
// //                                     const Text(''),
// //                                     const Text(
// //                                       '8,000',
// //                                       style: TextStyle(
// //                                         fontSize: 18,
// //                                         color: Colors.green,
// //                                         fontWeight: FontWeight.bold,
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),
// //                                  Column(
// //                                   children: [
// //                                     const Text(
// //                                       'วงเงินตามสิทธิ',
// //                                       style: TextStyle(
// //                                         fontWeight: FontWeight.bold,
// //                                       ),
// //                                     ),
// //                                     const Text(''),
// //                                     const Text(
// //                                       '40,000',
// //                                       style: TextStyle(
// //                                         fontSize: 18,
// //                                         color: Colors.black,
// //                                         fontWeight: FontWeight.bold,
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ), 
// //                                 ],   
// //                   ),
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                          Padding(
// //                            padding: const EdgeInsets.all(8.0),
// //                            child: ElevatedButton(
// //                               onPressed: () {
// //                                 Navigator.of(context).push(MaterialPageRoute(
// //                                     builder: (context) => AddEduPage()));
// //                               },
// //                               child: const Text('ยื่นคำขอเบิกค่าช่วยเหลือการศึกษาบุตร'),
// //                             ),
// //                          ),  
// //                           ],                 
// //                   ),
// //                 ],
// //               ),
// //             ),

 

   
 
  
   

// // ////end
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // void _onItemTapped(int index) {
// //   setState(() {
// //     _selectedIndex = index;
// //   });
// // }
// // */