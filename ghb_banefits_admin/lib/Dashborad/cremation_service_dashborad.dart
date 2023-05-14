// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:ghb_banefits_admin/All_Controllers_Admin/cremation_service_controllers.dart';
// import 'package:ghb_banefits_admin/All_Providers_Admin/provider_cremation.dart';
// import 'package:ghb_banefits_admin/All_Services_Admin/servics.dart';
// import 'package:ghb_banefits_admin/Dashborad/boxdashborad.dart';
// import 'package:ghb_banefits_admin/color.dart';
// import 'package:ghb_banefits_admin/main_home_admin_page.dart';
// import 'package:ghb_banefits_admin/my_drawer.dart';

// import 'package:provider/provider.dart';

// //import 'package:flutter/widgets.dart';

// class CremationServiceDashboradPage extends StatefulWidget {
//   @override
//   State<CremationServiceDashboradPage> createState() => _CremationServiceDashboradPageState();
// }

// class _CremationServiceDashboradPageState extends State<CremationServiceDashboradPage> {
//   // List<CremationServiceAdminProviders> allowances = List.empty();
//   // bool isloading = false;
//   // late int count ;

//   CremationServiceAdminController controller =
//       CremationServiceAdminController(FirebaseServicesAdmin());
      

//       void initState() {
//         super.initState();
//         _getCremationServiceAdmin(context);
//       }

//    void   _getCremationServiceAdmin(BuildContext context) async {
//             var newCremationServiceAdmin = await controller.fetchCremationServiceAdmin();
//             context.read<CremationServiceAdminProviders>().CremationServiceAdminList = newCremationServiceAdmin;
//             // count All Status
//             var cAll = newCremationServiceAdmin;
//             int vAll = cAll.length;
//             context.read<CremationServiceAdminProviders>().fliecountAllCremationServiceAdmin = vAll;
//             // count  Status Request
//             var cRequest = newCremationServiceAdmin.where((x) => x.status == "ร้องขอ");
//             int vRequest = cRequest.length;
//             context.read<CremationServiceAdminProviders>().fliecountRequestCremationServiceAdmin = vRequest;
//             // count  Status Approve
//             var cApprove = newCremationServiceAdmin.where((x) => x.status == "Approve");
//             int vApprove = cApprove.length;
//             context.read<CremationServiceAdminProviders>().fliecountApproveCremationServiceAdmin = vApprove;

//              // count  Status Reject
//             var cReject = newCremationServiceAdmin.where((x) => x.status == "Reject");
//             int vReject = cReject.length;
//             context.read<CremationServiceAdminProviders>().fliecountRejectCremationServiceAdmin = vReject;           

        
//       }


//   Widget build(BuildContext context) {
//     return Scaffold(
//             appBar: AppBar(title: Text('ภาพรวมรายการฌาปนกิจสงเคราะห์',style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: iOrangeColor,
//                           ),),
//       backgroundColor: iBlueColor,
//                   actions: <Widget>[
//           IconButton(
//             icon: const Icon(Icons.home),
//             // tooltip: 'Show Snackbar',
//             onPressed: () {

//               Navigator.of(context).push(
//                   MaterialPageRoute(builder: (context) => MainHomeAdminPage()));
//             },
//           ),
//         ],),
 
//    body: SingleChildScrollView(
//         child: Column(children: <Widget>[
//           SizedBox(height: 12),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               "ภาพรวมรายการค่าช่วยเหลือบุตร",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: iBlueColor,
//               ),
//             ),
//           ),
//           SizedBox(height: 12),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                   Column(
//                   children: [
//                     Text(
//                       'Total All',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: iBlueColor,
//                       ),
//                     ),
//                     SizedBox(height: 12),
//                     InkWell(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const ListChildAllowanceWhereAdminPage(Status:"Total All")));
//                       },
//                       child: Container(
//                         height: 80,
//                         width: 150,
//                         padding: EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: iAllColor,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black54,
//                               blurRadius: 6.0,
//                               spreadRadius: 2.0,
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Text(
//                             context
//                         .watch<ChildAllowanceAdminProviders>()
//                         .fliecountAllChildAllowanceAdmin.toString(),
//                             style: TextStyle(
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                               color: iBlackColor,
//                             ),
//                           ),
//                           //Image.asset(iconImagePath),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                   Column(
//                   children: [
//                     Text(
//                       'Request',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: iBlueColor,
//                       ),
//                     ),
//                     SizedBox(height: 12),
//                     InkWell(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const ListChildAllowanceWhereAdminPage(Status:"ร้องขอ")));
//                       },
//                       child: Container(
//                         height: 80,
//                         width: 150,
//                         padding: EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: iRequestColor,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black54,
//                               blurRadius: 6.0,
//                               spreadRadius: 2.0,
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Text(
//                             context
//                                 .watch<ChildAllowanceAdminProviders>()
//                                 .fliecountRequestChildAllowanceAdmin
//                                 .toString(),
//                             style: TextStyle(
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                               color: iBlackColor,
//                             ),
//                           ),
//                           //Image.asset(iconImagePath),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 // BoxDashborad(
//                 //     countnum: context
//                 //         .watch<ChildAllowanceAdminProviders>()
//                 //         .fliecountAllChildAllowanceAdmin,
//                 //     buttonText: 'Total All',
//                 //     indexColor: iAllColor,
//                 //     url:
//                 //         'Navigator.of(context).push(MaterialPageRoute(builder: (context) =>MainHomeAdminPage()));'),
//                 // BoxDashborad(
//                 //     countnum: context
//                 //         .watch<ChildAllowanceAdminProviders>()
//                 //         .fliecountRequestChildAllowanceAdmin,
//                 //     buttonText: 'Request',
//                 //     indexColor: iRequestColor,
//                 //     url:
//                 //         'Navigator.of(context).push(MaterialPageRoute(builder: (context) =>MainHomeAdminPage()));'),
//                 // Column(
//                 //   children: [
//                 //     Text(
//                 //       'Request',
//                 //       style: TextStyle(
//                 //         fontSize: 20,
//                 //         fontWeight: FontWeight.bold,
//                 //         color: iBlueColor,
//                 //       ),
//                 //     ),
//                 //     SizedBox(height: 12),
//                 //     InkWell(
//                 //       onTap: () {
//                 //         Navigator.of(context).push(MaterialPageRoute(
//                 //             builder: (context) => MainHomeAdminPage()));
//                 //       },
//                 //       child: Container(
//                 //         height: 80,
//                 //         width: 150,
//                 //         padding: EdgeInsets.all(20),
//                 //         decoration: BoxDecoration(
//                 //           color: iRequestColor,
//                 //           borderRadius: BorderRadius.circular(20),
//                 //           boxShadow: [
//                 //             BoxShadow(
//                 //               color: Colors.black54,
//                 //               blurRadius: 6.0,
//                 //               spreadRadius: 2.0,
//                 //             ),
//                 //           ],
//                 //         ),
//                 //         child: Center(
//                 //           child: Text(
//                 //             context
//                 //                 .watch<ChildAllowanceAdminProviders>()
//                 //                 .fliecountRequestChildAllowanceAdmin
//                 //                 .toString(),
//                 //             style: TextStyle(
//                 //               fontSize: 25,
//                 //               fontWeight: FontWeight.bold,
//                 //               color: iBlackColor,
//                 //             ),
//                 //           ),
//                 //           //Image.asset(iconImagePath),
//                 //         ),
//                 //       ),
//                 //     ),
//                 //   ],
//                 // ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                      Column(
//                   children: [
//                     Text(
//                       'Approve',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: iBlueColor,
//                       ),
//                     ),
//                     SizedBox(height: 12),
//                     InkWell(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const ListChildAllowanceWhereAdminPage(Status:"Approve")));
//                       },
//                       child: Container(
//                         height: 80,
//                         width: 150,
//                         padding: EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: iApproveColor,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black54,
//                               blurRadius: 6.0,
//                               spreadRadius: 2.0,
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Text(
//                             context
//                         .watch<ChildAllowanceAdminProviders>()
//                         .fliecountApproveChildAllowanceAdmin
//                                 .toString(),
//                             style: TextStyle(
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                               color: iBlackColor,
//                             ),
//                           ),
//                           //Image.asset(iconImagePath),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 // BoxDashborad(
//                 //     countnum: context
//                 //         .watch<ChildAllowanceAdminProviders>()
//                 //         .fliecountApproveChildAllowanceAdmin,
//                 //     buttonText: 'Approve',
//                 //     indexColor: iApproveColor,
//                 //     url:
//                 //         'Navigator.of(context).push(MaterialPageRoute(builder: (context) =>MainHomeAdminPage()));'),
//                 // BoxDashborad(
//                     // countnum: context
//                     //     .watch<ChildAllowanceAdminProviders>()
//                     //     .fliecountRejectChildAllowanceAdmin,
//                     // buttonText: 'Reject',
//                     // indexColor: iRejectColor,
//                     // url:
//                     //     'Navigator.of(context).push(MaterialPageRoute(builder: (context) =>MainHomeAdminPage()));'),
//                      Column(
//                   children: [
//                     Text(
//                       'Reject',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: iBlueColor,
//                       ),
//                     ),
//                     SizedBox(height: 12),
//                     InkWell(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const ListChildAllowanceWhereAdminPage( Status:"Reject")));
//                       },
//                       child: Container(
//                         height: 80,
//                         width: 150,
//                         padding: EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: iRejectColor,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black54,
//                               blurRadius: 6.0,
//                               spreadRadius: 2.0,
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Text(
//                             context
//                         .watch<ChildAllowanceAdminProviders>()
//                         .fliecountRejectChildAllowanceAdmin
//                                 .toString(),
//                             style: TextStyle(
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                               color: iBlackColor,
//                             ),
//                           ),
//                           //Image.asset(iconImagePath),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),             
             
             
//               ],
//             ),
//           ),
//         ]),
//       ),

//              //drawer: const MyDrawer(),
//       );
//   }
// }


// //  class CardList extends StatelessWidget {
// //   final ChildAllowance notes;
// //   int index;
// //   CardList(this.notes,this.index);
  
// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.all(2.0),

// //         child: Container(
// //           decoration: BoxDecoration(
// //             color: Colors.white,
// //             borderRadius: BorderRadius.only(
// //               bottomLeft: Radius.circular(10),
// //               topLeft: Radius.circular(10),
// //             )
// //           ),
// //           child: ListTile(
// //            leading: Icon(Icons.note),
// //             title: Text(notes.no),
// //             subtitle: Text(notes.status),
// //             trailing: Icon(Icons.arrow_forward_ios,color: Colors.black26,),
// //              onTap: () {
// //                   Navigator.push( context,MaterialPageRoute(builder: (context) =>DetailChildAllowancePage(Notes : notes, Indexs : index)));
// //                   },
// //           ),
// //         ),
// //     );
// //   }
// // }

