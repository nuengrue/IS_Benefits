

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:ghb_banefits_admin/All_Controllers_Admin/House_controllers.dart';
import 'package:ghb_banefits_admin/All_Controllers_Admin/child_allowance_controllers.dart';
import 'package:ghb_banefits_admin/All_Models_Admin/child_allowane_model.dart';
import 'package:ghb_banefits_admin/All_Models_Admin/house_model.dart';

import 'package:ghb_banefits_admin/All_Page_Admin/Child_Allowances/list_child_allowance.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Education/list_education_page.dart';

import 'package:ghb_banefits_admin/All_Providers_Admin/provider_child_allowance.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_education.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_house.dart';

import 'package:ghb_banefits_admin/All_Services_Admin/servics.dart';
import 'package:ghb_banefits_admin/color.dart';
import 'package:ghb_banefits_admin/main_home_admin_page.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReportHouseAllowancePage extends StatefulWidget {
  const ReportHouseAllowancePage({Key? key}) : super(key: key);

  @override
  State<ReportHouseAllowancePage> createState() => _ReportHouseAllowancePageState();
}

class _ReportHouseAllowancePageState extends State<ReportHouseAllowancePage> {

  List<HouseAllowanceAdmin> filteredData = [];
  List<HouseAllowanceAdmin> data = List.empty();
      List<CategoriesHouseAllowance> filteredDataca = [];
    List<CategoriesHouseAllowance> CategoriesHouses = List.empty();
  late double sumApprove = 0;
  late double sumRequest = 0;
  late double sumReject = 0;

  final searchController = TextEditingController();

  @override
  void initState() {

    // filteredData = data;
    super.initState();
    _getHouseAllowanceAdmin(context);

  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _onSearchTextChanged(String text) {
    setState(() {
      filteredData = text.isEmpty
          ? data
          : data
              .where((item) =>
                  item.name.toLowerCase().contains(text.toLowerCase()) ||
                  item.department.toLowerCase().contains(text.toLowerCase()) ||
                  item.divisionment.toLowerCase().contains(text.toLowerCase()) ||
                  item.savedate.toLowerCase().contains(text.toLowerCase()) ||
                  item.position.toLowerCase().contains(text.toLowerCase()) ||
                  item.positiondate.toLowerCase().contains(text.toLowerCase()) ||
                  item.workstatus.toLowerCase().contains(text.toLowerCase()) ||                                    
                  item.typehouse.toLowerCase().contains(text.toLowerCase()) ||
                  item.moneyhouse.toLowerCase().contains(text.toLowerCase()) ||  
                  item.status.toLowerCase().contains(text.toLowerCase())
                  )
              .toList();
              
              print(data);
    });
  }


  HouseAllowanceAdminController controller =
      HouseAllowanceAdminController(FirebaseServicesAdmin());

   void   _getHouseAllowanceAdmin(BuildContext context) async {
            var _dataHouses = await controller.fetchHouseAllowanceAdmin();

                        print(_dataHouses.length);
            if(_dataHouses.length > 0){
                        setState(() {
              data = _dataHouses;
              filteredData = _dataHouses;
              // print(filteredData);
            });
            context.read<HouseAllowanceAdminProviders>().HouseAllowanceAdminList = _dataHouses;
            }
            // var _dataMedical_app   =   _dataHouses ;
            // var _dataMedical_req   =   _dataHouses ;
            // var _dataMedical_rej   =   _dataHouses ;
    // get data  EducationDashboard
    //var newEducationDashboard = await educationcontroller.fetchEducation();
_dataHouses.forEach((b) {

          if (b.status == "อนุมัติ") {
            sumApprove += int.parse(b.moneyhouse);
          } else if (b.status == "ร้องขอ") {
            sumRequest += int.parse(b.moneyhouse);
          } else if (b.status == "ปฏิเสธ") {
            sumReject += int.parse(b.moneyhouse);
          }

      });

setState(() {
  
});
    //         if(_data.length > 0){
    //                     setState(() {
    //           data = _data;
    //           filteredData = _data;
    //           // print(filteredData);
    //         });
    //         context.read<HouseAllowanceAdminProviders>().HouseAllowanceAdminList = _data;
    //         }
    //         var _data_app   =   _data ;
    //         var _data_req   =   _data ;
    //         var _data_rej   =   _data ;
    // // get data  HouseAllowanceDashboard
    // //var newHouseAllowanceDashboard = await houseAllowancecontroller.fetchHouseAllowance();
    //     if(_data_app.length > 0){
    // var cApproveHouseAllowanceAdmin = _data_app.where((x) => x.status == "อนุมัติ");
    // final houseAllowance = [];
    // for (var doc in cApproveHouseAllowanceAdmin) {
    //   double a = double.parse(doc.moneyhouse);
    //   houseAllowance.add(a);
    // }
    // var _sumApprove = houseAllowance.reduce((a, b) => a + b);
    //                     setState(() {
    //           sumApprove = _sumApprove;
    //           // print(filteredData);
    //         });
    
    //     }
        
    //     if(_data_req.length > 0){
    // var cRequestHouseAllowanceAdmin = _data_req.where((x) => x.status == "ร้องขอ");
    // final houseAllowanceRequest = [];
    // for (var doc in cRequestHouseAllowanceAdmin) {
    //   double b = double.parse(doc.moneyhouse);
    //   print(b);
    //   houseAllowanceRequest.add(b);
    // }
    // var _sumRequest = houseAllowanceRequest.reduce((a, b) => a + b);
    //                 setState(() {
    //           sumRequest = _sumRequest;
    //           // print(filteredData);
    //         });
    //     }
    //     if(_data_rej.length > 0){
    //     var cRejectHouseAllowanceAdmin = _data_rej.where((x) => x.status == "ปฏิเสธ");
    // final houseAllowanceReject = [];
    // for (var doc in cRejectHouseAllowanceAdmin) {
    //   double c = double.parse(doc.moneyhouse);
    //   houseAllowanceReject.add(c);
    // }
    // var _sumReject = houseAllowanceReject.reduce((a, b) => a + b);
    //             setState(() {
    //           sumReject = _sumReject;
    //           // print(filteredData);
    //         });
    //     }
    //         setState(() {
    //           data = _data;
    //           print(_data);
    //           filteredData = _data;
    //           // print(filteredData);
    //         });
     List<CategoriesHouseAllowance> ad = [];
    _dataHouses.forEach((element) {
      ad.add(CategoriesHouseAllowance(element.department, 0, 0, 0));
    });
    // print(jsonEncode(ad));

//  int.parse(element.payamount)
// convert each item to a string by using JSON encoding
    final jsonList = ad.map((item) => jsonEncode(item)).toList();
    // print(jsonList);
    // using toSet - toList strategy
    final uniqueJsonList = jsonList.toSet().toList();
    // print(uniqueJsonList);

    // convert each item back to the original form using JSON decoding
    final result = uniqueJsonList.map((item) => jsonDecode(item)).toList();
    // print(jsonEncode(result));

    // VerifyModel.parseApplList(jsonEncode(result));

    List<CategoriesHouseAllowance> ddd =
        CategoriesHouseAllowance.parseApplList(jsonEncode(result));

    ddd.forEach((a) {
      _dataHouses.forEach((b) {
        if (a.name == b.department) {
          if (b.status == "อนุมัติ") {
            a.amountApprove += int.parse(b.moneyhouse);
          } else if (b.status == "ร้องขอ") {
            a.amountRequest += int.parse(b.moneyhouse);
          } else {
            a.amountReject += int.parse(b.moneyhouse);
          }
        }
      });
    });
    print(jsonEncode(ddd));

    setState(() {
      CategoriesHouses = ddd;
    });         
          // context.read<HouseAllowanceAdminProviders>().HouseAllowanceAdminList = _data;

      }
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
            appBar: AppBar(title: 
             Text('รายงานค่าเช่าบ้านของพนักงาน',
            // Text(widget.Status.toString(),
            style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: iWhiteColor,),),backgroundColor: iOrangeColor,),
    body: SingleChildScrollView(
      child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Card(
                      elevation: 0,
                      color: iWhiteColor,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: iWhiteColor,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(
                              "รายงานค่าเช่าบ้านพนักงานแยกตามฝ่ายงาน",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: iBlueColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
//--

                //--
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Card(
                      elevation: 0,
                      color: iWhiteColor,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: iBlueColor,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(
                              "จำนวนเงินที่อนุมัตินำจ่ายทั้งหมด",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: iBlueColor,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Text(
                              sumApprove.toString(),
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
//--

                //--
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
//--

                //---

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Card(
                      elevation: 0,
                      color: iWhiteColor,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: iBlueColor,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "จำนวนเงินที่รออนุมัตินำจ่ายทั้งหมด",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: iBlueColor,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Text(
                              sumRequest.toString(),
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow[800],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //--
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
//--

                //---

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Card(
                      elevation: 0,
                      color: iWhiteColor,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: iBlueColor,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "จำนวนเงินที่ปฏิเสธนำจ่ายทั้งหมด",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: iBlueColor,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Text(
                              sumReject.toString(),
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //--
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextField(
          //     controller: searchController,
          //     decoration: const InputDecoration(
          //       hintText: 'ค้นหา...',
          //       border: OutlineInputBorder(),
          //     ),
          //     onChanged: _onSearchTextChanged,
          //   ),
          // ),
          SizedBox(
            width: width,
            child: SingleChildScrollView(
              // scrollDirection : Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DataTable(
                  columnSpacing: 0,
                  horizontalMargin: 0,
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Center(child: Flexible(child: Text('ฝ่ายงาน'))),
                    ),
                    DataColumn(
                      label: Center(child: Flexible(child: Text('นำจ่าย'))),
                    ),
                    DataColumn(
                      label: Center(child: Flexible(child: Text('รอนำจ่าย'))),
                    ),
                    DataColumn(
                      label:
                          Center(child: Flexible(child: Text('ปฏิเสธนำจ่าย'))),
                    ),
                  ],
                  rows:
                      List.generate(CategoriesHouses.length, (index) {
                    if (CategoriesHouses.isNotEmpty) {
                      CategoriesHouseAllowance item =
                          CategoriesHouses[index];
                      NumberFormat myFormat =
                          NumberFormat.decimalPattern('en_us');
                      return DataRow(
                        cells: [
                          DataCell(Flexible(child: Text(item.name.toString()))),
                          DataCell(Flexible(
                              child:
                                  Center(child: Text(myFormat.format(item.amountApprove))))),
                          DataCell(Flexible(
                              child:
                                  Center(child: Text(myFormat.format(item.amountRequest))))),
                          DataCell(Flexible(
                              child:
                                  Center(child: Text(myFormat.format(item.amountRequest))))),
                        ],
                      );
                    } else {
                      return DataRow(
                        cells: [
                          DataCell(Text('ไม่มีข้อมูล')),
                          DataCell(Text('ไม่มีข้อมูล')),
                          DataCell(Text('ไม่มีข้อมูล')),
                          DataCell(Text('ไม่มีข้อมูล')),
                        ],
                      );
                    }
                  }),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}


class CategoriesHouseAllowance {
  final String name;
  late int amountApprove;
  late int amountRequest;
  late int amountReject;
  CategoriesHouseAllowance(
      this.name, this.amountApprove, this.amountRequest, this.amountReject);

  factory CategoriesHouseAllowance.fromJson(Map<String, dynamic> json) {
    return CategoriesHouseAllowance(
      json['name'],
      json['amountApprove'],
      json['amountRequest'],
      json['amountReject'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['amountApprove'] = amountApprove;
    data['amountRequest'] = amountRequest;
    data['amountReject'] = amountReject;
    return data;
  }

  static List<CategoriesHouseAllowance> parseApplList(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<CategoriesHouseAllowance> listData = parsed
        .map<CategoriesHouseAllowance>((json) => CategoriesHouseAllowance.fromJson(json))
        .toList();
    return listData;
  }
}


  //  List<HouseAllowanceAdmin> allowances = List.empty();
  //   List<HouseAllowanceAdmin> _Datalist = List.empty();
  // bool isloading = false;
  // late int count ;

  // HouseAllowanceAdminController controller =
  //     HouseAllowanceAdminController(FirebaseServicesAdmin());
      

  //     void initState() {
  //       super.initState();
  //       _getHouseAllowanceAdmin(context);
  //     }

  //  void   _getHouseAllowanceAdmin(BuildContext context) async {
  //           var newAllowance = await controller.fetchHouseAllowanceAdmin();
  //         context.read<HouseAllowanceAdminProviders>().HouseAllowanceAdminListwhere = newAllowance;

  //     }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//             appBar: AppBar(title: 
//              Text('รายงาน',
//             // Text(widget.Status.toString(),
//             style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: iOrangeColor,
//                           ),),
//       backgroundColor: iBlueColor,
//        actions: <Widget>[
                    
//           IconButton(
//             icon: const Icon(Icons.home),
//             // tooltip: 'Show Snackbar',
//             onPressed: () {

//               Navigator.of(context).push(
//                   MaterialPageRoute(builder: (context) => MainHomeAdminPage()));
//             },
//           ),
//         ],),


//          body:
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//            child: Consumer<HouseAllowanceAdminProviders>(
//           builder: (context,HouseAllowanceAdminProviders data,child){
//            return DataTable(
//             // Datatable widget that have the property columns and rows.
//             columns: const [
//               // Set the name of the column
//               DataColumn(label: Text('ID'),),
//               DataColumn(label: Text('Name'),),
//               DataColumn(label: Text('LastName'),),
//               DataColumn(label: Text('Age'),),
//             ],

//             rows: <DataRow>[
//   for (int i = 0; i < data.HouseAllowanceAdminList.length; i += 3)
//       DataRow(cells: [
//                 DataCell(Text( data.HouseAllowanceAdminList[''])),
//                 DataCell(Text("Alex")),
//                 DataCell(Text("Anderson")),
//                 DataCell(Text("16")),
//               ]),
// ],
//             // rows:const [
//             //   // Set the values to the columns 
//             //   DataRow(cells: [
//             //     DataCell(Text("1")),
//             //     DataCell(Text("Alex")),
//             //     DataCell(Text("Anderson")),
//             //     DataCell(Text("16")),
//             //   ]),
//             //   DataRow(cells: [
//             //     DataCell(Text("2")),
//             //     DataCell(Text("John")),
//             //     DataCell(Text("Anderson")),
//             //     DataCell(Text("24")),
//             //   ]),
//             // ]
//           ),
        
//          },
//         ),
//         ),


//     );
//   }
// }

// rows: <DataRow>[
//   for (int i = 0; i < displayedDataCell.length; i += 3)
//     DataRow(cells: [displayedDataCell[i], displayedDataCell[i + 1], displayedDataCell[i + 2]])
// ],


// import 'package:flutter/material.dart';
// import 'package:ghb_banefits_admin/All_Controllers_Admin/House_controllers.dart';
// import 'package:ghb_banefits_admin/All_Controllers_Admin/child_allowance_controllers.dart';
// import 'package:ghb_banefits_admin/All_Models_Admin/child_allowane_model.dart';
// import 'package:ghb_banefits_admin/All_Models_Admin/education_model.dart';
// import 'package:ghb_banefits_admin/All_Models_Admin/house_model.dart';
// import 'package:ghb_banefits_admin/All_Providers_Admin/provider_child_allowance.dart';
// import 'package:ghb_banefits_admin/All_Providers_Admin/provider_education.dart';
// import 'package:ghb_banefits_admin/All_Providers_Admin/provider_house.dart';
// import 'package:ghb_banefits_admin/All_Services_Admin/servics.dart';
// import 'package:ghb_banefits_admin/color.dart';
// import 'package:ghb_banefits_admin/main_home_admin_page.dart';
// import 'package:provider/provider.dart';

// class ReportHouseAllowancePage extends StatefulWidget {
//   const ReportHouseAllowancePage({Key? key}) : super(key: key);

//   @override
//   State<ReportHouseAllowancePage> createState() => _ReportHouseAllowancePageState();
// }

// class _ReportHouseAllowancePageState extends State<ReportHouseAllowancePage> {
//   List<HouseAllowanceAdmin> filteredData = [];
//   List<HouseAllowanceAdmin> data = List.empty();
//     late double sumApprove = 0;
//   late double sumRequest = 0;
//   late double sumReject = 0;

//   final searchController = TextEditingController();

//   @override
//   void initState() {

//     // filteredData = data;
//     super.initState();
//     _getHouseAllowanceAdmin(context);
    

//   }

//   @override
//   void dispose() {
//     searchController.dispose();
//     super.dispose();
//   }

//   void _onSearchTextChanged(String text) {
//     setState(() {
//       filteredData = text.isEmpty
//           ? data
//           : data
//               .where((item) =>
//                   item.empcode.toLowerCase().contains(text.toLowerCase()) ||
//                   item.name.toLowerCase().contains(text.toLowerCase()) ||
//                   item.department.toLowerCase().contains(text.toLowerCase()) ||
//                   item.divisionment.toLowerCase().contains(text.toLowerCase()) ||
//                   item.savedate.toLowerCase().contains(text.toLowerCase()) ||
//                   item.payamount.toLowerCase().contains(text.toLowerCase()) ||
//                   item.moneyhouse.toLowerCase().contains(text.toLowerCase()) ||                                    
//                   item.status.toLowerCase().contains(text.toLowerCase())
//                   )
//               .toList();
              
//               print(data);
//     });
//   }


//   HouseAllowanceAdminController controller =
//       HouseAllowanceAdminController(FirebaseServicesAdmin());

// void   _getHouseAllowanceAdmin(BuildContext context) async {
//             var _data = await controller.fetchHouseAllowanceAdmin();
//             if(_data.length > 0){
//                         setState(() {
//               data = _data;
//               filteredData = _data;
//               // print(filteredData);
//             });
//             context.read<HouseAllowanceAdminProviders>().HouseAllowanceAdminList = _data;
//             }
//             var _data_app   =   _data ;
//             var _data_req   =   _data ;
//             var _data_rej   =   _data ;
//     // get data  HouseAllowanceDashboard
//     //var newHouseAllowanceDashboard = await HouseAllowancecontroller.fetchHouseAllowance();
//         if(_data_app.length > 0){
//     var cApproveHouseAllowanceAdmin = _data_app.where((x) => x.status == "อนุมัติ");
//     final HouseAllowance = [];
//     for (var doc in cApproveHouseAllowanceAdmin) {
//       double a = double.parse(doc.payamount);
//       HouseAllowance.add(a);
//     }
//     var _sumApprove = HouseAllowance.reduce((a, b) => a + b);
//                         setState(() {
//               sumApprove = _sumApprove;
//               // print(filteredData);
//             });
    
//         }
        
//         if(_data_req.length > 0){
//     var cRequestHouseAllowanceAdmin = _data_req.where((x) => x.status == "ร้องขอ");
//     final HouseAllowanceRequest = [];
//     for (var doc in cRequestHouseAllowanceAdmin) {
//       double b = double.parse(doc.moneyhouse);
//       HouseAllowanceRequest.add(b);
//     }
//     var _sumRequest = HouseAllowanceRequest.reduce((a, b) => a + b);
//                     setState(() {
//               sumRequest = _sumRequest;
//               // print(filteredData);
//             });
//         }
//         if(_data_rej.length > 0){
//         var cRejectHouseAllowanceAdmin = _data_rej.where((x) => x.status == "ปฏิเสธ");
//     final HouseAllowanceReject = [];
//     for (var doc in cRejectHouseAllowanceAdmin) {
//       double c = double.parse(doc.moneyhouse);
//       HouseAllowanceReject.add(c);
//     }
//     var _sumReject = HouseAllowanceReject.reduce((a, b) => a + b);
//                 setState(() {
//               sumReject = _sumReject;
//               // print(filteredData);
//             });
//         }
//             setState(() {
//               data = _data;
//               print(_data);
//               filteredData = _data;
//               // print(filteredData);
//             });
            
//           // context.read<HouseAllowanceAdminProviders>().HouseAllowanceAdminList = _data;

//       }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//             appBar: AppBar(title: 
//              Text('รายงาน',
//             // Text(widget.Status.toString(),
//             style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: iOrangeColor,),),backgroundColor: iBlueColor,),
//     body: SingleChildScrollView(
//       child: Column(children: [
//                    Padding(
//            padding: const EdgeInsets.all(3.0),
//            child: Row(
//   crossAxisAlignment: CrossAxisAlignment.center,
//   children: [
//     Expanded(
//       child: Padding(
//         padding: const EdgeInsets.all(3.0),
//         child: Card(
//               elevation: 0,
//               color: iWhiteColor,
//         shape: RoundedRectangleBorder(
//             side: BorderSide(
//               color: iBlueColor,
//             ),
//             borderRadius: const BorderRadius.all(Radius.circular(12)),
//         ),
//             child: Column(
//   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   children: [
//     Padding(
//       padding: const EdgeInsets.all(3.0),
//       child: Text(
//                     "จำนวนเงินที่อนุมัตินำจ่าย",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: iBlueColor,
//                     ),
//                   ),
//     ),

// Padding(
//       padding: EdgeInsets.all(3.0),
//       child: Text('จำนวนเงิน : ' + sumApprove.toString() +' บาท'),                      
                    
//     ),
//   ],
// ),
//         ),
//       ),
//     ),
// //--
//       Expanded(
//       child: Padding(
//         padding: const EdgeInsets.all(3.0),
//         child: Card(
//               elevation: 0,
//               color: iWhiteColor,
//         shape: RoundedRectangleBorder(
//             side: BorderSide(
//               color: iBlueColor,
//             ),
//             borderRadius: const BorderRadius.all(Radius.circular(12)),
//         ),
//             child: Column(
//   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   children: [
//     Padding(
//       padding: const EdgeInsets.all(3.0),
//       child: Text(
//                     "จำนวนเงินที่รออนุมัตินำจ่าย",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: iBlueColor,
//                     ),
//                   ),
//     ),
// Padding(
//       padding: EdgeInsets.all(3.0),
//             child: Text('จำนวนเงิน : ' + sumRequest.toString() +' บาท'),                     
                    
//     ),



//   ],
// ),
//         ),
//       ),
//     ),

//     //---

//       Expanded(
//       child: Padding(
//         padding: const EdgeInsets.all(3.0),
//         child: Card(
//               elevation: 0,
//               color: iWhiteColor,
//         shape: RoundedRectangleBorder(
//             side: BorderSide(
//               color: iBlueColor,
//             ),
//             borderRadius: const BorderRadius.all(Radius.circular(12)),
//         ),
//             child: Column(
//   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   children: [
//     Padding(
//       padding: const EdgeInsets.all(3.0),
//       child: Text(
//                     "จำนวนเงินที่ปฏิเสธอนุมัตินำจ่าย",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: iBlueColor,
//                     ),
//                   ),
//     ),
// Padding(
//       padding: EdgeInsets.all(3.0),
//             child: Text('จำนวนเงิน : ' + sumReject.toString() +' บาท'),                     
                    
//     ),



//   ],
// ),
//         ),
//       ),
//     ),
//     //--


//   ],
// ),
//          ),   
//         //
//       Padding(
//         padding: const EdgeInsets.all(3.0),
//         child: TextField(
//           controller: searchController,
//           decoration: const InputDecoration(
//             hintText: 'Search...',
//             border: OutlineInputBorder(),
//           ),
//           onChanged: _onSearchTextChanged,
//         ),
//       ),
//       SizedBox(
//         width: double.infinity,
//         child :SingleChildScrollView(
//                 scrollDirection : Axis.horizontal,       
//         child: DataTable(
//           columns: const <DataColumn>[
//             DataColumn(
//               label: Text('รหัสพนักงาน'),
//             ),
//             DataColumn(
//               label: Text('ชื่อ-สกุลของพนักงาน'),
//               numeric: true,
//             ),
//             DataColumn(
//               label: Text('ฝ่ายงาน'),
//             ),
//                         DataColumn(
//               label: Text('ส่วนงาน'),
//             ),
//             DataColumn(
//               label: Text('วันบันทึกรายการ'),
//               numeric: true,
//             ),
//             DataColumn(
//               label: Text('payamount'),
//             ),
//                         DataColumn(
//               label: Text('moneyhouse'),
//             ),
            
//             DataColumn(
//               label: Text('สถานะ'),
//             ),

//           ],
//           rows: List.generate(filteredData.length, (index) {
//             if(filteredData.isNotEmpty){
//                HouseAllowanceAdmin item = filteredData[index];
//             return DataRow(
//               cells: [
//                 DataCell(Text(item.empcode.toString())),
//                 DataCell(Text(item.name.toString())),
//                 DataCell(Text(item.department.toString())),
//                 DataCell(Text(item.divisionment.toString())),
//                 DataCell(Text(item.savedate.toString())),
//                 DataCell(Text(item.payamount.toString())),
//                 DataCell(Text(item.moneyhouse.toString())),
//                 DataCell(Text(item.status.toString())),                                                             
//               ],
//               );
//             }
//             else{
           
//             return DataRow(
//               cells: [
//                 DataCell(Text('ไม่มีข้อมูล')),
//                 DataCell(Text('ไม่มีข้อมูล')),
//                 DataCell(Text('ไม่มีข้อมูล')),
//                 DataCell(Text('ไม่มีข้อมูล')),
//                 DataCell(Text('ไม่มีข้อมูล')),
//                 DataCell(Text('ไม่มีข้อมูล')),
//                 DataCell(Text('ไม่มีข้อมูล')),
//                 DataCell(Text('ไม่มีข้อมูล')),                                                        
//               ],
//             );
//             }
//           }),
//         ),
//         ),
//       ),
//     ]),
//     ),
//     );
//   }
// }


// // import 'package:flutter/material.dart';
// // import 'package:ghb_banefits_admin/All_Controllers_Admin/House_controllers.dart';
// // import 'package:ghb_banefits_admin/All_Controllers_Admin/child_allowance_controllers.dart';
// // import 'package:ghb_banefits_admin/All_Models_Admin/child_allowane_model.dart';
// // import 'package:ghb_banefits_admin/All_Models_Admin/house_model.dart';
// // import 'package:ghb_banefits_admin/All_Providers_Admin/provider_child_allowance.dart';
// // import 'package:ghb_banefits_admin/All_Providers_Admin/provider_house.dart';
// // import 'package:ghb_banefits_admin/All_Services_Admin/servics.dart';
// // import 'package:ghb_banefits_admin/color.dart';
// // import 'package:ghb_banefits_admin/main_home_admin_page.dart';
// // import 'package:provider/provider.dart';

// // class ReportHouseAllowancePage extends StatefulWidget {
// //   const ReportHouseAllowancePage({Key? key}) : super(key: key);

// //   @override
// //   State<ReportHouseAllowancePage> createState() => _ReportHouseAllowancePageState();
// // }

// // class _ReportHouseAllowancePageState extends State<ReportHouseAllowancePage> {

// //   List<HouseAllowanceAdmin> filteredData = [];
// //   List<HouseAllowanceAdmin> data = List.empty();
// //  late double sumApprove = 0;
// //   late double sumRequest = 0;
// //   late double sumReject = 0;
// //   final searchController = TextEditingController();

// //   @override
// //   void initState() {

// //     // filteredData = data;
// //     super.initState();
// //     _getHouseAllowanceAdmin(context);

// //   }

// //   @override
// //   void dispose() {
// //     searchController.dispose();
// //     super.dispose();
// //   }

// //   void _onSearchTextChanged(String text) {
// //     setState(() {
// //       filteredData = text.isEmpty
// //           ? data
// //           : data
// //               .where((item) =>
// //                   item.empcode.toLowerCase().contains(text.toLowerCase()) ||
// //                   item.name.toLowerCase().contains(text.toLowerCase()) ||
// //                   item.department.toLowerCase().contains(text.toLowerCase()) ||
// //                   item.divisionment.toLowerCase().contains(text.toLowerCase()) ||
// //                   item.savedate.toLowerCase().contains(text.toLowerCase()) ||
// //                   item.payamount.toLowerCase().contains(text.toLowerCase()) ||
// //                   item.moneyhouse.toLowerCase().contains(text.toLowerCase()) ||                                    
// //                   item.status.toLowerCase().contains(text.toLowerCase())
// //                   )
// //               .toList();
              
// //               print(data);
// //     });
// //   }

// //   HouseAllowanceAdminController controller =
// //       HouseAllowanceAdminController(FirebaseServicesAdmin());

// //   void   _getHouseAllowanceAdmin(BuildContext context) async {
// //             var _data = await controller.fetchHouseAllowanceAdmin();
// //             if(_data.length > 0){
// //                         setState(() {
// //               data = _data;
// //               filteredData = _data;
// //               // print(filteredData);
// //             });
// //             context.read<HouseAllowanceAdminProviders>().HouseAllowanceAdminList = _data;
// //             }
// //             var _data_app   =   _data ;
// //             var _data_req   =   _data ;
// //             var _data_rej   =   _data ;
// //     // get data  HouseAllowanceDashboard
// //     //var newHouseAllowanceDashboard = await HouseAllowancecontroller.fetchHouseAllowance();
// //         if(_data_app.length > 0){
// //     var cApproveHouseAllowanceAdmin = _data_app.where((x) => x.status == "อนุมัติ");
// //     final HouseAllowance = [];
// //     for (var doc in cApproveHouseAllowanceAdmin) {
// //       double a = double.parse(doc.payamount);
// //       HouseAllowance.add(a);
// //     }
// //     var _sumApprove = HouseAllowance.reduce((a, b) => a + b);
// //                         setState(() {
// //               sumApprove = _sumApprove;
// //               // print(filteredData);
// //             });
    
// //         }
        
// //         if(_data_req.length > 0){
// //     var cRequestHouseAllowanceAdmin = _data_req.where((x) => x.status == "ร้องขอ");
// //     final HouseAllowanceRequest = [];
// //     for (var doc in cRequestHouseAllowanceAdmin) {
// //       double b = double.parse(doc.moneyhouse);
// //       HouseAllowanceRequest.add(b);
// //     }
// //     var _sumRequest = HouseAllowanceRequest.reduce((a, b) => a + b);
// //                     setState(() {
// //               sumRequest = _sumRequest;
// //                print(sumRequest);
// //             });
// //         }
// //         if(_data_rej.length > 0){
// //         var cRejectHouseAllowanceAdmin = _data_rej.where((x) => x.status == "ปฏิเสธ");
// //     final HouseAllowanceReject = [];
// //     for (var doc in cRejectHouseAllowanceAdmin) {
// //       double c = double.parse(doc.moneyhouse);
// //       HouseAllowanceReject.add(c);
// //     }
// //     var _sumReject = HouseAllowanceReject.reduce((a, b) => a + b);
// //                 setState(() {
// //               sumReject = _sumReject;
// //               // print(filteredData);
// //             });
// //         }
// //             setState(() {
// //               data = _data;
// //               print(_data);
// //               filteredData = _data;
// //               // print(filteredData);
// //             });
            
// //           // context.read<HouseAllowanceAdminProviders>().HouseAllowanceAdminList = _data;

// //       }
// //   @override
// //   Widget build(BuildContext context) {
// //         final double width = MediaQuery.of(context).size.width;
// //     return Scaffold(
// //             appBar: AppBar(title: 
// //              Text('รายงานค่าเช่าบ้านของพนักงาน',
// //             // Text(widget.Status.toString(),
// //             style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: iOrangeColor,),),backgroundColor: iBlueColor,),
// //     body: SingleChildScrollView(
// //       child: Column(children: [
// //                  Padding(
// //            padding: const EdgeInsets.all(3.0),
// //            child: Row(
// //   crossAxisAlignment: CrossAxisAlignment.center,
// //   children: [
// //     Expanded(
// //       child: Padding(
// //         padding: const EdgeInsets.all(3.0),
// //         child: Card(
// //               elevation: 0,
// //               color: iWhiteColor,
// //         shape: RoundedRectangleBorder(
// //             side: BorderSide(
// //               color: iBlueColor,
// //             ),
// //             borderRadius: const BorderRadius.all(Radius.circular(12)),
// //         ),
// //             child: Column(
// //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //   children: [
// //     Padding(
// //       padding: const EdgeInsets.all(3.0),
// //       child: Text(
// //                     "จำนวนเงินที่อนุมัตินำจ่าย",
// //                     style: TextStyle(
// //                       fontSize: 16,
// //                       fontWeight: FontWeight.bold,
// //                       color: iBlueColor,
// //                     ),
// //                   ),
// //     ),

// // Padding(
// //       padding: EdgeInsets.all(3.0),
// //       child: Text('จำนวนเงิน : ' + sumApprove.toString() +' บาท'),                      
                    
// //     ),
// //   ],
// // ),
// //         ),
// //       ),
// //     ),
// // //--
// //       Expanded(
// //       child: Padding(
// //         padding: const EdgeInsets.all(3.0),
// //         child: Card(
// //               elevation: 0,
// //               color: iWhiteColor,
// //         shape: RoundedRectangleBorder(
// //             side: BorderSide(
// //               color: iBlueColor,
// //             ),
// //             borderRadius: const BorderRadius.all(Radius.circular(12)),
// //         ),
// //             child: Column(
// //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //   children: [
// //     Padding(
// //       padding: const EdgeInsets.all(3.0),
// //       child: Text(
// //                     "จำนวนเงินที่รออนุมัตินำจ่าย",
// //                     style: TextStyle(
// //                       fontSize: 16,
// //                       fontWeight: FontWeight.bold,
// //                       color: iBlueColor,
// //                     ),
// //                   ),
// //     ),
// // Padding(
// //       padding: EdgeInsets.all(3.0),
// //             child: Text('จำนวนเงิน : ' + sumRequest.toString() +' บาท'),                     
                    
// //     ),



// //   ],
// // ),
// //         ),
// //       ),
// //     ),

// //     //---

// //       Expanded(
// //       child: Padding(
// //         padding: const EdgeInsets.all(3.0),
// //         child: Card(
// //               elevation: 0,
// //               color: iWhiteColor,
// //         shape: RoundedRectangleBorder(
// //             side: BorderSide(
// //               color: iBlueColor,
// //             ),
// //             borderRadius: const BorderRadius.all(Radius.circular(12)),
// //         ),
// //             child: Column(
// //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //   children: [
// //     Padding(
// //       padding: const EdgeInsets.all(3.0),
// //       child: Text(
// //                     "จำนวนเงินที่ปฏิเสธอนุมัตินำจ่าย",
// //                     style: TextStyle(
// //                       fontSize: 16,
// //                       fontWeight: FontWeight.bold,
// //                       color: iBlueColor,
// //                     ),
// //                   ),
// //     ),
// // Padding(
// //       padding: EdgeInsets.all(3.0),
// //             child: Text('จำนวนเงิน : ' + sumReject.toString() +' บาท'),                     
                    
// //     ),



// //   ],
// // ),
// //         ),
// //       ),
// //     ),
// //     //--


// //   ],
// // ),
// //          ),   
      
// //       ///
// //       Padding(
// //         padding: const EdgeInsets.all(3.0),
// //         child: TextField(
// //           controller: searchController,
// //           decoration: const InputDecoration(
// //             hintText: 'Search...',
// //             border: OutlineInputBorder(),
// //           ),
// //           onChanged: _onSearchTextChanged,
// //         ),
// //       ),
// //       SizedBox(
// //         width: width,
// //         child :SingleChildScrollView(
// //                 scrollDirection : Axis.horizontal,       
// //         child: DataTable(
// //           columns: const <DataColumn>[
// //             DataColumn(
// //               label: Text('รหัสพนักงาน'),
// //             ),
// //             DataColumn(
// //               label: Text('ชื่อ-สกุลของพนักงาน'),
// //               numeric: true,
// //             ),
// //             DataColumn(
// //               label: Text('ฝ่ายงาน'),
// //             ),
// //                         DataColumn(
// //               label: Text('ส่วนงาน'),
// //             ),
// //             DataColumn(
// //               label: Text('วันบันทึกรายการ'),
// //               numeric: true,
// //             ),
// //             DataColumn(
// //               label: Text('ชื่อ-สกุลของบุตร'),
// //             ),
// //                         DataColumn(
// //               label: Text('ชื่อ-สกุลของบุตรคู่สมรส'),
// //             ),
            
// //             DataColumn(
// //               label: Text('สถานะ'),
// //             ),

// //           ],
// //           rows: List.generate(filteredData.length, (index) {
// //             if(filteredData.isNotEmpty){
// //                HouseAllowanceAdmin item = filteredData[index];
// //             return DataRow(
// //               cells: [
// //                 DataCell(Text(item.empcode.toString())),
// //                 DataCell(Text(item.name.toString())),
// //                 DataCell(Text(item.department.toString())),
// //                 DataCell(Text(item.divisionment.toString())),
// //                 DataCell(Text(item.savedate.toString())),
// //                 DataCell(Text(item.payamount.toString())),
// //                 DataCell(Text(item.moneyhouse.toString())),
// //                 DataCell(Text(item.status.toString())),                                                             
// //               ],
// //               );
// //             }
// //             else{
           
// //             return DataRow(
// //               cells: [
// //                 DataCell(Text('ไม่มีข้อมูล')),
// //                 DataCell(Text('ไม่มีข้อมูล')),
// //                 DataCell(Text('ไม่มีข้อมูล')),
// //                 DataCell(Text('ไม่มีข้อมูล')),
// //                 DataCell(Text('ไม่มีข้อมูล')),
// //                 DataCell(Text('ไม่มีข้อมูล')),
// //                 DataCell(Text('ไม่มีข้อมูล')),
// //                 DataCell(Text('ไม่มีข้อมูล')),                                                        
// //               ],
// //             );
// //             }
// //           }),
// //         ),
// //         ),
// //       ),
// //     ]),
// //     ),
// //     );
// //   }
// // }


// //   //  List<ChildAllowanceAdmin> allowances = List.empty();
// //   //   List<ChildAllowanceAdmin> _Datalist = List.empty();
// //   // bool isloading = false;
// //   // late int count ;

// //   // ChildAllowanceAdminController controller =
// //   //     ChildAllowanceAdminController(FirebaseServicesAdmin());
      

// //   //     void initState() {
// //   //       super.initState();
// //   //       _getChildAllowanceAdmin(context);
// //   //     }

// //   //  void   _getChildAllowanceAdmin(BuildContext context) async {
// //   //           var newAllowance = await controller.fetchChildAllowanceAdmin();
// //   //         context.read<ChildAllowanceAdminProviders>().ChildAllowanceAdminListwhere = newAllowance;

// //   //     }
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //             appBar: AppBar(title: 
// // //              Text('รายงาน',
// // //             // Text(widget.Status.toString(),
// // //             style: TextStyle(
// // //                             fontSize: 16,
// // //                             fontWeight: FontWeight.bold,
// // //                             color: iOrangeColor,
// // //                           ),),
// // //       backgroundColor: iBlueColor,
// // //        actions: <Widget>[
                    
// // //           IconButton(
// // //             icon: const Icon(Icons.home),
// // //             // tooltip: 'Show Snackbar',
// // //             onPressed: () {

// // //               Navigator.of(context).push(
// // //                   MaterialPageRoute(builder: (context) => MainHomeAdminPage()));
// // //             },
// // //           ),
// // //         ],),


// // //          body:
// // //         SingleChildScrollView(
// // //           scrollDirection: Axis.horizontal,
// // //            child: Consumer<ChildAllowanceAdminProviders>(
// // //           builder: (context,ChildAllowanceAdminProviders data,child){
// // //            return DataTable(
// // //             // Datatable widget that have the property columns and rows.
// // //             columns: const [
// // //               // Set the name of the column
// // //               DataColumn(label: Text('ID'),),
// // //               DataColumn(label: Text('Name'),),
// // //               DataColumn(label: Text('LastName'),),
// // //               DataColumn(label: Text('Age'),),
// // //             ],

// // //             rows: <DataRow>[
// // //   for (int i = 0; i < data.ChildAllowanceAdminList.length; i += 3)
// // //       DataRow(cells: [
// // //                 DataCell(Text( data.ChildAllowanceAdminList[''])),
// // //                 DataCell(Text("Alex")),
// // //                 DataCell(Text("Anderson")),
// // //                 DataCell(Text("16")),
// // //               ]),
// // // ],
// // //             // rows:const [
// // //             //   // Set the values to the columns 
// // //             //   DataRow(cells: [
// // //             //     DataCell(Text("1")),
// // //             //     DataCell(Text("Alex")),
// // //             //     DataCell(Text("Anderson")),
// // //             //     DataCell(Text("16")),
// // //             //   ]),
// // //             //   DataRow(cells: [
// // //             //     DataCell(Text("2")),
// // //             //     DataCell(Text("John")),
// // //             //     DataCell(Text("Anderson")),
// // //             //     DataCell(Text("24")),
// // //             //   ]),
// // //             // ]
// // //           ),
        
// // //          },
// // //         ),
// // //         ),


// // //     );
// // //   }
// // // }

// // // rows: <DataRow>[
// // //   for (int i = 0; i < displayedDataCell.length; i += 3)
// // //     DataRow(cells: [displayedDataCell[i], displayedDataCell[i + 1], displayedDataCell[i + 2]])
// // // ],