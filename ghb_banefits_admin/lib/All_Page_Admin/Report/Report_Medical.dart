import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:ghb_banefits_admin/All_Controllers_Admin/Medical_Controller.dart';
import 'package:ghb_banefits_admin/All_Controllers_Admin/child_allowance_controllers.dart';
import 'package:ghb_banefits_admin/All_Models_Admin/Categories_All_Amount_model.dart';
import 'package:ghb_banefits_admin/All_Models_Admin/child_allowane_model.dart';
import 'package:ghb_banefits_admin/All_Models_Admin/medical_model.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Child_Allowances/list_child_allowance.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Education/list_education_page.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Medical/list_medical_page.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_child_allowance.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_education.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_medical.dart';
import 'package:ghb_banefits_admin/All_Services_Admin/servics.dart';
import 'package:ghb_banefits_admin/color.dart';
import 'package:ghb_banefits_admin/main_home_admin_page.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReportMedicalPage extends StatefulWidget {
  const ReportMedicalPage({Key? key}) : super(key: key);

  @override
  State<ReportMedicalPage> createState() => _ReportMedicalPageState();
}

class _ReportMedicalPageState extends State<ReportMedicalPage> {
  List<MedicalAdmin> filteredData = [];
  List<MedicalAdmin> data = List.empty();
  List<CategoriesMedical> filteredDataca = [];
  List<CategoriesMedical> CategoriesMedicals = List.empty();
  late double sumApprove = 0;
  late double sumRequest = 0;
  late double sumReject = 0;

  late int amount = 0;
  late String name = "";
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getMedicalAdmin(context);
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
                  item.divisionment
                      .toLowerCase()
                      .contains(text.toLowerCase()) ||
                  item.savedate.toLowerCase().contains(text.toLowerCase()) ||
                  item.hospitalname
                      .toLowerCase()
                      .contains(text.toLowerCase()) ||
                  item.namedisease.toLowerCase().contains(text.toLowerCase()) ||
                  item.idreceiptnumber
                      .toLowerCase()
                      .contains(text.toLowerCase()) ||
                  item.claimstartdate
                      .toLowerCase()
                      .contains(text.toLowerCase()) ||
                  item.claimenddate
                      .toLowerCase()
                      .contains(text.toLowerCase()) ||
                  item.receiptamount
                      .toLowerCase()
                      .contains(text.toLowerCase()) ||
                  item.payamount.toLowerCase().contains(text.toLowerCase()) ||
                  item.status.toLowerCase().contains(text.toLowerCase()))
              .toList();

      print(data);
    });
  }

  List<MedicalAdmin> allowances = List.empty();

  MedicalAdminController controller =
      MedicalAdminController(FirebaseServicesAdmin());

  void _getMedicalAdmin(BuildContext context) async {
    var _dataMedical = await controller.fetchMedicalAdmin();
            print(_dataMedical.length);
            if(_dataMedical.length > 0){
                        setState(() {
              data = _dataMedical;
              filteredData = _dataMedical;
              // print(filteredData);
            });
            context.read<MedicalAdminProviders>().MedicalAdminList = _dataMedical;
            }
            var _dataMedical_app   =   _dataMedical ;
            var _dataMedical_req   =   _dataMedical ;
            var _dataMedical_rej   =   _dataMedical ;
    // get data  EducationDashboard
    //var newEducationDashboard = await educationcontroller.fetchEducation();
_dataMedical.forEach((b) {

          if (b.status == "อนุมัติ") {
            sumApprove += int.parse(b.payamount);
          } else if (b.status == "ร้องขอ") {
            sumRequest += int.parse(b.receiptamount);
          } else if (b.status == "ปฏิเสธ") {
            sumReject += int.parse(b.receiptamount);
          }

      });

setState(() {
  
});
    
    // if (_dataMedical.length > 0) {
    //   setState(() {
    //     data = _dataMedical;
    //     filteredData = _dataMedical;
    //     // print(filteredData);
    //   });
    //   context.read<MedicalAdminProviders>().MedicalAdminList = _dataMedical;
    // }
    // var _dataMedical_app = _dataMedical;
    // var _dataMedical_req = _dataMedical;
    // var _dataMedical_rej = _dataMedical;
    // // get data  MedicalDashboard
    // //var newMedicalDashboard = await medicalcontroller.fetchMedical();
    // if (_dataMedical_app.length > 0) {
    //   var cApproveMedicalAdmin = _dataMedical_app.where((x) => x.status == "อนุมัติ");
    //   final medical = [];
    //   for (var doc in cApproveMedicalAdmin) {
    //     double a = double.parse(doc.payamount);
    //     medical.add(a);
    //   }
    //   var _sumApprove = medical.reduce((a, b) => a + b);
    //   setState(() {
    //     sumApprove = _sumApprove;
    //     // print(filteredData);
    //   });
    // }

    // if (_dataMedical_req.length > 0) {
    //   var cRequestMedicalAdmin = _dataMedical_req.where((x) => x.status == "ร้องขอ");
    //   final medicalRequest = [];
    //   for (var doc in cRequestMedicalAdmin) {
    //     double b = double.parse(doc.receiptamount);
    //     medicalRequest.add(b);
    //   }
    //   var _sumRequest = medicalRequest.reduce((a, b) => a + b);
    //   setState(() {
    //     sumRequest = _sumRequest;
    //     // print(filteredData);
    //   });
    // }
    // if (_dataMedical_rej.length > 0) {
    //   var cRejectMedicalAdmin = _dataMedical_rej.where((x) => x.status == "ปฏิเสธ");
    //   final medicalReject = [];
    //   for (var doc in cRejectMedicalAdmin) {
    //     double c = double.parse(doc.receiptamount);
    //     medicalReject.add(c);
    //   }
    //   var _sumReject = medicalReject.reduce((a, b) => a + b);
    //   setState(() {
    //     sumReject = _sumReject;
    //     // print(filteredData);
    //   });
    // }
    // var testdata = [];
    // var mergedCategoriesMedical = <String, CategoriesMedical>{};

    List<CategoriesMedical> ad = [];
    _dataMedical.forEach((element) {
      ad.add(CategoriesMedical(element.department, 0, 0, 0));
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

    List<CategoriesMedical> ddd =
        CategoriesMedical.parseApplList(jsonEncode(result));

    ddd.forEach((a) {
      _dataMedical.forEach((b) {
        if (a.name == b.department) {
          if (b.status == "อนุมัติ") {
            a.amountApprove += int.parse(b.payamount);
          } else if (b.status == "ร้องขอ") {
            a.amountRequest += int.parse(b.receiptamount);
          } else {
            a.amountReject += int.parse(b.receiptamount);
          }
        }
      });
    });
    print(jsonEncode(ddd));

    setState(() {
      CategoriesMedicals = ddd;
    });

// print(ss);
// CategoriesMedicalMedical =

    //  List<CategoriesMedical> loaddata = [];
    // _dataMedical.forEach((element) {
    //   print(element.department);
    //   print(element.payamount);
    //   loaddata.add(CategoriesMedical(
    //     name: element.department,
    //     amount : int.parse(element.payamount),
    //   ));
    //   print(loaddata[0].amount);
    // });
    // // var  cc = loaddata;

    // for (var cc in loaddata) {
    //     testdata.add(cc);

    // }

// CategoriesMedicalMedical = loaddata;

// filteredDataca = CategoriesMedicalMedical;
//               print(CategoriesMedicalMedical.length);
// // print(CategoriesMedicalMedical.toList());
//               print(jsonEncode(loaddata));
// Map<String, dynamic> userMap = jsonDecode(CategoriesMedicalMedical);
//               var user = CategoriesMedical.fromJson(loaddata);

// for (var categories in _dataMedical) {
//   // late  int amount = 0;
//     names = categories.department;
//     amounts = int.parse(categories.payamount);
//     // mergedCategoriesMedical.addAll(names,amounts);
//   //  final testdata = CategoriesMedical(name: names,amount: amounts) as List<dynamic>;

// print(testdata);

//  addTaskAndAmount.call(names,amounts);
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'รายงานค่ารักษาพยาบาล',
          // Text(widget.Status.toString(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
            color: iWhiteColor,
          ),
        ),
        backgroundColor: iOrangeColor,
      ),
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
                              "รายงานค่ารักษาพยาบาลแยกตามฝ่ายงาน",
                              style: TextStyle(
                                fontSize: 18,
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
                              "จำนวนเงินที่อนุมัตินำจ่ายทั้งหมด",
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
                              "จำนวนเงินที่รออนุมัตินำจ่ายทั้งหมด",
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
                              "จำนวนเงินที่ปฏิเสธนำจ่ายทั้งหมด",
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
                      List.generate(CategoriesMedicals.length, (index) {
                    if (CategoriesMedicals.isNotEmpty) {
                      CategoriesMedical item =
                          CategoriesMedicals[index];
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

class CategoriesMedical {
  final String name;
  late int amountApprove;
  late int amountRequest;
  late int amountReject;
  CategoriesMedical(
      this.name, this.amountApprove, this.amountRequest, this.amountReject);

  factory CategoriesMedical.fromJson(Map<String, dynamic> json) {
    return CategoriesMedical(
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

  static List<CategoriesMedical> parseApplList(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<CategoriesMedical> listData = parsed
        .map<CategoriesMedical>((json) => CategoriesMedical.fromJson(json))
        .toList();
    return listData;
  }
}
