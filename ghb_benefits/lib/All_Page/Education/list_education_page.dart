//import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ghb_benefits/All_Controllers/Education_Controller.dart';
import 'package:ghb_benefits/All_Models/education_model.dart';
import 'package:ghb_benefits/All_Providers/provider_dashboard.dart';
import 'package:ghb_benefits/All_Providers/provider_education.dart';
import 'package:ghb_benefits/All_Services/servics.dart';
import 'package:ghb_benefits/color.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'add_education_page.dart';
import 'detail_education.dart';
import 'package:ghb_benefits/my_drawer.dart';
//import 'package:flutter/widgets.dart';

class ListEducationPage extends StatefulWidget {
  @override
  State<ListEducationPage> createState() => _ListEducationPageState();
}

class _ListEducationPageState extends State<ListEducationPage> {

    List<Education> educations = List.empty();
  bool isloading = false;
  late int count ;
   String checkit = '';
  late int ages = 0;
// var sum = context.read<MyDashboardProviders>().SumMedicalModalChoice;
  EducationController controller =
      EducationController(FirebaseServices());
      

      void initState() {
        super.initState();
        _getEducation(context);
        

      }

   void   _getEducation(BuildContext context) async {
            var newEducation = await controller.fetchEducation();

          context.read<EducationProviders>().EducationList = newEducation;

calculateAge(DateTime birthDate) {
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - birthDate.year;
  int month1 = currentDate.month;
  int month2 = birthDate.month;
  if (month2 > month1) {
    age--;
  } else if (month1 == month2) {
    int day1 = currentDate.day;
    int day2 = birthDate.day;
    if (day2 > day1) {
      age--;
    }
  }
  return age;
}
 var a =  "1993-04-01";
DateTime b =  DateTime.parse(a);
          var _age = calculateAge(b);
context.read<MyDashboardProviders>().Childage = _age;
          print(_age);

setState(() {
 ages = _age;
});
          
      }

 @override
  Widget build(BuildContext context) {
    return Consumer<MyDashboardProviders>(
      builder: (context, value, child) {
    return Scaffold(
            appBar: AppBar(  title: Text('รายการคำขอค่าช่วยเหลือการศึกษาบุตร',style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: iWhiteColor,
                          ),),
      backgroundColor: iBlueColor,
      
      //  actions: <Widget>[
      //     IconButton(
      //       icon: const Icon(Icons.add),
      //       // tooltip: 'Show Snackbar',
      //       onPressed: () {
      //         Navigator.of(context).push(
      //             MaterialPageRoute(builder: (context) => AddEduPage()));
      //       },
      //     ),
      //   ],
        ),

      //    floatingActionButton: FloatingActionButton(  
      //   child: Icon(Icons.add),  
      //   backgroundColor: iBlueColor,  
      //   foregroundColor: Colors.white,  
      //       onPressed: () {

      //         Navigator.of(context).push(
      //             MaterialPageRoute(builder: (context) => AddEduPage()));
      //       },
      // ), 
             body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<EducationProviders>(
          builder: (context,EducationProviders data,child){
           // return data.getChildAllowane.length !=0 ? ListView.builder(
            return data.EducationList.length !=0 ? ListView.builder(
              itemCount: data.EducationList.length,
              itemBuilder: (context,index){

                return CardList(data.EducationList[index],index);
                /*Card(
                child: ListTile(
                  title: Text(data.getChildAllowane[index].no),
                  subtitle: Text(data.getChildAllowane[index].status),
                  trailing: Icon(Icons.arrow_circle_right),
                  onTap: () {
                  //  Navigator.push( context,MaterialPageRoute(builder: (context) =>SubListChildAllowancePage(listdatamedical)));
                  },
                ),
              );
                */
      
              },
            ): GestureDetector(onTap: (){
               Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddEduPage()));
            },child: Center(child: Text("ไม่พบรายการคำขอ",style: TextStyle(color: iBlueColor,fontFamily: 'Sarabun',),)));
          },
        ),
      ),

             drawer: MyDrawer(),
      persistentFooterButtons: <Widget>[
             if (value.SumEducationModalChoice.toString() == '40000.0') ...[
                   
 Text('ท่านได้ใช้วงเงินตามสิทธิ์ครบกำหนดแล้ว: ${value.SumEducationModalChoice.toString()} บาท',style: TextStyle(
                      fontSize: 15,
                      color: iOrangeColor,
                      fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                    ),),

    ] else ...[
  //  Text('ท่านได้ใช้วงเงินตามสิทธิ์ครบกำหนดแล้ว: ${value.Childage.toString()}'),

         FloatingActionButton(  
        child: Icon(Icons.add),  
        backgroundColor: iBlueColor,  
        foregroundColor: Colors.white,  
            onPressed: () {

              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddEduPage()));
            },
      ),
    ]

        // floatingActionButton: FloatingActionButton(  
        // child: Icon(Icons.add),  
        // backgroundColor: iBlueColor,  
        // foregroundColor: Colors.white,  
        //     onPressed: () {

        //       Navigator.of(context).push(
        //           MaterialPageRoute(builder: (context) => AddEduPage()));
        //     },
      // ), 


      ]

    
                      
      );
  }
      );
  }
}

 class CardList extends StatelessWidget {
  final Education notes;
  int index;
  CardList(this.notes,this.index);
  @override
  Widget build(BuildContext context) {
                              NumberFormat myFormat =
                          NumberFormat.decimalPattern('en_us');
    return Padding(
      padding: const EdgeInsets.all(2.0),

                   child: Container(
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
        
            child: ListTile(
            //  leading: Icon(Icons.note),
              title: Row(  children: [
                  Expanded(child: Text('เลขที่ใบเสร็จ',
                            // textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),)),
                  Expanded(child: Text(notes.receiptnumber, textAlign: TextAlign.end,)),
                ],),
              subtitle: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Text('ชื่อบุตร',
                                // textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),)),
                      Expanded(child: Text(notes.namechild, textAlign: TextAlign.end,)),
                    ],
                  ),                 
                  Row(
                    children: [
                      Expanded(child: Text('จำนวนเงินร้องขอ',
                                // textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),)),
                      Expanded(child: Text(myFormat.format(int.parse(notes.amountreceipt)), textAlign: TextAlign.end,)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: Text('วันที่บันทึก',
                                // textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),)),
                      Expanded(child: Text(notes.savedate, textAlign: TextAlign.end,)),
                    ],
                  ),
                ],
              ),
              trailing: Text(notes.status,style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',color: iBlueColor,),),
               onTap: () {
                    Navigator.push( context,MaterialPageRoute(builder: (context) =>DetailEducationPage(Notes : notes)));
                    },
            ),
          
        ),
    );
  }
}

