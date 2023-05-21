import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:ghb_banefits_admin/All_Controllers_Admin/Education_Controller.dart';
import 'package:ghb_banefits_admin/All_Models_Admin/education_model.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_education.dart';
import 'package:ghb_banefits_admin/All_Services_Admin/servics.dart';
import 'package:ghb_banefits_admin/color.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class ReportEducationPage extends StatefulWidget {
  const ReportEducationPage({Key? key}) : super(key: key);

  @override
  State<ReportEducationPage> createState() => _ReportEducationPageState();
}

class _ReportEducationPageState extends State<ReportEducationPage> {
  List<EducationAdmin> filteredData = [];
  List<EducationAdmin> data = List.empty();
    late double sumApprove = 0;
  late double sumRequest = 0;
  late double sumReject = 0;
   List<CategoriesEducation> CategoriesEducations = List.empty();
  late int amount = 0;
  late String name = "";
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getEducationAdminReport(context);
    

  }

  @override
  void dispose() {

    super.dispose();
  }

 void _onSearchTextChanged(String text) {
    setState(() {
      filteredData = text.isEmpty
          ? data
          : data
              .where((item) =>
                  item.name.toLowerCase().contains(text.toLowerCase()) ||
                  item.status.toLowerCase().contains(text.toLowerCase()))
              .toList();

      print(data);
    });
  }

  EducationAdminController controller =
      EducationAdminController(FirebaseServicesAdmin());

void   _getEducationAdminReport(BuildContext context) async {
            var _dataEducation = await controller.fetchEducationAdmin();
            print(_dataEducation.length);
            if(_dataEducation.length > 0){
                        setState(() {
              data = _dataEducation;
              filteredData = _dataEducation;
              // print(filteredData);
            });
            context.read<EducationAdminProviders>().EducationAdminList = _dataEducation;
            }
            var _dataEducation_app   =   _dataEducation ;
            var _dataEducation_req   =   _dataEducation ;
            var _dataEducation_rej   =   _dataEducation ;
    // get data  EducationDashboard
    //var newEducationDashboard = await educationcontroller.fetchEducation();
_dataEducation.forEach((b) {

          if (b.status == "อนุมัติ") {
            sumApprove += int.parse(b.payamount);
          } else if (b.status == "ร้องขอ") {
            sumRequest += int.parse(b.amountreceipt);
          } else if (b.status == "ปฏิเสธ") {
            sumReject += int.parse(b.amountreceipt);
          }

      });

setState(() {
  
});
    //     if(_dataEducation_app.length > 0){
    // var cApproveEducationAdmin = _dataEducation_app.where((x) => x.status == "อนุมัติ");
    // final education = [];
    // for (var doc in cApproveEducationAdmin) {
    //   double a = double.parse(doc.payamount);
    //   education.add(a);
    // }
    // var _sumApprove = education.reduce((a, b) => a + b);
    //                     setState(() {
    //           sumApprove = _sumApprove;
    //           // print(filteredData);
    //         });
    
    //     }
        


    //     if(_dataEducation_req.length > 0){
    // var cRequestEducationAdmin = _dataEducation_req.where((x) => x.status == "ร้องขอ");
    // final educationRequest = [];
    // for (var doc in cRequestEducationAdmin) {
    //   double b = double.parse(doc.amountreceipt);
    //   educationRequest.add(b);
    // }
    // var _sumRequest = educationRequest.reduce((a, b) => a + b);
    //                 setState(() {
    //           sumRequest = _sumRequest;
    //           // print(filteredData);
    //         });
    //     }
    //     if(_dataEducation_rej.length > 0){
    //     var cRejectEducationAdmin = _dataEducation_rej.where((x) => x.status == "ปฏิเสธ");
    // final educationReject = [];
    // for (var doc in cRejectEducationAdmin) {
    //   double c = double.parse(doc.amountreceipt);
    //   educationReject.add(c);
    // }
    // var _sumReject = educationReject.reduce((a, b) => a + b);
    //             setState(() {
    //           sumReject = _sumReject;
    //           // print(filteredData);
    //         });
    //     }
            // setState(() {
            //   data = _dataEducation;
            //   print(_dataEducation);
            //   filteredData = _dataEducation;
            //   // print(filteredData);
            // });
            
          // context.read<EducationAdminProviders>().EducationAdminList = _dataEducation;
    List<CategoriesEducation> Educationjson = [];
    _dataEducation.forEach((element) {
      Educationjson.add(CategoriesEducation(element.department, 0, 0, 0));
    });
    print(jsonEncode(Educationjson));

//  int.parse(element.payamount)
// convert each item to a string by using JSON encoding
    final jsonListEducation = Educationjson.map((item) => jsonEncode(item)).toList();
    print(jsonListEducation);
    // using toSet - toList strategy
    final uniqueJsonListEducation = jsonListEducation.toSet().toList();
    print(uniqueJsonListEducation);

    // convert each item back to the original form using JSON decoding
    final resultEducation = uniqueJsonListEducation.map((item) => jsonDecode(item)).toList();
    print(jsonEncode(resultEducation));

    // VerifyModel.parseApplList(jsonEncode(result));

    List<CategoriesEducation> EducationList =
        CategoriesEducation.parseApplList(jsonEncode(resultEducation));
    print('**********************************************************************************');
    EducationList.forEach((a) {
      _dataEducation.forEach((b) {
        if (a.nameedu == b.department) {
          if (b.status == "อนุมัติ") {
            a.amountApproveedu += int.parse(b.payamount);
          } else if (b.status == "ร้องขอ") {
            a.amountRequestedu += int.parse(b.amountreceipt);
          } else if (b.status == "ปฏิเสธ") {
            a.amountRejectedu += int.parse(b.amountreceipt);
          }
        }
      });
    });
        print('**********************************************************************************');
    print(jsonEncode(EducationList));
    print('**********************************************************************************');
    setState(() {
      CategoriesEducations = EducationList;
    });

      }
  @override
  Widget build(BuildContext context) {
      final double width = MediaQuery.of(context).size.width;
    return Scaffold(
            appBar: AppBar(title: 
             Text('รายงานค่าช่วยเหลือการศึกษาบุตร',
            // Text(widget.Status.toString(),
            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: iWhiteColor,fontFamily: 'Sarabun',),),backgroundColor: iOrangeColor,),
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
                              "รายงานค่าช่วยเหลือการศึกษาบุตรแยกตามฝ่ายงาน",
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
        child :SingleChildScrollView(
                // scrollDirection : Axis.horizontal,       
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: DataTable(
            columnSpacing: 0,
              horizontalMargin: 0,
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Center(child: Flexible(child: Text('ฝ่ายงาน',style: TextStyle(fontFamily: 'Sarabun',),))),
                    ),
                    DataColumn(
                      label: Center(child: Flexible(child: Text('นำจ่าย',style: TextStyle(fontFamily: 'Sarabun',),))),
                    ),
                    DataColumn(
                      label: Center(child: Flexible(child: Text('รอนำจ่าย',style: TextStyle(fontFamily: 'Sarabun',),))),
                    ),
                    DataColumn(
                      label:
                          Center(child: Flexible(child: Text('ปฏิเสธนำจ่าย',style: TextStyle(fontFamily: 'Sarabun',),))),
                    ),
                  ],
                rows:
                      List.generate(CategoriesEducations.length, (index) {
                    if (CategoriesEducations.isNotEmpty) {
                      CategoriesEducation item =
                          CategoriesEducations[index];
                      NumberFormat myFormat =
                          NumberFormat.decimalPattern('en_us');
                      return DataRow(
                        cells: [
                          DataCell(Flexible(child: Text(item.nameedu.toString(),style: TextStyle(fontFamily: 'Sarabun',),))),
                          DataCell(Flexible(
                              child:
                                  Text(myFormat.format(item.amountApproveedu),style: TextStyle(fontFamily: 'Sarabun',),))),
                          DataCell(Flexible(
                              child:
                                  Text(myFormat.format(item.amountRequestedu),style: TextStyle(fontFamily: 'Sarabun',),))),
                          DataCell(Flexible(
                              child:
                                  Text(myFormat.format(item.amountRejectedu),style: TextStyle(fontFamily: 'Sarabun',),))),
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

class CategoriesEducation {
  final String nameedu;
  late int amountApproveedu;
  late int amountRequestedu;
  late int amountRejectedu;
  CategoriesEducation(
      this.nameedu, this.amountApproveedu, this.amountRequestedu, this.amountRejectedu);

  factory CategoriesEducation.fromJson(Map<String, dynamic> json) {
    return CategoriesEducation(
      json['nameedu'],
      json['amountApproveedu'],
      json['amountRequestedu'],
      json['amountRejectedu'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nameedu'] = nameedu;
    data['amountApproveedu'] = amountApproveedu;
    data['amountRequestedu'] = amountRequestedu;
    data['amountRejectedu'] = amountRejectedu;
    return data;
  }

  static List<CategoriesEducation> parseApplList(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<CategoriesEducation> listData = parsed
        .map<CategoriesEducation>((json) => CategoriesEducation.fromJson(json))
        .toList();
    return listData;
  }
}