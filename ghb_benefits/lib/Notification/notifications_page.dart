
//import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:ghb_benefits/All_Controllers/Notifications_controllers.dart';
import 'package:ghb_benefits/All_Models/Notifications_model.dart';
import 'package:ghb_benefits/All_Models/medical_model.dart';
import 'package:ghb_benefits/All_Page/Medical/add_medical_page.dart';
import 'package:ghb_benefits/All_Page/Medical/detail_medical_page.dart';
import 'package:ghb_benefits/All_Providers/provider_dashboard.dart';
import 'package:ghb_benefits/All_Providers/provider_medical.dart';
import 'package:ghb_benefits/All_Providers/provider_notifications.dart';
import 'package:ghb_benefits/All_Services/servics.dart';
import 'package:ghb_benefits/Notification/detail_notifications_page.dart';

import 'package:ghb_benefits/color.dart';
import 'package:ghb_benefits/main_home_page.dart';

import 'package:ghb_benefits/my_drawer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

//import 'package:flutter/widgets.dart';


class NotificationsPage extends StatefulWidget {
  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
    List<Notifications> medicals = List.empty();
        List<Notifications> beNotification = List.empty();
  bool isloading = false;
  late int count ;

  NotificationsController controller =
      NotificationsController(FirebaseServices());
      

      void initState() {
        super.initState();
        _getNotifications(context);
      }

   void   _getNotifications(BuildContext context) async {
            var newNotification = await controller.fetchNotifications();
            var be = beNotification ;
             newNotification.sort((a,b) => a.no.compareTo(b.no));

             beNotification =  newNotification.reversed.toList();
setState(() {

});
            

          context.read<NotificationsProviders>().NotificationsList = beNotification;
      }
  @override
    Widget build(BuildContext context) {
          return Consumer<NotificationsProviders>(
      builder: (context, value, child) {
    return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  
                        
                         icon: Icon(Icons.arrow_back),
                          
                        color: iWhiteColor,
                        onPressed: () {
                            // FirebaseAuth.instance.signOut();
                            Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MainHomePage()));
                        },
                      ),
              title: Text('รายการแจ้งเตือน',style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                            color: iWhiteColor,
                          ),),
      backgroundColor: iBlueColor,  actions: [
        
  
                // IconButton(
                  
                        
                //          icon: Icon(Icons.back_hand_rounded),
                          
                //         color: iWhiteColor,
                //         onPressed: () {
                //             // FirebaseAuth.instance.signOut();
                //             Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => MainHomePage()));
                //         },
                //       ),

      ],
        ),
            body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<NotificationsProviders>(
          builder: (context,NotificationsProviders data,child){
             print(data.NotificationsList);
            return data.NotificationsList.length !=0 ? ListView.builder(
              itemCount: data.NotificationsList.length,
              
              itemBuilder: (context,index){
                print(data.NotificationsList.length);


                return CardList(data.NotificationsList[index],index);
              },
            ): GestureDetector(
              //onTap: (){ Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddChildAllowancePage()));},
              child: Center(child: Text("ไม่พบรายการคำขอ",style: TextStyle(color: iBlueColor,fontFamily: 'Sarabun',),)));
          },
        ),
      ),
    

      );
 }
      );
  }
}


 class CardList extends StatelessWidget {
  final Notifications notes;
  int index;
  CardList(this.notes,this.index);
  
  @override
  Widget build(BuildContext context) {
                          NumberFormat myFormat =
                          NumberFormat.decimalPattern('en_us');

        if (notes.read == 0)  {
            return Padding(
      padding: const EdgeInsets.all(2.0),

        child: Container(
             decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.white,
                        ),
                        color: iRequestColor,
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
              tileColor: iAllColor,
            // leading: Icon(Icons.notifications),
              title: Column(  children: [
                                    Row(
                    children: [
                      Expanded(child: Text(notes.createDate,style: TextStyle(fontFamily: 'Sarabun',),)),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Expanded(child: Text(notes.title,style: TextStyle(fontFamily: 'Sarabun',),)),
                    ],
                  ),
                ],
                
                
                ),
              subtitle: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(notes.content.substring(0, 35) + "...",style: TextStyle(fontFamily: 'Sarabun',),)),
                    ],
                  ),
                ],
              ),
              trailing: Icon(Icons.arrow_forward_ios,color: Colors.black26,),
               onTap: () {
                    Navigator.push( context,MaterialPageRoute(builder: (context) =>DetailNotifacationsPage(Notes : notes, Indexs : index)));
                    },
            ),
          
        ),
    );
        } else {
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
            // leading: Icon(Icons.notifications),
              title: Column(  children: [
                                    Row(
                    children: [
                      Expanded(child: Text(notes.createDate,style: TextStyle(fontFamily: 'Sarabun',),)),
                    ],
                  ),
                                                      Row(
                    children: [
                      Expanded(child: Text(notes.title,style: TextStyle(fontFamily: 'Sarabun',),)),
                    ],
                  ),
                ],
                
                
                ),
              subtitle: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(notes.content.substring(0, 35) + "...",style: TextStyle(fontFamily: 'Sarabun',),)),
                    ],
                  ),
                ],
              ),
              trailing: Icon(Icons.arrow_forward_ios,color: Colors.black26,),
               onTap: () {
                     Navigator.push( context,MaterialPageRoute(builder: (context) =>DetailNotifacationsPage(Notes : notes, Indexs : index)));
                    },
            ),
          
        ),
    );
        }                
    // return Padding(
    //   padding: const EdgeInsets.all(2.0),

    //     child: Container(
    //       decoration: BoxDecoration(
    //         color: Colors.white,
    //         borderRadius: BorderRadius.only(
    //           bottomLeft: Radius.circular(10),
    //           topLeft: Radius.circular(10),
    //         )
    //       ),
    //       child: Card(
    //         child: ListTile(
    //         // leading: Icon(Icons.notifications),
    //           title: Column(  children: [
    //                                 Row(
    //                 children: [
    //                   Expanded(child: Text(notes.createDate,style: TextStyle(fontFamily: 'Sarabun',),)),
    //                 ],
    //               ),
    //                                                   Row(
    //                 children: [
    //                   Expanded(child: Text(notes.title,style: TextStyle(fontFamily: 'Sarabun',),)),
    //                 ],
    //               ),
    //             ],
                
                
    //             ),
    //           subtitle: Column(
    //             children: [
    //               Row(
    //                 children: [
    //                   Expanded(child: Text(notes.content.substring(0, 35) + "...",style: TextStyle(fontFamily: 'Sarabun',),)),
    //                 ],
    //               ),
    //             ],
    //           ),
    //           trailing: Icon(Icons.arrow_forward_ios,color: Colors.black26,),
    //            onTap: () {
    //                 // Navigator.push( context,MaterialPageRoute(builder: (context) =>DetailMedicalPage(Notes : notes)));
    //                 },
    //         ),
    //       ),
    //     ),
    // );
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
