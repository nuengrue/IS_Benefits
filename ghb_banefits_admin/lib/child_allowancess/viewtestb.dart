// import 'package:flutter/material.dart';
// import 'package:ghb_banefits_admin/child_allowance/child_allowance_controllers.dart';
// import 'package:ghb_banefits_admin/child_allowance/child_allowane_model_admid.dart';
// import 'package:ghb_banefits_admin/child_allowance/provider_child_allowance_admin.dart';
// import 'package:ghb_banefits_admin/child_allowance/servics.dart';
// import 'package:provider/provider.dart';

// class VPage extends StatefulWidget {
//   const VPage({Key? key}) : super(key: key);

//   @override
//   State<VPage> createState() => _VPageState();
// }

// class _VPageState extends State<VPage> {
//   List<ChildAllowance> allowances = List.empty();
//   bool isloading = false;

//   ChildAllowanceController controller =
//       ChildAllowanceController(FirebaseServices());

//   void initState() {
//     super.initState();
//     controller.onSync.listen((bool synState) => setState(() {
//           isloading = synState;
//         }));
//   }

//   void _getChildAllowance(BuildContext context) async {
//     var newAllowance = await controller.fetchChildAllowance();

//     context.read<ChildAllowanceProviders>().ChildAllowanceList = newAllowance;

//     //setState(() => allowances = newAllowance);
//   }

// /*
//   void _updateTodo(Todo todo) async{
//     controller.updateTodo(todo);
//   }
//   */
//   /*
//   Widget get body => isloading
//       ? CircularProgressIndicator()
//       : ListView.builder(
//           itemCount: !allowances.isEmpty ? allowances.length : 1,
//           itemBuilder: (context, index) {
//             if (!allowances.isEmpty) {
//               return Padding(
//                 padding: const EdgeInsets.all(2.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(10),
//                         topLeft: Radius.circular(10),
//                       )),
//                   child: ListTile(
//                     leading: Icon(Icons.note),
//                     title: Text(allowances[index].no),
//                     subtitle: Text(allowances[index].nameemp),
//                     trailing: Icon(
//                       Icons.arrow_forward_ios,
//                       color: Colors.black26,
//                     ),
//                   ),
//                 ),
//               );
//             } else {
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text('Tab button to fetch todos'),
//                 ],
//               );
//             }
//           });
// */
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("HTTP Todos"),
//       ),
//       body: Center(
//         child: Consumer<ChildAllowanceProviders>(
//           builder: (context,ChildAllowanceProviders data, child){
//              print(data.ChildAllowanceList);
//            // return data.getChildAllowane.length !=0 ? ListView.builder(
//             return data.ChildAllowanceList.length !=0 ? ListView.builder(
//               itemCount: data.ChildAllowanceList.length,
//               itemBuilder: (context,index){

//                 return Card(
//                 child: ListTile(
//                   title: Text(data.ChildAllowanceList[index].no),
//                   subtitle: Text(data.ChildAllowanceList[index].status),
//                   trailing: Icon(Icons.arrow_circle_right),
//                 ),
//               );
//               },
//             ): GestureDetector(child: Center(child: Text("ไม่พบรายการคำขอ",style: TextStyle(color: Colors.black,),)));
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _getChildAllowance(context),
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
