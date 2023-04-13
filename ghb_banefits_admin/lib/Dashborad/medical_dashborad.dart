//import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ghb_banefits_admin/All_Controllers_Admin/Medical_Controller.dart';
import 'package:ghb_banefits_admin/All_Models_Admin/medical_model.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_medical.dart';


import 'package:ghb_banefits_admin/All_Services_Admin/servics.dart';

import 'package:ghb_banefits_admin/Dashborad/boxdashborad.dart';
import 'package:ghb_banefits_admin/color.dart';
import 'package:ghb_banefits_admin/main_home_admin_page.dart';
import 'package:ghb_banefits_admin/my_drawer.dart';
import 'package:provider/provider.dart';

//import 'package:flutter/widgets.dart';

class MedicalDashboradPage extends StatefulWidget {
  @override
  State<MedicalDashboradPage> createState() => _MedicalDashboradPageState();
}

class _MedicalDashboradPageState extends State<MedicalDashboradPage> {
  // List<MedicalAdmin> allowances = List.empty();
  // bool isloading = false;
  // late int count ;

  MedicalAdminController controller =
      MedicalAdminController(FirebaseServicesAdmin());
      

      void initState() {
        super.initState();
        _getMedicalAdmin(context);
      }

   void   _getMedicalAdmin(BuildContext context) async {
            var newMedicalAdmin = await controller.fetchMedicalAdmin();

          context.read<MedicalAdminProviders>().MedicalAdminList = newMedicalAdmin;
            // count All Status
            var cAll = newMedicalAdmin;
            int vAll = cAll.length;
            context.read<MedicalAdminProviders>().fliecountAllMedicalAdmin = vAll;
            // count  Status Request
            var cRequest = newMedicalAdmin.where((x) => x.status == "Request");
            int vRequest = cRequest.length;
            context.read<MedicalAdminProviders>().fliecountRequestMedicalAdmin = vRequest;
            // count  Status Approve
            var cApprove = newMedicalAdmin.where((x) => x.status == "Approve");
            int vApprove = cApprove.length;
            context.read<MedicalAdminProviders>().fliecountApproveMedicalAdmin = vApprove;

             // count  Status Reject
            var cReject = newMedicalAdmin.where((x) => x.status == "Reject");
            int vReject = cReject.length;
            context.read<MedicalAdminProviders>().fliecountRejectMedicalAdmin = vReject;           

        
      }


  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(title: Text('ภาพรวมรายการค่ารักษาพยาบาล',style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: iOrangeColor,
                          ),),
      backgroundColor: iBlueColor,
                    actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            // tooltip: 'Show Snackbar',
            onPressed: () {

              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MainHomeAdminPage()));
            },
          ),
        ],),
 
            body: SingleChildScrollView(

              child: Column(
              children: <Widget>[
                            SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("ภาพรวมรายการค่ารักษาพยาบาล",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: iBlueColor,
            ),
            ),
                ),
                            SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BoxDashborad(
                        countnum: context.watch<MedicalAdminProviders>().fliecountAllMedicalAdmin,
                        buttonText: 'Total All',
                        indexColor:iAllColor,
                      ),
                      BoxDashborad(
                        countnum: context.watch<MedicalAdminProviders>().fliecountRequestMedicalAdmin,
                        buttonText: 'Request',
                        indexColor: iRequestColor,
                      ),

                    ],
                  ),
                ),
                                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BoxDashborad(
                        countnum: context.watch<MedicalAdminProviders>().fliecountApproveMedicalAdmin,
                        buttonText: 'Approve',
                        indexColor:iApproveColor,
                      ),
                      BoxDashborad(
                        countnum: context.watch<MedicalAdminProviders>().fliecountRequestMedicalAdmin,
                        buttonText: 'Reject',
                        indexColor: iRejectColor,
                      ),

                    ],
                  ),
                ),

              //       Container(
              //   margin: const EdgeInsets.all(10.0),
              //   padding: const EdgeInsets.all(10.0),
              //   //height: double.infinity,
              //   width: 200,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(5),
              //     border: Border.all(
              //       color: Colors.white,
              //     ),
              //     color: Colors.white,
              //     boxShadow: [
              //       BoxShadow(
              //         blurRadius: 6.0,
              //         spreadRadius: 2.0,
              //         color: Colors.grey,
              //         offset: Offset(0.0, 0.0),
              //       )
              //     ],
              //   ),
              //   child: Column(
              //     children: <Widget>[
              //       Text(
              //         'Total',
              //         style: TextStyle(
              //           fontSize: 16,
              //           color: Color.fromARGB(255, 9, 28, 235),
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //       const Divider(),
              //        Row(
              //         children: [

              //          Consumer<ChildAllowanceProviders>(
              //               builder: (context, value, child) {
              //                 int Carimg = 0;
              //                 if (value.fliecountAll.toString().isNotEmpty) {
              //                   Carimg = value.fliecountAll;
              //                     return Text(Carimg.toString());
              //                 } else {
              //                   return Text(Carimg.toString());
              //                 }
                            
              //               },
              //             ), 


              //         ],
              //       ),

              //     ],
              //   ),
              // ),
              //  Padding(
              //       padding: const EdgeInsets.all(8.0),
              //                   child: Consumer<ChildAllowanceProviders>(
              //               builder: (context, value, child) {
              //                 int Carimg = 0;
              //                 if (value.fliecountAll.toString().isNotEmpty) {
              //                   Carimg = value.fliecountAll;
              //                     return ListTile(
              //               title: Text(Carimg.toString()),
              //               trailing: Icon(Icons.view_agenda),
            
              //           );
              //                 } else {
              //                   return Text("");
              //                 }
                            
              //               },
              //             ), 
              //     ),
              //          Padding(
              //       padding: const EdgeInsets.all(8.0),
              //                   child: Consumer<ChildAllowanceProviders>(
              //               builder: (context, value, child) {
              //                 int Carimg = 0;
              //                 if (value.fliecountRequest.toString().isNotEmpty) {
              //                   Carimg = value.fliecountRequest;
              //                     return ListTile(
              //               title: Text(Carimg.toString()),
              //               trailing: Icon(Icons.view_agenda),
            
              //           );
              //                 } else {
              //                   return Text("");
              //                 }
                            
              //               },
              //             ), 
              //     ),

              //        Padding(
              //       padding: const EdgeInsets.all(8.0),
              //                   child: Consumer<ChildAllowanceProviders>(
              //               builder: (context, value, child) {
              //                 int Carimg = 0;
              //                 if (value.fliecountApprove.toString().isNotEmpty) {
              //                   Carimg = value.fliecountApprove;
              //                     return ListTile(
              //               title: Text(Carimg.toString()),
              //               trailing: Icon(Icons.view_agenda),
            
              //           );
              //                 } else {
              //                   return Text("");
              //                 }
                            
              //               },
              //             ), 
              //     ),

              //        Padding(
              //       padding: const EdgeInsets.all(8.0),
              //                   child: Consumer<ChildAllowanceProviders>(
              //               builder: (context, value, child) {
              //                 int Carimg = 0;
              //                 if (value.fliecountReject.toString().isNotEmpty) {
              //                   Carimg = value.fliecountReject;
              //                     return ListTile(
              //               title: Text(Carimg.toString()),
              //               trailing: Icon(Icons.view_agenda),
            
              //           );
              //                 } else {
              //                   return Text("");
              //                 }
                            
              //               },
              //             ), 
              //     ),
              ]
              ),
            ),
     
             //drawer: const MyDrawer(),
      );
  }
}


//  class CardList extends StatelessWidget {
//   final ChildAllowance notes;
//   int index;
//   CardList(this.notes,this.index);
  
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(2.0),

//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(10),
//               topLeft: Radius.circular(10),
//             )
//           ),
//           child: ListTile(
//            leading: Icon(Icons.note),
//             title: Text(notes.no),
//             subtitle: Text(notes.status),
//             trailing: Icon(Icons.arrow_forward_ios,color: Colors.black26,),
//              onTap: () {
//                   Navigator.push( context,MaterialPageRoute(builder: (context) =>DetailChildAllowancePage(Notes : notes, Indexs : index)));
//                   },
//           ),
//         ),
//     );
//   }
// }

