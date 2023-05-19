import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ghb_banefits_admin/All_Controllers_Admin/child_allowance_controllers.dart';
import 'package:ghb_banefits_admin/All_Controllers_Admin/cremation_service_controllers.dart';
import 'package:ghb_banefits_admin/All_Models_Admin/child_allowane_model.dart';
import 'package:ghb_banefits_admin/All_Models_Admin/cremation_service_model.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_child_allowance.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_cremation.dart';
import 'package:ghb_banefits_admin/All_Services_Admin/servics.dart';
import 'package:ghb_banefits_admin/color.dart';
import 'package:ghb_banefits_admin/main_home_admin_page.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReportCremationServicePage extends StatefulWidget {
  const ReportCremationServicePage({Key? key}) : super(key: key);

  @override
  State<ReportCremationServicePage> createState() => _ReportCremationServicePageState();
}

class _ReportCremationServicePageState extends State<ReportCremationServicePage> {

// List<dynamic> data = [];
  List<CremationServiceAdmin> filteredData = [];
  List<CremationServiceAdmin> data = List.empty();
      List<CategoriesCremationService> filteredDataca = [];
    List<CategoriesCremationService> CategoriesCremations = List.empty();
    late int sumApprove = 0;
  late int sumRequest = 0;
  late int sumReject = 0;

  final searchController = TextEditingController();

  @override
  void initState() {

    // filteredData = data;
    super.initState();
    _getCremationServiceAdmin(context);

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
                  item.empcode.toLowerCase().contains(text.toLowerCase()) ||
                  item.name.toLowerCase().contains(text.toLowerCase()) ||
                  item.department.toLowerCase().contains(text.toLowerCase()) ||
                  item.divisionment.toLowerCase().contains(text.toLowerCase()) ||
                  item.savedate.toLowerCase().contains(text.toLowerCase()) ||
                  item.namepartner.toLowerCase().contains(text.toLowerCase()) ||                                    
                  item.status.toLowerCase().contains(text.toLowerCase())
                  )
              .toList();
              
              print(data);
    });
  }


  CremationServiceAdminController controller =
      CremationServiceAdminController(FirebaseServicesAdmin());

   void   _getCremationServiceAdmin(BuildContext context) async {
            var _data = await controller.fetchCremationServiceAdmin();
            if(_data.length > 0){
                        setState(() {
              data = _data;
              filteredData = _data;
              // print(filteredData);
            });
            context.read<CremationServiceAdminProviders>().CremationServiceAdminList = _data;
            }
            var _data_app   =   _data ;
            var _data_req   =   _data ;
            var _data_rej   =   _data ;
    // get data  CremationServiceDashboard
    //var newCremationServiceDashboard = await CremationServicecontroller.fetchCremationService();
        if(_data_app.length > 0){
    var cApproveCremationServiceAdmin = _data_app.where((x) => x.status == "อนุมัติ");
        int _sumApprove = cApproveCremationServiceAdmin.length;
                        setState(() {
              sumApprove = _sumApprove;
               print(sumApprove);
            });
    
        }
        
        if(_data_req.length > 0){
    var cRequestCremationServiceAdmin = _data_req.where((x) => x.status == "ร้องขอ");
    int _sumRequest = cRequestCremationServiceAdmin.length;
                    setState(() {
              sumRequest = _sumRequest;
               print(sumRequest);
            });
        }
        if(_data_rej.length > 0){
        var cRejectCremationServiceAdmin = _data_rej.where((x) => x.status == "ปฏิเสธ");
    int _sumReject = cRejectCremationServiceAdmin.length;
                setState(() {
              sumReject = _sumReject;
               print(sumReject);
            });
        }


    List<CategoriesCremationService> ad = [];
    _data.forEach((element) {
      ad.add(CategoriesCremationService(element.department, 0, 0, 0));
    });
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

    List<CategoriesCremationService> ddd =
        CategoriesCremationService.parseApplList(jsonEncode(result));

    ddd.forEach((a) {
      _data.forEach((b) {
        if (a.name == b.department) {
          if (b.status == "อนุมัติ") {
            a.amountApprove += b.id.substring(1, 2).length as int;
          } else if (b.status == "ร้องขอ") {
            a.amountRequest += b.id.substring(1, 2).length as int;
          } else {
            a.amountReject += b.id.substring(1, 2).length as int;
          }
        }
      });
    });
    print(jsonEncode(ddd));

    setState(() {
      CategoriesCremations = ddd;
    });
            // setState(() {
            //   data = _data;
            //   print(_data);
            //   filteredData = _data;
            //   // print(filteredData);
            // });
            
          // context.read<CremationServiceAdminProviders>().CremationServiceAdminList = _data;

      }
  @override
  Widget build(BuildContext context) {
       final double width = MediaQuery.of(context).size.width;
    return Scaffold(
            appBar: AppBar(title: 
             Text('รายงานสมัครฌาปนกิจสงเคราะห์',
            // Text(widget.Status.toString(),
            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: iWhiteColor, fontFamily: 'Sarabun', ),),backgroundColor: iOrangeColor,),
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
                              "รายงานสมัครฌาปนกิจสงเคราะห์แยกตามฝ่ายงาน",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,fontFamily: 'Sarabun', 
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
                              "จำนวนรายการที่อนุมัติทั้งหมด",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,fontFamily: 'Sarabun', 
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
                                fontWeight: FontWeight.bold,fontFamily: 'Sarabun', 
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
                              "จำนวนรายการที่รออนุมัติทั้งหมด",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,fontFamily: 'Sarabun', 
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
                                fontWeight: FontWeight.bold,fontFamily: 'Sarabun', 
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
                              "จำนวนรายการที่ปฏิเสธทั้งหมด",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,fontFamily: 'Sarabun', 
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
                                fontWeight: FontWeight.bold,fontFamily: 'Sarabun', 
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
                      label: Center(child: Flexible(child: Text('ฝ่ายงาน',style: TextStyle(fontFamily: 'Sarabun',),))),
                    ),
                    DataColumn(
                      label: Center(child: Flexible(child: Text('อนุมัติ',style: TextStyle(fontFamily: 'Sarabun',),))),
                    ),
                    DataColumn(
                      label: Center(child: Flexible(child: Text('ร้องขอ',style: TextStyle(fontFamily: 'Sarabun',),))),
                    ),
                    DataColumn(
                      label:
                          Center(child: Flexible(child: Text('ปฏิเสธ',style: TextStyle(fontFamily: 'Sarabun',),))),
                    ),
                  ],
                  rows:
                      List.generate(CategoriesCremations.length, (index) {
                    if (CategoriesCremations.isNotEmpty) {
                      CategoriesCremationService item =
                          CategoriesCremations[index];
                      NumberFormat myFormat =
                          NumberFormat.decimalPattern('en_us');
                      return DataRow(
                        cells: [
                          DataCell(Flexible(child: Text(item.name.toString(),style: TextStyle(fontFamily: 'Sarabun',),))),
                          DataCell(Flexible(
                              child:
                                  Center(child: Text(myFormat.format(item.amountApprove),style: TextStyle(fontFamily: 'Sarabun',),)))),
                          DataCell(Flexible(
                              child:
                                  Center(child: Text(myFormat.format(item.amountRequest),style: TextStyle(fontFamily: 'Sarabun',),)))),
                          DataCell(Flexible(
                              child:
                                  Center(child: Text(myFormat.format(item.amountRequest),style: TextStyle(fontFamily: 'Sarabun',),)))),
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

class CategoriesCremationService {
  final String name;
  late int amountApprove;
  late int amountRequest;
  late int amountReject;
  CategoriesCremationService(
      this.name, this.amountApprove, this.amountRequest, this.amountReject);

  factory CategoriesCremationService.fromJson(Map<String, dynamic> json) {
    return CategoriesCremationService(
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

  static List<CategoriesCremationService> parseApplList(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<CategoriesCremationService> listData = parsed
        .map<CategoriesCremationService>((json) => CategoriesCremationService.fromJson(json))
        .toList();
    return listData;
  }
}
  //  List<ChildAllowanceAdmin> allowances = List.empty();
  //   List<ChildAllowanceAdmin> _Datalist = List.empty();
  // bool isloading = false;
  // late int count ;

  // ChildAllowanceAdminController controller =
  //     ChildAllowanceAdminController(FirebaseServicesAdmin());
      

  //     void initState() {
  //       super.initState();
  //       _getChildAllowanceAdmin(context);
  //     }

  //  void   _getChildAllowanceAdmin(BuildContext context) async {
  //           var newAllowance = await controller.fetchChildAllowanceAdmin();
  //         context.read<ChildAllowanceAdminProviders>().ChildAllowanceAdminListwhere = newAllowance;

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
//            child: Consumer<ChildAllowanceAdminProviders>(
//           builder: (context,ChildAllowanceAdminProviders data,child){
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
//   for (int i = 0; i < data.ChildAllowanceAdminList.length; i += 3)
//       DataRow(cells: [
//                 DataCell(Text( data.ChildAllowanceAdminList[''])),
//                 DataCell(Text("Alex")),
//                 DataCell(Text("Anderson")),
//                 DataCell(Text("18")),
//               ]),
// ],
//             // rows:const [
//             //   // Set the values to the columns 
//             //   DataRow(cells: [
//             //     DataCell(Text("1")),
//             //     DataCell(Text("Alex")),
//             //     DataCell(Text("Anderson")),
//             //     DataCell(Text("18")),
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