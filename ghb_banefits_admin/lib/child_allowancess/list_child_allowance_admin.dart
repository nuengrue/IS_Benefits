// //import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:ghb_banefits_admin/All_Services/servics.dart';
// import 'package:ghb_banefits_admin/child_allowancess/child_allowance_controllers.dart';
// import 'package:ghb_banefits_admin/child_allowancess/child_allowane_model_admid.dart';
// import 'package:ghb_banefits_admin/child_allowancess/detail_child_allowance.dart';
// import 'package:ghb_banefits_admin/child_allowancess/provider_child_allowance_admin.dart';


// import 'package:ghb_banefits_admin/color.dart';
// import 'package:ghb_banefits_admin/my_drawer.dart';
// import 'package:provider/provider.dart';

// //import 'package:flutter/widgets.dart';

// class ListChildAllowanceAdminPage extends StatefulWidget {
//   @override
//   State<ListChildAllowanceAdminPage> createState() => _ListChildAllowanceAdminPageState();
// }

// class _ListChildAllowanceAdminPageState extends State<ListChildAllowanceAdminPage> {
//   List<ChildAllowance> allowances = List.empty();
//   bool isloading = false;
//   late int count ;

//   ChildAllowanceController controller =
//       ChildAllowanceController(FirebaseServices());
      

//       void initState() {
//         super.initState();
//         _getChildAllowance(context);
//       }

//    void   _getChildAllowance(BuildContext context) async {
//             var newAllowance = await controller.fetchChildAllowanceAdmid();

//           context.read<ChildAllowanceProviders>().ChildAllowanceList = newAllowance;
//       }
      
// /*
//   void _getChildAllowance(BuildContext context) async {
//     var newAllowance = await controller.fetchChildAllowance();

//     context.read<ChildAllowanceProviders>().ChildAllowanceList = newAllowance;

//     //setState(() => allowances = newAllowance);
//   }
// */

//   Widget build(BuildContext context) {
//     return Scaffold(
//             appBar: AppBar(title: Text('รายการคำขอเบิกค่าช่วยเหลือบุตร',style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: iOrangeColor,
//                           ),),
//       backgroundColor: iBlueColor,
//        actions: <Widget>[
                    
//           IconButton(
//             icon: const Icon(Icons.add),
//             // tooltip: 'Show Snackbar',
//             onPressed: () {

//               // Navigator.of(context).push(
//               //     MaterialPageRoute(builder: (context) => AddChildAllowancePage()));
//             },
//           ),
//         ],),
//         /*
// body:FutureBuilder<List<ChildAllowance>>(
//     future: _getChildAllowance(context),
    
//     builder: (context, snapshot) {

//       if (!snapshot.hasData) return Container();
//       //List<ChildAllowance>? notes = snapshot.data;
          
//                         return CardList(allowances);
//     },
//   ),
//   */

 
//             body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Consumer<ChildAllowanceProviders>(
//           builder: (context,ChildAllowanceProviders data,child){
//              //print(data.ChildAllowanceList);
// //              setState(() {
// //   count = data.ChildAllowanceList.length;
// // });
//            // return data.getChildAllowane.length !=0 ? ListView.builder(
//             return data.ChildAllowanceList.length !=0 ? ListView.builder(
//               itemCount: data.ChildAllowanceList.length,
              
//               itemBuilder: (context,index){
//                // print(data.ChildAllowanceList.length);


//                 return CardList(data.ChildAllowanceList[index],index);



//               },
//             ): GestureDetector(
//               //onTap: (){ Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddChildAllowancePage()));},
//               child: Center(child: Text("ไม่พบรายการคำขอ",style: TextStyle(color: iBlueColor,),)));
//           },
//         ),
//       ),
     
//              drawer: MyDrawer(),
//       );
//   }
// }


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

