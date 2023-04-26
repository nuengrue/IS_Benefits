
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ghb_benefits/All_Controllers/Education_Controller.dart';
import 'package:ghb_benefits/All_Controllers/Medical_Controller.dart';
import 'package:ghb_benefits/All_Controllers/master_controllers.dart';
import 'package:ghb_benefits/All_Models/employee_model.dart';
import 'package:ghb_benefits/All_Providers/provider_dashboard.dart';
import 'package:ghb_benefits/All_Providers/provider_education.dart';
import 'package:ghb_benefits/All_Providers/provider_master.dart';
import 'package:ghb_benefits/All_Providers/provider_medical.dart';
import 'package:ghb_benefits/All_Services/servics.dart';
import 'package:ghb_benefits/button_menu.dart';
import 'package:ghb_benefits/color.dart';
import 'package:ghb_benefits/login/main_switch_page.dart';
import 'package:ghb_benefits/my_drawer.dart';
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


  MedicalController medicalcontroller = MedicalController(FirebaseServices());
  EducationController educationcontroller = EducationController(FirebaseServices());
  MasterController mastecontroller = MasterController(FirebaseServices());

  void initState() {
    super.initState();
    _getDashboard(context);
  }

  void _getDashboard(BuildContext context) async {
        var newMedicalDashboard = await medicalcontroller.fetchMedical();
       print(newMedicalDashboard.length);
    if(newMedicalDashboard.length > 0){
    // get data  MedicalDashboard
    //var newMedicalDashboard = await medicalcontroller.fetchMedical();
    context.read<MedicalProviders>().MedicalList = newMedicalDashboard;
    final medical = [];
    for (var doc in newMedicalDashboard) {
      double a = double.parse(doc.payamount);
      medical.add(a);
    }
    var sumamountmedical = medical.reduce((a, b) => a + b);
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
     //print(newEducationDashboard.length);
        if(newEducationDashboard.length > 0){
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
    else{
    context.read<MyDashboardProviders>().SumEducationModalChoice = sMedical;
    context.read<MyDashboardProviders>().RemainEducationModalChoice = AMedical;
    }
//  print(context.read<MyDashboardProviders>().SumEducationModalChoice);
//   print(context.read<MyDashboardProviders>().RemainEducationModalChoice);
//    print(context.read<MyDashboardProviders>().SumMedicalModalChoice);
//     print(context.read<MyDashboardProviders>().RemainMedicalModalChoice);
    var newEmployee = await mastecontroller.fetchEmployee();

    context.read<EmployeeProviders>().EmployeeList = newEmployee;
    
    //newEmployee = context.read<EmployeeProviders>().EmployeeList ;

     context.read<filedEmployeeProviders>().Empno = newEmployee.first.no;
     context.read<filedEmployeeProviders>().Empempcode = newEmployee.first.empcode;
     context.read<filedEmployeeProviders>().Empnameemp = newEmployee.first.nameemp;
     //context.read<filedEmployeeProviders>().Empnameemp = newEmployee.first.nameemp;
      //      print(context.read<filedEmployeeProviders>().Empempcode);
      // print(context.read<filedEmployeeProviders>().Empnameemp);
    var newChilder = await mastecontroller.fetchChilder();
    context.read<ChilderProviders>().ChilderList = newChilder;
  }

  @override

 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GHB Benefit',textAlign: TextAlign.center,style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: iOrangeColor,
                          ),),
      backgroundColor: iBlueColor,
      
      actions: [
        IconButton(
                        icon: Icon(Icons.logout),
                        color: iWhiteColor,
                        onPressed: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MainSwitchPage()));
                        },
                      ),
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
                            color: iBlueColor,
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
                          
                          style: TextStyle(fontSize: 18, color:iBlueColor),
                        ),
                      ],
                    ),
                   
                  ],
                ),
              ),
              
              SizedBox(height: 20),
              //SizedBox(height: 25),
            //   Container(
            //     height: 200,

            //    child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 25),
            //     child: Container(
            //      // width: 250,
            //       padding: EdgeInsets.all(20),
            //       decoration: BoxDecoration(
            //         color: Colors.pink[300],
            //         borderRadius: BorderRadius.circular(16),
            //       ),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           SizedBox(height: 20),
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Text(
            //                 'ประกาศแจ้งข่าวสาร',
            //                 style: TextStyle(
            //                   color: Colors.white,
            //                   fontSize: 24,
            //                 ),
            //               ),
            //             ],
            //           ),
            //           SizedBox(height: 20),
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Text(
            //                 'ร่วมมือ ร่วมใจ บริจาคสิ่งของเพื่อน้องๆ',
            //                 style: TextStyle(
            //                   color: Colors.white,
            //                   fontSize: 16,
            //                 ),
            //               ),
                         
            //             ],
            //           ),
            //           SizedBox(height: 20),
            //                Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
 
            //               Text(
            //                 "โดย ฝ่ายทรัพยากรบุคคล ส่วนสวัสดิการ",
            //                 style: TextStyle(
            //                   color: Colors.white,
            //                   fontSize: 16,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),

            //     /*
            //     child: StreamBuilder<List<AddCard>>(
            //         stream: listcard(),
            //         builder: (context, snapshot) {
            //           if (snapshot.hasData) {
            //             //final cars = snapshot.data!;
            //             final card = snapshot.data;
            //             return buildcards(card!);
            //           } else if (snapshot.hasError) {
            //             return Center(child: CircularProgressIndicator());
            //           } else {
            //             return const Center(child: Text("No Data Received"));
            //           }
            //         }),*/
            //   ),
            //   SizedBox(height: 10),

            //   //buttons
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         ButtonMenu(
            //           iconImagePath: Icons.dashboard,
            //           buttonText: 'Dashboards',
            //           index: '/1',
            //         ),
            //         ButtonMenu(
            //           iconImagePath: Icons.medical_information,
            //           buttonText: 'ค่ารักษาพยาบาล',
            //           index: '/2',
            //         ),

            //       ],
            //     ),
            // SizedBox(height: 10),
            //     //buttons
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         ButtonMenu(
            //           iconImagePath: Icons.cast_for_education,
            //           buttonText: 'การศึกษาบุตร',
            //           index: '/3',
            //         ),
            //         ButtonMenu(
            //           iconImagePath: Icons.money,
            //           buttonText: 'เงินช่วยเหลือบุตร',
            //           index: '/4',
            //         ),

            //       ],
            //     ),
            //     SizedBox(height: 10),
            //                   //buttons
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         ButtonMenu(
            //           iconImagePath: Icons.home_repair_service,
            //           buttonText: 'ค่าเช่าบ้าน',
            //           index: '/5',
            //         ),
            //          ButtonMenu(
            //           iconImagePath: Icons.cyclone,
            //           buttonText: 'ฌาปนกิจ',
            //           index: '/6',
            //         ),
            //       ],
            //     ),
            //     SizedBox(height: 10),
            //                   //buttons
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         ButtonMenu(
            //           iconImagePath: Icons.notifications,
            //           buttonText: 'แจ้งสถานะ',
            //           index: '/7',
            //         ),
            //         ButtonMenu(
            //           iconImagePath: Icons.note,
            //           buttonText: 'รายงาน',
            //           index: '/0',
            //         ),

            //       ],
            //     ),
              /*
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'GHB',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: iOrangeColor,
                          ),
                        ),
                        Text(
                          ' Benefit' 
                          //+ user.email!
                          ,
                          style: TextStyle(fontSize: 28, color:iOrangeColor),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: iGreyColor,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.person),
                        color: iOrangeColor,
                        onPressed: () {
                        //  Navigator.of(context).push(MaterialPageRoute(
                          //    builder: (context) => ()));
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Hi!',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: iBlueColor,
                          ),
                        ),
                        Text(
                          '  ' 
                          + user.email!
                          ,
                          style: TextStyle(fontSize: 18, color:iBlueColor),
                        ),
                      ],
                    ),
                   
                  ],
                ),
              ),
              
              SizedBox(height: 20),
/*
              Container(
                  height:400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                  color: Colors.white,
                ),
                margin: EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 250,
                      child: PieChart(
                        PieChartData(
                          borderData: FlBorderData(show: false),
                          centerSpaceRadius: 50.0,
                          sectionsSpace: 10.0,
                          startDegreeOffset: 30,
                          sections: _buildPieChartCurves(),
                          pieTouchData: PieTouchData(
                            touchCallback: (PieTouchResponse) {
                              setState(() {
                                if (PieTouchResponse.touchInput is FlLongPressEnd ||
                                PieTouchResponse.touchInput is FlPanEnd ){
                                  _touchedIndex = -1;

                                } else {
                                  _touchedIndex = PieTouchResponse.touchedSectionIndex;
                                }
                              });
                              
                            },
                          ),
                        ),
                      ),
                    ),

                    Expanded(child: Container(
                      margin: EdgeInsets.symmetric(vertical: 100),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IndicatorWidget(
                            title : 'user',
                            subtitle : '8000'
                          ),
                          IndicatorWidget(
                            title : 'ala',
                            subtitle : '32000'
                          ),
                        ],
                      ),
                    ),),
                  ],
                ),


              ),
              */
       /// my dash border
       Container(

        child: Padding(
          padding:  const EdgeInsets.symmetric(horizontal: 25.0),
          
          child: Text('My Dashboard', textAlign: TextAlign.left,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color:iBlueColor),),

        ),
       ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Container(
                
            child:  Column(
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
                        fontWeight: FontWeight.bold,
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
                                      value: 32000,
                                      showTitle: false,
                                      radius: 25,
                                    ),
                                    PieChartSectionData(
                                      color: Colors.green,
                                      value: 8000,
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
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                                        '32000',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
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
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                                        '8000',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
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
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                                        '40000',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                        ),
                      ],
                    ),
                                /*  Row(
                                    children: [
                                      const Text(
                                        'เงินที่ใช้ได้',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                     
                                      const Text(
                                        '32,000',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),*/
                                  /*
                                                              Column(
                                    children: [
                                      const Text(
                                        'เงินที่ใช้ไป',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text(''),
                                      const Text(
                                        '8,000',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                   Row(
                                    children: [
                                      const Text(
                                        'วงเงินตามสิทธิ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text(''),
                                      const Text(
                                        '40,000',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ), 
                                  */
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
                        fontWeight: FontWeight.bold,
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
                                      value: 32000,
                                      showTitle: false,
                                      radius: 25,
                                    ),
                                    PieChartSectionData(
                                      color: Colors.green,
                                      value: 8000,
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
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                                        '32000',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
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
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                                        '8000',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
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
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                                        '40000',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                        ),
                      ],
                    ),
                                /*  Row(
                                    children: [
                                      const Text(
                                        'เงินที่ใช้ได้',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                     
                                      const Text(
                                        '32,000',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),*/
                                  /*
                                                              Column(
                                    children: [
                                      const Text(
                                        'เงินที่ใช้ไป',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text(''),
                                      const Text(
                                        '8,000',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                   Row(
                                    children: [
                                      const Text(
                                        'วงเงินตามสิทธิ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text(''),
                                      const Text(
                                        '40,000',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ), 
                                  */
                                  ],   
                    ),
                    

                  ],
                ),
            ),

 

   
 
  
   

////end
          ],
        ),
               ),
             ),
             */
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
                              fontWeight: FontWeight.bold,
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
                                   if (context.watch<MyDashboardProviders>()
                                          .RemainMedicalModalChoice != 0.0) ...[
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
                                   ] else ...[
                   PieChartSectionData(
                                    color: Colors.blue,
                                    value:  context
                                          .watch<MyDashboardProviders>()
                                          .RemainEducationModalChoice,
                                    showTitle: false,
                                    radius: 25,
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
                                          fontWeight: FontWeight.bold),
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
                                        fontWeight: FontWeight.bold,
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
                                          .SumMedicalModalChoice
                                          .toString(),
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
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
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      AMedical.toString(),
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
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
                              fontWeight: FontWeight.bold,
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
                                   if (context.watch<MyDashboardProviders>()
                                          .RemainEducationModalChoice != 0.0) ...[
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
                                   ] else ...[
                   PieChartSectionData(
                                    color: Colors.blue,
                                    value:  context
                                          .watch<MyDashboardProviders>()
                                          .RemainEducationModalChoice,
                                    showTitle: false,
                                    radius: 25,
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
                                          fontWeight: FontWeight.bold),
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
                                        fontWeight: FontWeight.bold,
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
                                        fontWeight: FontWeight.bold,
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
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      AMedical.toString(),
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
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







/*


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GHB Benefits'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(10.0),
              //height: double.infinity,
              width: 450,
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
                            height: 100,
                            child: PieChart(
                              PieChartData(
                                sections: [
                                  //
                                  PieChartSectionData(
                                    color: Colors.blue,
                                    value: 80,
                                    showTitle: false,
                                    radius: 25,
                                  ),
                                  PieChartSectionData(
                                    color: Colors.green,
                                    value: 20,
                                    showTitle: false,
                                    radius: 25,
                                  ),
                                ], //
                              ),
                            ),
                          ),
                  const Divider(),
                  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    const Text(
                                      'เงินที่ใช้ได้',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(''),
                                    const Text(
                                      '32,000',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                                            Column(
                                  children: [
                                    const Text(
                                      'เงินที่ใช้ไป',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(''),
                                    const Text(
                                      '8,000',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                 Column(
                                  children: [
                                    const Text(
                                      'วงเงินตามสิทธิ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(''),
                                    const Text(
                                      '40,000',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ), 
                                ],   
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AddMedPage()));
                              },
                              child: const Text('ยื่นคำขอเบิกค่ารักษาพยาบาล'),
                            ),
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
              width: 450,
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
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                          SizedBox(
                            height: 100,
                            child: PieChart(
                              PieChartData(
                                sections: [
                                  //
                                  PieChartSectionData(
                                    color: Colors.blue,
                                    value: 80,
                                    showTitle: false,
                                    radius: 25,
                                  ),
                                  PieChartSectionData(
                                    color: Colors.green,
                                    value: 20,
                                    showTitle: false,
                                    radius: 25,
                                  ),
                                ], //
                              ),
                            ),
                          ),
                  const Divider(),
                  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    const Text(
                                      'เงินที่ใช้ได้',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(''),
                                    const Text(
                                      '32,000',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                                            Column(
                                  children: [
                                    const Text(
                                      'เงินที่ใช้ไป',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(''),
                                    const Text(
                                      '8,000',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                 Column(
                                  children: [
                                    const Text(
                                      'วงเงินตามสิทธิ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(''),
                                    const Text(
                                      '40,000',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ), 
                                ],   
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AddEduPage()));
                              },
                              child: const Text('ยื่นคำขอเบิกค่าช่วยเหลือการศึกษาบุตร'),
                            ),
                         ),  
                          ],                 
                  ),
                ],
              ),
            ),

 

   
 
  
   

////end
          ],
        ),
      ),
    );
  }
}

void _onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
  });
}
*/