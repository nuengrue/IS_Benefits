//import 'dart:developer';

import 'dart:convert';
import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ghb_banefits_admin/All_Controllers_Admin/child_allowance_controllers.dart';
import 'package:ghb_banefits_admin/All_Controllers_Admin/master_controllers.dart';
import 'package:ghb_banefits_admin/All_Models_Admin/child_allowane_model.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Child_Allowances/list_child_allowance.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_child_allowance.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_master.dart';
import 'package:ghb_banefits_admin/All_Services_Admin/servics.dart';
import 'package:ghb_banefits_admin/color.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:http/http.dart' as http;
//import 'package:flutter/widgets.dart';
//   Future<ChildAllowanceAdmin> createChildAllowanceAdmin(String empcode,String nameemp,String department,String divisionment,String savedate,String namechild,String namepartner,String officetner,String maritalstatus,
//       String submaritalstatus,String status,String email,String fileUrl,String filename,String flagread, String no,String id,String remarks) 
//       async {
//   var response2 = await http.post(
//     Uri.parse('http://192.168.1.43/ChildAllowance/InsertChildAllowance'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//       body: jsonEncode(<String, String>{
//         'empcode': empcode,
//         'nameemp': nameemp,
//         'department': department,
//         'divisionment': divisionment,
//         'savedate': savedate,
//         'namechild': namechild,
//         'namepartner': namepartner,
//         'officetner': officetner,
//         'maritalstatus': maritalstatus,
//         'submaritalstatus': submaritalstatus,
//         'status': status,
//         'email': email,
//         'fileUrl': fileUrl,
//         'filename': filename,
//         'flagread': flagread,
//         'no': no,
//         'idfirebase': id,
//         'remarks': remarks,
//       }),
//     );
//   final response = response2;
// print(response);
//     if (response.statusCode == 200) {
//       print(response.statusCode);
//       // If the server did return a 201 CREATED response,
//       // then parse the JSON.
//       return ChildAllowanceAdmin.fromJson(jsonDecode(response.body));
//     } else {
//       // If the server did not return a 201 CREATED response,
//       // then throw an exception.
//       // throw Exception('Failed to create.');
//     }
//   }
class DetailChildAllowanceAdminPage extends StatefulWidget {
  const DetailChildAllowanceAdminPage(
      {super.key, required this.Notes, required this.Indexs});

  // Declare a field that holds the Todo.
  final ChildAllowanceAdmin Notes;
  final int Indexs;

  @override
  State<DetailChildAllowanceAdminPage> createState() =>
      _DetailChildAllowanceAdminPageState();
}

class _DetailChildAllowanceAdminPageState
    extends State<DetailChildAllowanceAdminPage> {

  late String _no;
  late String _empcode;
  late String _nameemp;
  late String _department;
  late String _divisionment;
  late String _savedate;
  late String _namechild;
  late String _namepartner;
  late String _officetner;
  late String _maritalstatus;
  late String _submaritalstatus;
  late String _email;
  late String _url;
  late String _filename;

   late Future<ChildAllowanceAdmin> _futureChildAllowanceAdmin;
  Future<ChildAllowanceAdmin> createChildAllowanceAdmin(String empcode,String nameemp,String department,
  String divisionment,String savedate,String namechild,String namepartner,String officetner,String maritalstatus,
      String submaritalstatus,String status,String email,String fileUrl,String filename,String flagread, String no,String id,String remarks) 
      async {
  final response = await http.post(
    Uri.parse('http://192.168.1.45/APIBenefit/ChildAllowance/InsertChildAllowance'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
      body: jsonEncode(<String, String>{
        'empcode': empcode,
        'nameemp': nameemp,
        'department': department,
        'divisionment': divisionment,
        'savedate': savedate,
        'namechild': namechild,
        'namepartner': namepartner,
        'officetner': officetner,
        'maritalstatus': maritalstatus,
        'submaritalstatus': submaritalstatus,
        'status': status,
        'email': email,
        'fileUrl': fileUrl,
        'filename': filename,
        'flagread': flagread,
        'no': no,
        'idfirebase': id,
        'remarks': remarks,
      }),
    );
print(response);
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print(response.statusCode);
       return ChildAllowanceAdmin.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      
      throw Exception('Failed to create.');
    }
  }
  late String _status = "";
  late String _flagread = "";
  late int _Indexs;

  late final String _title = "แจ้งผลรายการคำขอเบิกเงินค่าช่วยเหลือบุตร";
  late String _content;
  final String _createDate =
      DateFormat('dd-MM-yyyy  kk:mm').format(DateTime.now());
  late String _id = "";
  late String _uid;

  late String _remark = "";
  final _formKey = GlobalKey<FormState>();
  late int sumCount = 0;
  ChildAllowanceAdminController controller =
      ChildAllowanceAdminController(FirebaseServicesAdmin());
  MasterController mastecontroller = MasterController(FirebaseServicesAdmin());
  void initState() {
    super.initState();
    _getcountnoti(context);
  }

  late int _idcounts = 0;
  void _getcountnoti(BuildContext context) async {
    var _dataChildAllowance = await controller.fetchChildAllowanceAdmin();
    var _dataChildAllowanceuid = _dataChildAllowance
        .where((x) => x.email == widget.Notes.email)
        .where((x) => x.namechild == widget.Notes.namechild)
        .where((x) => x.status == "อนุมัติ");
    print(widget.Notes.email);

    setState(() {
      sumCount = _dataChildAllowanceuid.length;
      print('dddd $sumCount');
    });

    var newNotification = await mastecontroller.fetchNotiAdmin();
    context.read<NotificationsProviders>().NotificationsAdminList =
        newNotification;
    setState(() {
      _idcounts = newNotification.length + 1;
    });
  }

//api
//api
  
  void ModifydataApprove() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _Indexs = widget.Indexs.toInt();
      _status = "อนุมัติ";
      _flagread = "1";
      _remark = _remark;
      print(_remark);
//
      _empcode = widget.Notes.empcode;
      _nameemp = widget.Notes.nameemp;
      _department = widget.Notes.department;
      _divisionment = widget.Notes.divisionment;
      _savedate = widget.Notes.savedate;
      _namechild = widget.Notes.namechild;
      _namepartner = widget.Notes.namepartner;
      _officetner = widget.Notes.officetner;
      _maritalstatus = widget.Notes.maritalstatus;
      _submaritalstatus = widget.Notes.submaritalstatus;
      _email = widget.Notes.email;
      _url = widget.Notes.fileUrl;
      _filename = widget.Notes.filename;
      _no = widget.Notes.no.toString();
      _id = widget.Notes.id;

//set insert api
setState(() {
  
      _futureChildAllowanceAdmin = createChildAllowanceAdmin(
          _empcode,
          _nameemp,
          _department,
          _divisionment,
          _savedate,
          _namechild,
          _namepartner,
          _officetner,
          _maritalstatus,
          _submaritalstatus,
          _status,
          _email,
          _url,
          _filename,
          _flagread,
          _no,
          _id,
          _remark);
});
      print(_futureChildAllowanceAdmin);
      //
      Provider.of<ChildAllowanceAdminProviders>(context, listen: false)
          .modify(_Indexs, _status, _flagread, _remark);
      print("done");

      _content = "คำขอเบิกเงินค่าช่วยเหลือบุตร ชื่อ " +
          widget.Notes.namechild +
          " ได้รับการอนุมัติเรียบร้อยแล้ว";
      _uid = widget.Notes.email;

      final docStatus = FirebaseFirestore.instance
          .collection('ChildAllowance')
          .doc(widget.Notes.id);

      docStatus.update(
          {'status': _status, 'flagread': _flagread, 'remarks': _remark});

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
          builder: (context) => ListChildAllowanceAdminPage(Status: "ร้องขอ"),
        ),
      );
        },
      ).show();
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => ListChildAllowanceAdminPage(Status: "ร้องขอ"),
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
      _remark = _remark;
      print(_status);
      print(_flagread);
      print(_Indexs);
      _empcode = widget.Notes.empcode;
      _nameemp = widget.Notes.nameemp;
      _department = widget.Notes.department;
      _divisionment = widget.Notes.divisionment;
      _savedate = widget.Notes.savedate;
      _namechild = widget.Notes.namechild;
      _namepartner = widget.Notes.namepartner;
      _officetner = widget.Notes.officetner;
      _maritalstatus = widget.Notes.maritalstatus;
      _submaritalstatus = widget.Notes.submaritalstatus;
      _email = widget.Notes.email;
      _url = widget.Notes.fileUrl;
      _filename = widget.Notes.filename;
      _no = widget.Notes.no.toString();
      _id = widget.Notes.id;

//set insert api
setState(() {
  
      _futureChildAllowanceAdmin = createChildAllowanceAdmin(
          _empcode,
          _nameemp,
          _department,
          _divisionment,
          _savedate,
          _namechild,
          _namepartner,
          _officetner,
          _maritalstatus,
          _submaritalstatus,
          _status,
          _email,
          _url,
          _filename,
          _flagread,
          _no,
          _id,
          _remark);
});
      print(_futureChildAllowanceAdmin);
      Provider.of<ChildAllowanceAdminProviders>(context, listen: false)
          .modify(_Indexs, _status, _flagread, _remark);
      print("done");

      final docStatus = FirebaseFirestore.instance
          .collection('ChildAllowance')
          .doc(widget.Notes.id);

      docStatus.update(
          {'status': _status, 'flagread': _flagread, 'remarks': _remark});

      _content = "คำขอเบิกเงินค่าช่วยเหลือบุตร ชื่อ " +
          widget.Notes.namechild +
          " ได้รับการปฏิเสธ";
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
          builder: (context) => ListChildAllowanceAdminPage(Status: "ร้องขอ"),
        ),
      );
        },
      ).show();
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => ListChildAllowanceAdminPage(Status: "ร้องขอ"),
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'รายละเอียดคำขอเบิกค่าช่วยเหลือบุตร',
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
                width: 800,
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
                      'รายการคำขอเบิกเงินค่าช่วยเหลือบุตร',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 9, 28, 235),
                        fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                      ),
                    ),
                    const Divider(),
                    // Row(
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
                            style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
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
                width: 800,
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
                        fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                      ),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'พนักงาน',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.nameemp,
                            textAlign: TextAlign.end,
                            style: TextStyle(fontFamily: 'Sarabun',),
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
                            style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              widget.Notes.department,
                              textAlign: TextAlign.end,
                              style: TextStyle(fontFamily: 'Sarabun',),
                            ),
                            Text(
                              widget.Notes.divisionment,
                              textAlign: TextAlign.end,
                              style: TextStyle(fontFamily: 'Sarabun',),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'วันที่บันทึก',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.savedate,
                            textAlign: TextAlign.end,
                            style: TextStyle(fontFamily: 'Sarabun',),
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
                width: 800,
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
                      'ข้อมูลบุตร',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 9, 28, 235),
                        fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                      ),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'บุตรของพนักงาน',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.namechild,
                            textAlign: TextAlign.end,
                            style: TextStyle(fontFamily: 'Sarabun',),
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
                width: 800,
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
                        fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                      ),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'ชื่อ-นามสกุลของคู่มสมรส',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.namepartner,
                            textAlign: TextAlign.end,
                            style: TextStyle(fontFamily: 'Sarabun',),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'สถานะการสมรส',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              widget.Notes.maritalstatus,
                              textAlign: TextAlign.end,
                              style: TextStyle(fontFamily: 'Sarabun',),
                            ),
                            Text(
                              widget.Notes.submaritalstatus,
                              textAlign: TextAlign.end,
                              style: TextStyle(fontFamily: 'Sarabun',),
                            ),
                          ],
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
                        fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                      ),
                    ),
                    const Divider(),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         child: Text(
                    //           'หมายเหตุ',
                    //           textAlign: TextAlign.left,
                    //           style: TextStyle(fontWeight: FontWeight.bold),
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: Text(
                    //           widget.Notes.receiptamount,
                    //           textAlign: TextAlign.end,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
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
                                  //     return 'โปรดระบุจำนวนเงินจ่าย';
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
                                style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.Notes.remarks,
                                textAlign: TextAlign.end,
                                style: TextStyle(fontFamily: 'Sarabun',),
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
                width: 800,
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
                      title: Text(widget.Notes.filename.toString(),style: TextStyle(fontFamily: 'Sarabun',),),
                      //subtitle:Text(widget.Indexs.toString()),
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
              Column(children: [
                if (widget.Notes.status == "ร้องขอ") ...[
                  if (sumCount == 1) ...[
                    if (sumCount == 1) ...[
                      Container(
                        margin: const EdgeInsets.all(2.0),
                        padding: const EdgeInsets.all(2.0),
                        //height: double.infinity,
                        width: 800,
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
                                    child: Text(
                                      "บุตรตามคำขอดังกล่าวได้รับการอนุมัติไปแล้ว",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(2.0),
                        padding: const EdgeInsets.all(2.0),
                        //height: double.infinity,
                        width: 800,
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
                                          primary: Colors.red),
                                      child: Text("ปฏิเสธ",style: TextStyle(fontFamily: 'Sarabun',),),
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
                  ] else ...[
                    if (sumCount == 0) ...[
                      Container(
                        margin: const EdgeInsets.all(2.0),
                        padding: const EdgeInsets.all(2.0),
                        //height: double.infinity,
                        width: 800,
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
                                      child: Text("อนุมัติ",style: TextStyle(fontFamily: 'Sarabun',),),
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
                                      child: Text("ปฏิเสธ",style: TextStyle(fontFamily: 'Sarabun',),),
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
                  ]
                ]
              ]),
              //   Column(children: [
              //     if (widget.Notes.status == "ร้องขอ") ...[

              //       if(sumCount == 0) ...[
              //  Container(
              //         margin: const EdgeInsets.all(2.0),
              //         padding: const EdgeInsets.all(2.0),
              //         //height: double.infinity,
              //         width: 800,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(5),
              //           border: Border.all(
              //             color: Colors.white,
              //           ),
              //           color: Colors.white,
              //           boxShadow: [
              //             BoxShadow(
              //               blurRadius: 6.0,
              //               spreadRadius: 2.0,
              //               color: Colors.grey,
              //               offset: Offset(0.0, 0.0),
              //             )
              //           ],
              //         ),
              //         child: Column(
              //           children: <Widget>[
              //             Row(
              //               children: [
              //                 // Expanded(
              //                 //   child: Padding(
              //                 //     padding: const EdgeInsets.all(5.0),
              //                 //     child: ElevatedButton(
              //                 //       style: ElevatedButton.styleFrom(
              //                 //           primary: Colors.green),
              //                 //       child: Text("อนุมัติ"),
              //                 //       onPressed: () {
              //                 //         ModifydataApprove();
              //                 //       },
              //                 //     ),
              //                 //   ),
              //                 // ),
              //                 Expanded(
              //                   child: Padding(
              //                     padding: const EdgeInsets.all(5.0),
              //                     child: ElevatedButton(
              //                       style: ElevatedButton.styleFrom(
              //                           primary: Colors.red),
              //                       child: Text("ปฏิเสธ"),
              //                       onPressed: () {
              //                         ModifydataReject();
              //                       },
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ],
              //         ),
              //       ),
              //     ] else ...[
              //       Text(""),
              //     ]
              // //       ] else ...[
              // //                        if(sumCount == 1) ...[
              // //  Container(
              // //         margin: const EdgeInsets.all(2.0),
              // //         padding: const EdgeInsets.all(2.0),
              // //         //height: double.infinity,
              // //         width: 800,
              // //         decoration: BoxDecoration(
              // //           borderRadius: BorderRadius.circular(5),
              // //           border: Border.all(
              // //             color: Colors.white,
              // //           ),
              // //           color: Colors.white,
              // //           boxShadow: [
              // //             BoxShadow(
              // //               blurRadius: 6.0,
              // //               spreadRadius: 2.0,
              // //               color: Colors.grey,
              // //               offset: Offset(0.0, 0.0),
              // //             )
              // //           ],
              // //         ),
              // //         child: Column(
              // //           children: <Widget>[
              // //             Row(
              // //               children: [
              // //                 Expanded(
              // //                   child: Padding(
              // //                     padding: const EdgeInsets.all(5.0),
              // //                     child: ElevatedButton(
              // //                       style: ElevatedButton.styleFrom(
              // //                           primary: Colors.green),
              // //                       child: Text("อนุมัติ"),
              // //                       onPressed: () {
              // //                         ModifydataApprove();
              // //                       },
              // //                     ),
              // //                   ),
              // //                 ),
              // //                 Expanded(
              // //                   child: Padding(
              // //                     padding: const EdgeInsets.all(5.0),
              // //                     child: ElevatedButton(
              // //                       style: ElevatedButton.styleFrom(
              // //                           primary: Colors.red),
              // //                       child: Text("ปฏิเสธ"),
              // //                       onPressed: () {
              // //                         ModifydataReject();
              // //                       },
              // //                     ),
              // //                   ),
              // //                 ),
              // //               ],
              // //             ),
              // //           ],
              // //         ),
              // //       ),
              // //     ] else ...[
              // //       Text(""),
              // //     ]
              // //       ]

              //     //   Container(
              //     //     margin: const EdgeInsets.all(2.0),
              //     //     padding: const EdgeInsets.all(2.0),
              //     //     //height: double.infinity,
              //     //     width: 800,
              //     //     decoration: BoxDecoration(
              //     //       borderRadius: BorderRadius.circular(5),
              //     //       border: Border.all(
              //     //         color: Colors.white,
              //     //       ),
              //     //       color: Colors.white,
              //     //       boxShadow: [
              //     //         BoxShadow(
              //     //           blurRadius: 6.0,
              //     //           spreadRadius: 2.0,
              //     //           color: Colors.grey,
              //     //           offset: Offset(0.0, 0.0),
              //     //         )
              //     //       ],
              //     //     ),
              //     //     child: Column(
              //     //       children: <Widget>[
              //     //         Row(
              //     //           children: [
              //     //             Expanded(
              //     //               child: Padding(
              //     //                 padding: const EdgeInsets.all(5.0),
              //     //                 child: ElevatedButton(
              //     //                   style: ElevatedButton.styleFrom(
              //     //                       primary: Colors.green),
              //     //                   child: Text("อนุมัติ"),
              //     //                   onPressed: () {
              //     //                     ModifydataApprove();
              //     //                   },
              //     //                 ),
              //     //               ),
              //     //             ),
              //     //             Expanded(
              //     //               child: Padding(
              //     //                 padding: const EdgeInsets.all(5.0),
              //     //                 child: ElevatedButton(
              //     //                   style: ElevatedButton.styleFrom(
              //     //                       primary: Colors.red),
              //     //                   child: Text("ปฏิเสธ"),
              //     //                   onPressed: () {
              //     //                     ModifydataReject();
              //     //                   },
              //     //                 ),
              //     //               ),
              //     //             ),
              //     //           ],
              //     //         ),
              //     //       ],
              //     //     ),
              //     //   ),
              //     // ] else ...[
              //     //   Text(""),
              //      ]
              //   ]
              //   ),
              SizedBox(
                height: 30,
              ),
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
