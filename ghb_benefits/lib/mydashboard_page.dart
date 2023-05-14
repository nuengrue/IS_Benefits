import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ghb_benefits/All_Controllers/Education_Controller.dart';
import 'package:ghb_benefits/All_Controllers/Medical_Controller.dart';
import 'package:ghb_benefits/All_Providers/provider_dashboard.dart';
import 'package:ghb_benefits/All_Providers/provider_education.dart';
import 'package:ghb_benefits/All_Providers/provider_medical.dart';
import 'package:ghb_benefits/All_Services/servics.dart';

import 'package:ghb_benefits/color.dart';
import 'package:ghb_benefits/my_drawer.dart';
import 'package:provider/provider.dart';

class MyDashboardPage extends StatefulWidget {
  @override
  State<MyDashboardPage> createState() => _MyDashboardPageState();
}

class _MyDashboardPageState extends State<MyDashboardPage> {
  double AMedical = 40000;


  MedicalController medicalcontroller = MedicalController(FirebaseServices());
  EducationController educationcontroller = EducationController(FirebaseServices());

  void initState() {
    super.initState();
    
    _getDashboard(context);
  }

  void _getDashboard(BuildContext context) async {
    // get data  MedicalDashboard
    var newMedicalDashboard = await medicalcontroller.fetchMedicalDashboard();
    context.read<MedicalProviders>().MedicalList = newMedicalDashboard;
    final medical = [];
    for (var doc in newMedicalDashboard) {
      double a = double.parse(doc.payamount);
      medical.add(a);
    }
    var sumamountmedical = medical.reduce((a, b) => a + b);
    var RemainMedical = AMedical - sumamountmedical;
    context.read<MyDashboardProviders>().SumMedicalModalChoice = sumamountmedical;
    context.read<MyDashboardProviders>().RemainMedicalModalChoice = RemainMedical;

        // get data  EducationDashboard
    var newEducationDashboard = await educationcontroller.fetchEducationDashboard();
    context.read<EducationProviders>().EducationList = newEducationDashboard;
    final education = [];
    for (var doc in newEducationDashboard) {
      double a = double.parse(doc.payamount);
      education.add(a);
    }
    var sumamounteducation = education.reduce((a, b) => a + b);
    var RemainEducation = AMedical - sumamounteducation;
    context.read<MyDashboardProviders>().SumEducationModalChoice = sumamounteducation;
    context.read<MyDashboardProviders>().RemainEducationModalChoice = RemainEducation;
    

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Dashboard',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: iWhiteColor,
          ),
        ),
        backgroundColor: iBlueColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 10),

            SizedBox(height: 20),

            /// my dash border
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  'My Dashboard',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
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
                      margin: const EdgeInsets.all(10.0),
                      padding: const EdgeInsets.all(10.0),
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
                              fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                            ),
                          ),
                          const Divider(),
                          SizedBox(
                            height: 100,
                            child: PieChart(
                              PieChartData(
                                startDegreeOffset: 30,
                                sections: [
                                  //
                                  PieChartSectionData(
                                    color: Colors.blue,
                                    value:  context
                                          .watch<MyDashboardProviders>()
                                          .RemainMedicalModalChoice,
                                    showTitle: false,
                                    radius: 25,
                                  ),
                                  PieChartSectionData(
                                    color: Colors.green,
                                    value: context
                                          .watch<MyDashboardProviders>()
                                          .SumMedicalModalChoice,
                                    showTitle: false,
                                    radius: 25,
                                  ),
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
                      margin: const EdgeInsets.all(10.0),
                      padding: const EdgeInsets.all(10.0),
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
                            height: 100,
                            child: PieChart(
                              PieChartData(
                                startDegreeOffset: 30,
                                sections: [
                                  //
                                  PieChartSectionData(
                                    color: Colors.blue,
                                    value:  context
                                          .watch<MyDashboardProviders>()
                                          .RemainEducationModalChoice,
                                    showTitle: false,
                                    radius: 25,
                                  ),
                                  PieChartSectionData(
                                    color: Colors.green,
                                    value: context
                                          .watch<MyDashboardProviders>()
                                          .SumEducationModalChoice,
                                    showTitle: false,
                                    radius: 25,
                                  ),
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
                                          fontWeight: FontWeight.bold),
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}

