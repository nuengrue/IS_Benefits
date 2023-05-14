//import 'dart:developer';

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

      Navigator.pop(
        context,
        MaterialPageRoute(
          builder: (context) => ListCremationServiceAdminPage(Status: "ร้องขอ"),
        ),
      );
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
    Navigator.pop(
      context,
      MaterialPageRoute(
        builder: (context) => ListCremationServiceAdminPage(Status: "ร้องขอ"),
      ),
    );
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
