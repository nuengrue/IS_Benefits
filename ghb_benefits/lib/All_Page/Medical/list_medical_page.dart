
//import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ghb_benefits/All_Controllers/Medical_Controller.dart';
import 'package:ghb_benefits/All_Models/medical_model.dart';
import 'package:ghb_benefits/All_Page/Medical/add_medical_page.dart';
import 'package:ghb_benefits/All_Page/Medical/detail_medical_page.dart';
import 'package:ghb_benefits/All_Providers/provider_dashboard.dart';
import 'package:ghb_benefits/All_Providers/provider_medical.dart';
import 'package:ghb_benefits/All_Services/servics.dart';

import 'package:ghb_benefits/color.dart';

import 'package:ghb_benefits/my_drawer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

//import 'package:flutter/widgets.dart';


class ListMedicalPage extends StatefulWidget {
  @override
  State<ListMedicalPage> createState() => _ListMedicalPageState();
}

class _ListMedicalPageState extends State<ListMedicalPage> {
    List<Medical> medicals = List.empty();
  bool isloading = false;
  late int count ;

  MedicalController controller =
      MedicalController(FirebaseServices());
      

      void initState() {
        super.initState();
        _getMedical(context);
      }

   void   _getMedical(BuildContext context) async {
            var newMedical = await controller.fetchMedical();
                         newMedical.sort((a,b) => a.no.compareTo(b.no));

             medicals =  newMedical.reversed.toList();

          context.read<MedicalProviders>().MedicalList = medicals;
      }
  @override
    Widget build(BuildContext context) {
          return Consumer<MyDashboardProviders>(
      builder: (context, value, child) {
    return Scaffold(
            appBar: AppBar(title: Text('รายการคำขอเบิกค่ารักษาพยาบาล',style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                            color: iWhiteColor,
                          ),),
      backgroundColor: iBlueColor,
      //  actions: <Widget>[
                    
      //     IconButton(
      //       icon: const Icon(Icons.add),
      //       // tooltip: 'Show Snackbar',
      //       onPressed: () {

      //         Navigator.of(context).push(
      //             MaterialPageRoute(builder: (context) => AddMedPage()));
      //       },
      //     ),
      //   ],
        ),
      //             floatingActionButton: FloatingActionButton(  
      //   child: Icon(Icons.add),  
      //   backgroundColor: iBlueColor,  
      //   foregroundColor: Colors.white,  
      //       onPressed: () {

      //         Navigator.of(context).push(
      //             MaterialPageRoute(builder: (context) => AddMedPage()));
      //       },
      // ),
        /*
body:FutureBuilder<List<ChildAllowance>>(
    future: _getChildAllowance(context),
    
    builder: (context, snapshot) {

      if (!snapshot.hasData) return Container();
      //List<ChildAllowance>? notes = snapshot.data;
          
                        return CardList(allowances);
    },
  ),
  */

 
            body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<MedicalProviders>(
          builder: (context,MedicalProviders data,child){
             print(data.MedicalList);
//              setState(() {
//   count = data.ChildAllowanceList.length;
// });
           // return data.getChildAllowane.length !=0 ? ListView.builder(
            return data.MedicalList.length !=0 ? ListView.builder(
              itemCount: data.MedicalList.length,
              
              itemBuilder: (context,index){
                print(data.MedicalList.length);


                return CardList(data.MedicalList[index],index);

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
            ): GestureDetector(
              //onTap: (){ Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddChildAllowancePage()));},
              child: Center(child: Text("ไม่พบรายการคำขอ",style: TextStyle(color: iBlueColor,fontFamily: 'Sarabun',),)));
          },
        ),
      ),
     
             drawer: MyDrawer(),
               persistentFooterButtons: <Widget>[
             if (value.SumMedicalModalChoice.toString() == '40000.0') ...[
                   
 Text('ท่านได้ใช้วงเงินตามสิทธิ์ครบกำหนดแล้ว: ${value.SumMedicalModalChoice.toString()} บาท ',style: TextStyle(
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
                  MaterialPageRoute(builder: (context) => AddMedPage()));
            },
      ),
    ]




      ]

      );
 }
      );
  }
}


 class CardList extends StatelessWidget {
  final Medical notes;
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
                  Expanded(child: Text(notes.idreceiptnumber, textAlign: TextAlign.end,)),
                ],),
              subtitle: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Text('จำนวนเงินร้องขอ',
                                // textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),)),
                      Expanded(child: Text(myFormat.format(int.parse(notes.receiptamount)), textAlign: TextAlign.end,)),
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
                    Navigator.push( context,MaterialPageRoute(builder: (context) =>DetailMedicalPage(Notes : notes)));
                    },
            ),
          
        ),
    );
  }
}
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('รายการคำขอเบิก'),
//            actions: <Widget>[
//           IconButton(
//             icon: const Icon(Icons.add),
//             // tooltip: 'Show Snackbar',
//             onPressed: () {
//               Navigator.of(context).push(
//                   MaterialPageRoute(builder: (context) => AddMedPage()));
//             },
//           ),
//         ],
//         ),
//         body: ListView.builder(
//             itemCount: ListdataMedicalmodal.length,
//             itemBuilder: (context, index) {
//               ListdataMedical listdatamedical = ListdataMedicalmodal[index];
//               return Card(
//                 child: ListTile(
//                   title: Text(listdatamedical.idreceiptnumber),
//                   subtitle: Text(listdatamedical.savedate),
//                   trailing: Icon(Icons.arrow_circle_right),
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) =>
//                                 SubDetailMedicalPage(listdatamedical)));
//                   },
//                 ),
//               );
//             }));
//   }
// }


//import 'dart:developer';
/*
import 'package:flutter/material.dart';
import 'package:ghb_benefits/color.dart';
import 'package:ghb_benefits/medical/add_medical_page.dart';
import 'package:ghb_benefits/medical/medical_model.dart';
import 'package:ghb_benefits/medical/provider.dart';
import 'package:ghb_benefits/medical/subdetail_medical_page.dart';
import 'package:ghb_benefits/my_drawer.dart';
import 'package:provider/provider.dart';

//import 'package:flutter/widgets.dart';

class DetailMedicalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(title: Text('รายการคำขอเบิกค่ารักษาพยาบาล',style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: iOrangeColor,
                          ),),
      backgroundColor: iBlueColor,
       actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            // tooltip: 'Show Snackbar',
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddMedPage()));
            },
          ),
        ],),
        /*
        appBar: AppBar(
          title: const Text('รายการคำขอเบิก'),
           actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            // tooltip: 'Show Snackbar',
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddMedPage()));
            },
          ),
        ],
        ),
        */
             body:  Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Consumer<MedicalModelProviders>(
                       builder: (context,MedicalModelProviders data,child){
                        // return data.getChildAllowane.length !=0 ? ListView.builder(
                         return data.getmedicalModel.length !=0 ? ListView.builder(
                itemCount: data.getmedicalModel.length,
                itemBuilder: (context,index){
             
                  return CardList(data.getmedicalModel[index],index);
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
                  
                  
                  CardList(data.getmedicalModel[index],index);
                },
                         ): GestureDetector(onTap: (){
                 Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddMedPage()));
                         },child: Center(child: Text("ไม่พบรายการคำขอ",style: TextStyle(color: iBlueColor,),)));
                       },
                     ),
                   ),
             
             drawer: MyDrawer(),
      );
  }

 
}

 class CardList extends StatelessWidget {
  final MedicalModel notes;
  int index;
  CardList(this.notes,this.index);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),

        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topLeft: Radius.circular(10),
            )
          ),
          child: ListTile(
           leading: Icon(Icons.note),
            title: Text(notes.idreceiptnumber),
            subtitle: Text(notes.status),
            trailing: Icon(Icons.arrow_forward_ios,color: Colors.black26,),
             onTap: () {
                  Navigator.push( context,MaterialPageRoute(builder: (context) =>SubDetailMedicalPage(Notes : notes)));
                  },
          ),
        ),
    );
  }
}
*/
