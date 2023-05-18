//import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ghb_banefits_admin/All_Controllers_Admin/master_controllers.dart';
import 'package:ghb_banefits_admin/All_Models_Admin/cremation_service_model.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Cremation_Service/list_cremation_service.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_cremation.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_master.dart';
import 'package:ghb_banefits_admin/All_Services_Admin/servics.dart';
import 'package:ghb_banefits_admin/color.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:flutter/widgets.dart';

class DetailCremationServiceAdminPage extends StatefulWidget {
  const DetailCremationServiceAdminPage(
      {super.key, required this.Notes, required this.Indexs});

  // Declare a field that holds the Todo.
  final CremationServiceAdmin Notes;
  final int Indexs;

  @override
  State<DetailCremationServiceAdminPage> createState() =>
      _DetailCremationServiceAdminPageState();
}

class _DetailCremationServiceAdminPageState
    extends State<DetailCremationServiceAdminPage> {
  late String _status = "";
  late String _flagread = "";
  late int _Indexs;
  late String _payamount = "";
  late String _paydate = "";
  late String _remark = "";
  final _formKey = GlobalKey<FormState>();
  late final String _title = "แจ้งผลรายการคำขอสมัครฌาปนกิจสงเคราะห์";
  late String _content;
  final String _createDate =
      DateFormat('dd-MM-yyyy  kk:mm').format(DateTime.now());
  late String _id = "";
  late String _uid;

  MasterController mastecontroller = MasterController(FirebaseServicesAdmin());
  void initState() {
    super.initState();
    _getcountnoti(context);
  }

  late int _idcounts = 0;
  void _getcountnoti(BuildContext context) async {
    var newNotification = await mastecontroller.fetchNotiAdmin();
    context.read<NotificationsProviders>().NotificationsAdminList =
        newNotification;
    setState(() {
      _idcounts = newNotification.length + 1;
      print(_idcounts);
    });
  }

//api
  late String _no;
  late String _empcode;
  late String _name;
  late String _department;
  late String _divisionment;
  late String _idcard;
  late String _savedate;

//
  late String _housenumber;
  late String _alley;
  late String _road;
  late String _district;
  late String _county;
  late String _province;
  late String _tel;
  late String _readrules;
  late String _age;
  late String _datebirth;
  late String _namepartner;
  late String _pay1;
  late String _pay2;
  late String _pay3;
  late String _managername;
  late String _cardnumber;
  late String _relationship;
  late String _percentage;
  late String _conditions;
  // late  String _payamount;
  // late  String _paydate;
  // late  String _status;
  late String _email;
  late String _fileUrl;
  late String _filename;
  // late  String  _flagread;
  // late  String _id;
  late String _remarks = "";
  Future<CremationServiceAdmin>? _futureCremationServiceAdmin;

  Future<CremationServiceAdmin> createCremationServiceAdmin(
      String empcode,
      String name,
      String department,
      String divisionment,
      String idcard,
      String savedate,
      String housenumber,
      String alley,
      String road,
      String district,
      String county,
      String province,
      String tel,
      String readrules,
      String age,
      String datebirth,
      String namepartner,
      String pay1,
      String pay2,
      String pay3,
      String managername,
      String cardnumber,
      String relationship,
      String percentage,
      String conditions,
      String payamount,
      String paydate,
      String status,
      String email,
      String fileUrl,
      String filename,
      String flagread,
      String no,
      String id,
      String remarks) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.43/APIBenefit/CremationService/InsertCremationService'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'empcode': empcode,
        'name': name,
        'department': department,
        'divisionment': divisionment,
        'idcard': idcard,
        'savedate': savedate,
        // 'housenumber': housenumber,
        // 'alley': alley,
        // 'road': road,
        // 'district': district,
        // 'county': county,
        // 'province': province,
        // 'tel': tel,
        // 'readrules': readrules.toString(),
        // 'age': age,
        // 'datebirth': datebirth,
        'namepartner': namepartner,
        'pay1': pay1.toString(),
        'pay2': pay2.toString(),
        'pay3': pay3.toString(),
        'managername': managername,
        'cardnumber': cardnumber,
        'relationship': relationship,
        // 'percentage': percentage,
        'conditions': conditions,
        // 'payamount': payamount,
        'paydate': paydate,
        'status': status,
        'email': email,
        'fileUrl': fileUrl,
        'filename': filename,
        // 'flagread' : flagread,
        'no': no,
        'idfirebase': id,
        'remarks': remarks,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return CremationServiceAdmin.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create.');
    }
  }

//api
  void ModifydataApprove() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _Indexs = widget.Indexs.toInt();
      _status = "อนุมัติ";
      _flagread = "1";
      _payamount = _payamount;
      _paydate = DateFormat('dd-MM-yyyy  kk:mm').format(DateTime.now());
      _remark = _remark;
      print(_status);
      print(_remark);
      print(_flagread);
      print(_Indexs);
//

      _empcode = widget.Notes.email;
      _name = widget.Notes.name;
      _department = widget.Notes.department;
      _divisionment = widget.Notes.divisionment;
      _idcard = widget.Notes.idcard;
      _savedate = widget.Notes.savedate;
      _housenumber = widget.Notes.housenumber;
      _alley = widget.Notes.alley;
      _road = widget.Notes.road;
      _district = widget.Notes.district;
      _county = widget.Notes.county;
      _province = widget.Notes.province;
      _tel = widget.Notes.tel;
      _readrules = widget.Notes.readrules.toString();
      _age = widget.Notes.age;
      _datebirth = widget.Notes.datebirth;
      _namepartner = widget.Notes.namepartner;
      _pay1 = widget.Notes.pay1.toString();
      _pay2 = widget.Notes.pay2.toString();
      _pay3 = widget.Notes.pay3.toString();
      _managername = widget.Notes.managername;
      _cardnumber = widget.Notes.cardnumber;
      _relationship = widget.Notes.relationship;
      _percentage = widget.Notes.percentage;
      _conditions = widget.Notes.conditions;
      _email = widget.Notes.email;
      _fileUrl = widget.Notes.fileUrl;
      _filename = widget.Notes.filename;
      _no = widget.Notes.no.toString();
      _id = widget.Notes.id;

//set insert api
      _futureCremationServiceAdmin = createCremationServiceAdmin(
        _empcode,
        _name,
        _department,
        _divisionment,
        _idcard,
        _savedate,
        _housenumber,
        _alley,
        _road,
        _district,
        _county,
        _province,
        _tel,
        _readrules,
        _age,
        _datebirth,
        _namepartner,
        _pay1,
        _pay2,
        _pay3,
        _managername,
        _cardnumber,
        _relationship,
        _percentage,
        _conditions,
        _payamount,
        _paydate,
        _status,
        _email,
        _fileUrl,
        _filename,
        _flagread,
        _no,
        _id,
        _remark,
      );

      print(_futureCremationServiceAdmin);
      //
      Provider.of<CremationServiceAdminProviders>(context, listen: false)
          .modify(_Indexs, _status, _flagread, _payamount, _paydate, _remark);
      print("done");

      final docStatus = FirebaseFirestore.instance
          .collection('CremationService')
          .doc(widget.Notes.id);

      docStatus.update({
        'status': _status,
        'flagread': _flagread,
        'payamount': _payamount,
        'paydate': _paydate,
        'remarks': _remark
      });

      _content =
          "คำขอสมัครฌาปนกิจสงเคราะห์ ขอท่านได้รับการอนุมัติเรียบร้อยแล้ว";
      _uid = widget.Notes.email;
      CollectionReference Notifications =
          FirebaseFirestore.instance.collection('Notifications');
      DocumentReference doc = await Notifications.add({
        'no': _idcounts,
        'title': _title,
        'content': _content,
        'read': 0,
        'createDate': _createDate,
        'uid': _uid,
        'id': _id,
        'remarks': _remark
      });
      doc.update({
        'id': doc.id,
      });
            AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        showCloseIcon: true,
        btnOkText : "ตกลง",
        title: "สำเร็จ",
        desc: "ดำเนินการบันทึกข้อมูลสำเร็จ",
        btnOkOnPress: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ListCremationServiceAdminPage(Status: "ร้องขอ"),
        ),
      );
        },
      ).show();
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => ListCremationServiceAdminPage(Status: "ร้องขอ"),
      //   ),
      // );
    }
  }

  void ModifydataReject() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _Indexs = widget.Indexs.toInt();
      _status = "ปฏิเสธ";
      _flagread = "1";
      _payamount = "0";
      _paydate = DateFormat('dd-MM-yyyy  kk:mm').format(DateTime.now());
      _remark = _remark;
      _empcode = widget.Notes.email;
      _name = widget.Notes.name;
      _department = widget.Notes.department;
      _divisionment = widget.Notes.divisionment;
      _idcard = widget.Notes.idcard;
      _savedate = widget.Notes.savedate;
      _housenumber = widget.Notes.housenumber;
      _alley = widget.Notes.alley;
      _road = widget.Notes.road;
      _district = widget.Notes.district;
      _county = widget.Notes.county;
      _province = widget.Notes.province;
      _tel = widget.Notes.tel;
      _readrules = widget.Notes.readrules.toString();
      _age = widget.Notes.age;
      _datebirth = widget.Notes.datebirth;
      _namepartner = widget.Notes.namepartner;
      _pay1 = widget.Notes.pay1.toString();
      _pay2 = widget.Notes.pay2.toString();
      _pay3 = widget.Notes.pay3.toString();
      _managername = widget.Notes.managername;
      _cardnumber = widget.Notes.cardnumber;
      _relationship = widget.Notes.relationship;
      _percentage = widget.Notes.percentage;
      _conditions = widget.Notes.conditions;
      _email = widget.Notes.email;
      _fileUrl = widget.Notes.fileUrl;
      _filename = widget.Notes.filename;
      _no = widget.Notes.no.toString();
      _id = widget.Notes.id;

//set insert api
      _futureCremationServiceAdmin = createCremationServiceAdmin(
        _empcode,
        _name,
        _department,
        _divisionment,
        _idcard,
        _savedate,
        _housenumber,
        _alley,
        _road,
        _district,
        _county,
        _province,
        _tel,
        _readrules,
        _age,
        _datebirth,
        _namepartner,
        _pay1,
        _pay2,
        _pay3,
        _managername,
        _cardnumber,
        _relationship,
        _percentage,
        _conditions,
        _payamount,
        _paydate,
        _status,
        _email,
        _fileUrl,
        _filename,
        _flagread,
        _no,
        _id,
        _remark,
      );
      Provider.of<CremationServiceAdminProviders>(context, listen: false)
          .modify(_Indexs, _status, _flagread, _payamount, _paydate, _remark);
      print("done");

      final docStatus = FirebaseFirestore.instance
          .collection('CremationService')
          .doc(widget.Notes.id);

      docStatus.update({
        'status': _status,
        'flagread': _flagread,
        'paydate': _paydate,
        'remarks': _remark
      });
      _content = "คำขอสมัครฌาปนกิจสงเคราะห์ ขอท่านได้รับการปฏิเสธ";
      _uid = widget.Notes.email;
      CollectionReference Notifications =
          FirebaseFirestore.instance.collection('Notifications');
      DocumentReference doc = await Notifications.add({
        'no': _idcounts,
        'title': _title,
        'content': _content,
        'read': 0,
        'createDate': _createDate,
        'uid': _uid,
        'id': _id,
        'remarks': _remark
      });
      doc.update({
        'id': doc.id,
      });

                  AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        showCloseIcon: true,
        btnOkText : "ตกลง",
        title: "สำเร็จ",
        desc: "ดำเนินการบันทึกข้อมูลสำเร็จ",
        btnOkOnPress: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ListCremationServiceAdminPage(Status: "ร้องขอ"),
        ),
      );
        },
      ).show();
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => ListCremationServiceAdminPage(Status: "ร้องขอ"),
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'รายละเอียดคำขอสมัครฌาปนกิจสงเคราะห์',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Sarabun',
            color: iWhiteColor,
          ),
        ),
        backgroundColor: iOrangeColor,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(10.0),
                //height: double.infinity,
                width: 450,
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
                child: Column(
                  children: <Widget>[
                    Text(
                      'รายการคำขอสมัครเข้าเป็นสมาชิกฌาปนกิจ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 9, 28, 235),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    //   Row(
                    //   children: [
                    //     Expanded(
                    //       child: Text(
                    //         'เลขที่รายการ',
                    //         textAlign: TextAlign.left,
                    //         style: TextStyle(fontWeight: FontWeight.bold),
                    //       ),
                    //     ),
                    //     Expanded(
                    //       child: Text(
                    //         widget.Notes.no,
                    //         textAlign: TextAlign.end,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'สถานะรายการ',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.status,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(10.0),
                //height: double.infinity,
                width: 450,
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
                child: Column(
                  children: <Widget>[
                    Text(
                      'ข้อมูลพนักงาน',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 9, 28, 235),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'พนักงาน',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.name,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'หน่วยงาน',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              widget.Notes.department,
                              textAlign: TextAlign.end,
                            ),
                            Text(
                              widget.Notes.divisionment,
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'เลขที่บัตรประชาชน',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.idcard,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'วันที่บันทึก',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.savedate,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              ///

              /////////////
              ///
              //              Container(
              //   margin: const EdgeInsets.all(10.0),
              //   padding: const EdgeInsets.all(10.0),
              //   //height: double.infinity,
              //   width: 450,
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
              //         'ข้อมูลที่อยู่ปัจจุบันของพนักงาน',
              //         style: TextStyle(
              //           fontSize: 16,
              //           color: Color.fromARGB(255, 9, 28, 235),
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //       const Divider(),
              //          Row(
              //         children: [
              //           Expanded(
              //             child: Text(
              //               'บ้านเลขที่',
              //               textAlign: TextAlign.left,
              //               style: TextStyle(fontWeight: FontWeight.bold),
              //             ),
              //           ),
              //           Expanded(
              //             child: Text(
              //               widget.Notes.housenumber,
              //               textAlign: TextAlign.end,
              //             ),
              //           ),
              //         ],
              //       ),
              //        Row(
              //         children: [
              //           Expanded(
              //             child: Text(
              //               'ตรอก/ซอย',
              //               textAlign: TextAlign.left,
              //               style: TextStyle(fontWeight: FontWeight.bold),
              //             ),
              //           ),
              //           Expanded(
              //             child: Text(
              //               widget.Notes.alley,
              //               textAlign: TextAlign.end,
              //             ),
              //           ),
              //         ],
              //       ),
              //       Row(
              //         children: [
              //           Expanded(
              //             child: Text(
              //               'ถนน',
              //               textAlign: TextAlign.left,
              //               style: TextStyle(fontWeight: FontWeight.bold),
              //             ),
              //           ),
              //           Expanded(
              //             child: Text(
              //               widget.Notes.road,
              //               textAlign: TextAlign.end,
              //             ),
              //           ),
              //         ],
              //       ),
              //       Row(
              //         children: [
              //           Expanded(
              //             child: Text(
              //               'ตำบล/แขวง',
              //               textAlign: TextAlign.left,
              //               style: TextStyle(fontWeight: FontWeight.bold),
              //             ),
              //           ),
              //           Expanded(
              //             child: Text(
              //               widget.Notes.district,
              //               textAlign: TextAlign.end,
              //             ),
              //           ),
              //         ],
              //       ),
              //        Row(
              //         children: [
              //           Expanded(
              //             child: Text(
              //               'อำเภอ/เขต',
              //               textAlign: TextAlign.left,
              //               style: TextStyle(fontWeight: FontWeight.bold),
              //             ),
              //           ),
              //           Expanded(
              //             child: Text(
              //               widget.Notes.county,
              //               textAlign: TextAlign.end,
              //             ),
              //           ),
              //         ],
              //       ),
              //       Row(
              //         children: [
              //           Expanded(
              //             child: Text(
              //               'จังหวัด',
              //               textAlign: TextAlign.left,
              //               style: TextStyle(fontWeight: FontWeight.bold),
              //             ),
              //           ),
              //           Expanded(
              //             child: Text(
              //               widget.Notes.province,
              //               textAlign: TextAlign.end,
              //             ),
              //           ),
              //         ],
              //       ),
              //                           Row(
              //         children: [
              //           Expanded(
              //             child: Text(
              //               'หมายเลขติดต่อ',
              //               textAlign: TextAlign.left,
              //               style: TextStyle(fontWeight: FontWeight.bold),
              //             ),
              //           ),
              //           Expanded(
              //             child: Text(
              //               widget.Notes.tel,
              //               textAlign: TextAlign.end,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(10.0),
                //height: double.infinity,
                width: 450,
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
                child: Column(
                  children: <Widget>[
                    Text(
                      'รับทราบและยินยอม',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 9, 28, 235),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: iBlueColor),
                          borderRadius: BorderRadius.circular(20),
                        ), //BoxDecoration

                        /** CheckboxListTile Widget **/
                        child: CheckboxListTile(
                          title: const Text(
                              'ได้อ่านและรับทราบข้อบังคับธนาคารอาคารสงเคราะห์ว่าด้วยการฌาปนกิจสงเคราะห์พ.ศ.2559 และที่แก้ไขเพิ่มเติม'),
                          //subtitle: const Text('A computer science portal for geeks.'),
                          //secondary: const Icon(Icons.code),
                          autofocus: false,
                          activeColor: iOrangeColor,
                          checkColor: Colors.white,
                          selected: widget.Notes.readrules,
                          value: widget.Notes.readrules,
                          onChanged: (value) {},
                        ), //CheckboxListTile
                      ), //Container
                    ),
                  ],
                ),
              ),
              //                            Container(
              //   margin: const EdgeInsets.all(10.0),
              //   padding: const EdgeInsets.all(10.0),
              //   //height: double.infinity,
              //   width: 450,
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
              //         'ข้อมูลอายุของพนักงาน',
              //         style: TextStyle(
              //           fontSize: 16,
              //           color: Color.fromARGB(255, 9, 28, 235),
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //       const Divider(),
              //          Row(
              //         children: [
              //           Expanded(
              //             child: Text(
              //               'อายุของพนักงาน',
              //               textAlign: TextAlign.left,
              //               style: TextStyle(fontWeight: FontWeight.bold),
              //             ),
              //           ),
              //           Expanded(
              //             child: Text(
              //               widget.Notes.age,
              //               textAlign: TextAlign.end,
              //             ),
              //           ),
              //         ],
              //       ),
              //        Row(
              //         children: [
              //           Expanded(
              //             child: Text(
              //               'วันที่เกิดของ',
              //               textAlign: TextAlign.left,
              //               style: TextStyle(fontWeight: FontWeight.bold),
              //             ),
              //           ),
              //           Expanded(
              //             child: Text(
              //               widget.Notes.datebirth,
              //               textAlign: TextAlign.end,
              //             ),
              //           ),
              //         ],
              //       ),

              //     ],
              //   ),
              // ),
              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(10.0),
                //height: double.infinity,
                width: 450,
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
                child: Column(
                  children: <Widget>[
                    Text(
                      'ข้อมูลคู่สมรส',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 9, 28, 235),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'ชื่อ-นามสกุลคู่สมรส',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.namepartner,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(10.0),
                //height: double.infinity,
                width: 450,
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
                child: Column(
                  children: <Widget>[
                    Text(
                      'การชำระเงินฌาปนกิจ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 9, 28, 235),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: iBlueColor,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ), //BoxDecoration

                        /** CheckboxListTile Widget **/
                        child: CheckboxListTile(
                          title: const Text(
                              'ชำระเงินเป็นค่าสมัครเข้าเป็นสมาชิก เป็นเงิน 100 บาท'),
                          //subtitle: const Text('A computer science portal for geeks.'),
                          //secondary: const Icon(Icons.code),
                          autofocus: false,
                          activeColor: iOrangeColor,
                          checkColor: Colors.white,
                          selected: widget.Notes.pay1,
                          value: widget.Notes.pay1,
                          onChanged: (value) {},
                        ), //CheckboxListTile
                      ), //Container
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: iBlueColor,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ), //BoxDecoration

                        /** CheckboxListTile Widget **/
                        child: CheckboxListTile(
                          title: const Text(
                              'ชำระเงินสงเคราะห์ล่วงหน้าตามอัตราที่ทางการฌาปนกิจสงเคราะห์ ธนาคารอาคารสงเคราะห์ เรียกเก็บเป็นเงิน 300 บาท'),
                          //subtitle: const Text('A computer science portal for geeks.'),
                          //secondary: const Icon(Icons.code),
                          autofocus: false,
                          activeColor: iOrangeColor,
                          checkColor: Colors.white,
                          selected: widget.Notes.pay2,
                          value: widget.Notes.pay2,
                          onChanged: (value) {},
                        ), //CheckboxListTile
                      ), //Container
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: iBlueColor,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ), //BoxDecoration

                        /** CheckboxListTile Widget **/
                        child: CheckboxListTile(
                          title: const Text(
                              'ชำระเงินสงเคราะห์ศพเป็นไปตามอัตราที่ทางการฌาปนกิจสงเคราะห์ ธนาคารอาคารสงเคราะห์เรียกเก็บ'),
                          //subtitle: const Text('A computer science portal for geeks.'),
                          //secondary: const Icon(Icons.code),
                          autofocus: false,
                          activeColor: iOrangeColor,
                          checkColor: Colors.white,
                          selected: widget.Notes.pay3,
                          value: widget.Notes.pay3,
                          onChanged: (value) {},
                        ), //CheckboxListTile
                      ), //Container
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(10.0),
                //height: double.infinity,
                width: 450,
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
                child: Column(
                  children: <Widget>[
                    Text(
                      'ข้อมูลผู้จัดการศพ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 9, 28, 235),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'ชื่อ-นามสกุล',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.managername,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'เลขที่บัตรประชาชน',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.cardnumber,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'ตวามเกี่ยวข้องกับพนักงาน',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.relationship,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    //  Row(
                    //   children: [
                    //     Expanded(
                    //       child: Text(
                    //         'ร้อยละ',
                    //         textAlign: TextAlign.left,
                    //         style: TextStyle(fontWeight: FontWeight.bold),
                    //       ),
                    //     ),
                    //     Expanded(
                    //       child: Text(
                    //         widget.Notes.percentage,
                    //         textAlign: TextAlign.end,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'การแบ่งเงินฌาปนกิจ',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.conditions,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(10.0),
                //height: double.infinity,
                width: 450,
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
                child: Column(
                  children: <Widget>[
                    Text(
                      'หมายเหตุ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 9, 28, 235),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          if (widget.Notes.status == "ร้องขอ") ...[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: TextFormField(
                                  maxLength: 150,
                                  maxLines: 3,

                                  //controller: _addressc,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'หมายเหตุ',
                                  ),
                                  // validator: (value) {
                                  //   if (value == null || value.isEmpty) {
                                  //     return 'โปรดหมายเหตุ';
                                  //   }
                                  // },
                                  onSaved: (value) => _remark = value!,
                                ),
                              ),
                            ),
                          ] else ...[
                            Expanded(
                              child: Text(
                                'หมายเหตุ',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.Notes.remarks,
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ]
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(10.0),
                //height: double.infinity,
                width: 450,
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
                child: Column(
                  children: <Widget>[
                    Text(
                      'เอกสารแนบ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 9, 28, 235),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text(widget.Notes.filename.toString()),
                      trailing: Icon(Icons.remove_red_eye),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => View(
                                      url: widget.Notes.fileUrl,
                                    )));
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Column(children: [
                if (widget.Notes.status == "ร้องขอ") ...[
                  Container(
                    margin: const EdgeInsets.all(2.0),
                    padding: const EdgeInsets.all(2.0),
                    //height: double.infinity,
                    width: 450,
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
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.green),
                                  child: Text("อนุมัติ"),
                                  onPressed: () {
                                    ModifydataApprove();
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.red),
                                  child: Text("ปฏิเสธ"),
                                  onPressed: () {
                                    ModifydataReject();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  Text(""),
                ]
              ]),

              SizedBox(
                height: 10,
              ),

              SizedBox(
                height: 30,
              ),

              ///
            ],
          ),
        ),
      ),
    );
  }
}

class View extends StatefulWidget {
  final url;
  const View({this.url});

  @override
  State<View> createState() => _ViewState();
}

class _ViewState extends State<View> {
  // PdfViewerController? _pdfViewerController;
  late final PdfViewerController _pdfViewerController;

  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SfPdfViewer.network(
          widget.url,
          controller: _pdfViewerController,
        ),
        appBar: AppBar(
          title: Text(
            'รายละเอียดเอกสาร',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Sarabun',
              color: iWhiteColor,
            ),
          ),
          backgroundColor: iOrangeColor,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.keyboard_arrow_up,
                color: Colors.white,
              ),
              onPressed: () {
                _pdfViewerController.previousPage();
              },
            ),
            IconButton(
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
              onPressed: () {
                _pdfViewerController.nextPage();
              },
            ),
            IconButton(
              icon: Icon(
                Icons.zoom_in,
                color: Colors.white,
              ),
              onPressed: () {
                _pdfViewerController.zoomLevel = 2;
              },
            )
          ],
        ),
      ),
    );
  }
}
