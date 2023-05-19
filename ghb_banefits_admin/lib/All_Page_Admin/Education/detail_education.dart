import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ghb_banefits_admin/All_Controllers_Admin/Education_Controller.dart';
import 'package:ghb_banefits_admin/All_Controllers_Admin/master_controllers.dart';
import 'package:ghb_banefits_admin/All_Models_Admin/education_model.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Education/list_education_page.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_education.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_master.dart';
import 'package:ghb_banefits_admin/All_Services_Admin/servics.dart';
import 'package:ghb_banefits_admin/color.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:http/http.dart' as http;

class DetailEducationAdminPage extends StatefulWidget {
  const DetailEducationAdminPage(
      {super.key, required this.Notes, required this.Indexs});

  // Declare a field that holds the Todo.
  final EducationAdmin Notes;
  final int Indexs;

  @override
  State<DetailEducationAdminPage> createState() =>
      _DetailEducationAdminPageState();
}

class _DetailEducationAdminPageState extends State<DetailEducationAdminPage> {
  late String _no;
  late String _empcode;
  late String _name;
  late String _department;
  late String _divisionment;
  late String _typeedu;
  late String _yearedu;
  late String _savedate;
  late String _namechild;
  late String _level;
  late String _school;
  late String _year;
  late String _term;
  late String _educationlevel;
  late String _schooltype;
  late String _receiptnumber;
  late String _volume;
  late String _tel;
  late String _receiptdate;
  late String _amountreceipt;
  late String _email;
  late String _fileUrl;
  late String _filename;
  late String _remarks;

  late Future<EducationAdmin> _futureEducationAdmin;
  Future<EducationAdmin> createEducationAdmin(
      String no,
      String empcode,
      String name,
      String department,
      String divisionment,
      String typeedu,
      String yearedu,
      String savedate,
      String namechild,
      String level,
      String school,
      String year,
      String term,
      String educationlevel,
      String schooltype,
      String receiptnumber,
      String volume,
      String tel,
      String receiptdate,
      String amountreceipt,
      String payamount,
      String paydate,
      String status,
      String email,
      String fileUrl,
      String filename,
      String flagread,
      String id,
      String remarks) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.43/APIBenefit/Education/InsertEducation'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'empcode': empcode,
        'name': name,
        'department': department,
        'divisionment': divisionment,
        'typeedu': typeedu,
        'yearedu': yearedu,
        'savedate': savedate,
        'namechild': namechild,
        'level': level,
        'school': school,
        'year': year,
        'term': term,
        'educationlevel': educationlevel,
        'schooltype': schooltype,
        'receiptnumber': receiptnumber,
        'volume': volume,
        'tel': tel,
        'receiptdate': receiptdate,
        'amountreceipt': amountreceipt,
        'payamount': payamount,
        'paydate': paydate,
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
      return EducationAdmin.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.

      throw Exception('Failed to create.');
    }
  }

  late String _status = "";
  late String _flagread = "";
  late int _Indexs;
  late String _payamount;
  late String _remark = "";
  final _formKey = GlobalKey<FormState>();
  late String _paydate = "";
  late final String _title = "แจ้งผลรายการคำขอช่วยเหลือการศึกษา";
  late String _content;
  final String _createDate =
      DateFormat('dd-MM-yyyy  kk:mm').format(DateTime.now());
  late String _id = "";
  late String _uid;
  late int sumApprove = 0;
  late int sumRequest = 0;
  late int sumReject = 0;
  late int dum = 0;
  EducationAdminController controller =
      EducationAdminController(FirebaseServicesAdmin());
  MasterController mastecontroller = MasterController(FirebaseServicesAdmin());
  void initState() {
    super.initState();
    _getcountnoti(context);
  }

  late int _idcounts = 0;
  void _getcountnoti(BuildContext context) async {
    var _dataEducation = await controller.fetchEducationAdmin();
    var _dataEducationuid =
        _dataEducation.where((x) => x.email == widget.Notes.email);
    print(widget.Notes.email);

    _dataEducationuid.forEach((b) {
      if (b.status == "อนุมัติ") {
        sumApprove += int.parse(b.payamount);
      } else if (b.status == "ร้องขอ") {
        sumRequest += int.parse(b.amountreceipt);
      } else if (b.status == "ปฏิเสธ") {
        sumReject += int.parse(b.amountreceipt);
      }
    });
        print(sumApprove);
    setState(() {

      dum = 40000 - sumApprove ;
          print(dum);
    });
    print(sumApprove);
    setState(() {});
    var newNotification = await mastecontroller.fetchNotiAdmin();
    context.read<NotificationsProviders>().NotificationsAdminList =
        newNotification;
    setState(() {
      _idcounts = newNotification.length + 1;
    });
  }

  void ModifydataApprove() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _Indexs = widget.Indexs.toInt();
      _status = "อนุมัติ";
      _flagread = "1";
      _payamount = _payamount;
      _remark = _remark;
      _paydate = DateFormat('dd-MM-yyyy  kk:mm').format(DateTime.now());
      _no = widget.Notes.no.toString();
      _empcode = widget.Notes.empcode;
      _name = widget.Notes.name;
      _department = widget.Notes.department;
      _divisionment = widget.Notes.divisionment;
      _typeedu = widget.Notes.typeedu;
      _yearedu = widget.Notes.yearedu;
      _savedate = widget.Notes.savedate;
      _namechild = widget.Notes.namechild;
      _level = widget.Notes.level;
      _school = widget.Notes.school;
      _year = widget.Notes.year;
      _term = widget.Notes.term;
      _educationlevel = widget.Notes.educationlevel;
      _schooltype = widget.Notes.schooltype;
      _receiptnumber = widget.Notes.receiptnumber;
      _volume = widget.Notes.volume;
      _tel = widget.Notes.tel;
      _receiptdate = widget.Notes.receiptdate;
      _amountreceipt = widget.Notes.amountreceipt;
      _email = widget.Notes.email;
      _fileUrl = widget.Notes.fileUrl;
      _filename = widget.Notes.filename;
//set insert api
      setState(() {
        _futureEducationAdmin = createEducationAdmin(
            _empcode,
            _name,
            _department,
            _divisionment,
            _typeedu,
            _yearedu,
            _savedate,
            _namechild,
            _level,
            _school,
            _year,
            _term,
            _educationlevel,
            _schooltype,
            _receiptnumber,
            _volume,
            _tel,
            _receiptdate,
            _amountreceipt,
            _payamount,
            _paydate,
            _status,
            _email,
            _fileUrl,
            _filename,
            _flagread,
            _no,
            _id,
            _remark);
      });
      print(_futureEducationAdmin);
      //
      Provider.of<EducationAdminProviders>(context, listen: false)
          .modify(_Indexs, _status, _flagread, _payamount, _paydate, _remark);
      print("done");

      final docStatus = FirebaseFirestore.instance
          .collection('Education')
          .doc(widget.Notes.id);

      docStatus.update({
        'status': _status,
        'flagread': _flagread,
        'payamount': _payamount,
        'paydate': _paydate,
        'remarks': _remark
      });
      _content = "คำขอช่วยเหลือการศึกษา  เลขที่ใบเสร็จ " +
          widget.Notes.receiptnumber +
          "ได้รับการอนุมัติจำนวน " +
          widget.Notes.payamount +
          " บาท";
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
          builder: (context) => ListEducationAdminPage(Status: "ร้องขอ"),
        ),
      );
        },
      ).show();
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => ListEducationAdminPage(Status: "ร้องขอ"),
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

            _no = widget.Notes.no.toString();
      _empcode = widget.Notes.empcode;
      _name = widget.Notes.name;
      _department = widget.Notes.department;
      _divisionment = widget.Notes.divisionment;
      _typeedu = widget.Notes.typeedu;
      _yearedu = widget.Notes.yearedu;
      _savedate = widget.Notes.savedate;
      _namechild = widget.Notes.namechild;
      _level = widget.Notes.level;
      _school = widget.Notes.school;
      _year = widget.Notes.year;
      _term = widget.Notes.term;
      _educationlevel = widget.Notes.educationlevel;
      _schooltype = widget.Notes.schooltype;
      _receiptnumber = widget.Notes.receiptnumber;
      _volume = widget.Notes.volume;
      _tel = widget.Notes.tel;
      _receiptdate = widget.Notes.receiptdate;
      _amountreceipt = widget.Notes.amountreceipt;
      _email = widget.Notes.email;
      _fileUrl = widget.Notes.fileUrl;
      _filename = widget.Notes.filename;
//set insert api
      setState(() {
        _futureEducationAdmin = createEducationAdmin(
            _empcode,
            _name,
            _department,
            _divisionment,
            _typeedu,
            _yearedu,
            _savedate,
            _namechild,
            _level,
            _school,
            _year,
            _term,
            _educationlevel,
            _schooltype,
            _receiptnumber,
            _volume,
            _tel,
            _receiptdate,
            _amountreceipt,
            _payamount,
            _paydate,
            _status,
            _email,
            _fileUrl,
            _filename,
            _flagread,
            _no,
            _id,
            _remark);
      });
      print(_futureEducationAdmin);
      //
      Provider.of<EducationAdminProviders>(context, listen: false)
          .modify(_Indexs, _status, _flagread, _payamount, _paydate, _remark);
      print("done");

      final docStatus = FirebaseFirestore.instance
          .collection('Education')
          .doc(widget.Notes.id);

      docStatus.update({
        'status': _status,
        'flagread': _flagread,
        'paydate': _paydate,
        'remarks': _remark
      });
      _content = "คำขอช่วยเหลือการศึกษา  เลขที่ใบเสร็จ " +
          widget.Notes.receiptnumber +
          "ได้รับการปฏิเสธจำนวน " +
          widget.Notes.amountreceipt +
          " บาท";
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
          builder: (context) => ListEducationAdminPage(Status: "ร้องขอ"),
        ),
      );
        },
      ).show();
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => ListEducationAdminPage(Status: "ร้องขอ"),
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for
    // the major Material Components.
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'รายละเอียดคำขอช่วยเหลือการศึกษา',
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
                      'รายการคำขอเงินช่วยเหลือการศึกษาบุตร',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 9, 28, 235),
                        fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                      ),
                    ),
                    const Divider(),
                    //                     Row(
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
                    SizedBox(height: 10),
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
                            widget.Notes.name,
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
                  ],
                ),
              ),

              ///
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
                      'ข้อมูลคำขอเบิก',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 9, 28, 235),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    /*
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'เลขที่อนุมัติ',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.listdatamedical.numbercodemed,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  */
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'ประเภทคำร้องขอ',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.typeedu,
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
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'วงเงินประจำปี',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.yearedu,
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
              /////////////
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
                      'ข้อมูลการศึกษา',
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
                            'ปีการศึกษา',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.year,
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
                            'ภาคเรียน',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.term,
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
                            'ชื่อสถานศึกษา',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              widget.Notes.school,
                              textAlign: TextAlign.end,
                              style: TextStyle(fontFamily: 'Sarabun',),
                            ),
                            Text(
                              widget.Notes.schooltype,
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
                            'ระดับการศึกษา',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.educationlevel,
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
                            'ระดับชั้น',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.level,
                            textAlign: TextAlign.end,
                            style: TextStyle(fontFamily: 'Sarabun',),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
////
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
                      'ข้อมูลใบเสร็จ',
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
                            'เลขที่ใบเสร็จ',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.receiptnumber,
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
                            'เล่มที่',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.volume,
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
                            'หมายเลขติดต่อกลับ',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.tel,
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
                            'วันที่ใบเสร็จ',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.receiptdate,
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
                      'ข้อมูลจำนวนเงิน',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 9, 28, 235),
                        fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'จำนวนเงินตามใบเสร็จ',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.Notes.amountreceipt,
                              textAlign: TextAlign.end,
                              style: TextStyle(fontFamily: 'Sarabun',),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          if (widget.Notes.status == "ร้องขอ") ...[
                            Expanded(
                              child: Text(
                                'จำนวนเงินจ่าย',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                              ),
                            ),
                            // Expanded(
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(1.0),
                            //     child: TextFormField(
                            //       maxLength: 10,
                            //       //controller: _addressc,
                            //       keyboardType: TextInputType.number,
                            //       decoration: InputDecoration(
                            //         border: OutlineInputBorder(),
                            //         hintText: 'ระบุจำนวนเงินจ่าย',
                            //       ),
                            //       validator: (value) {
                            //         if (value == null || value.isEmpty) {
                            //           return 'โปรดระบุจำนวนเงินจ่าย';
                            //         }
                            //         else if (int.parse(value) > 40000) {
                            //           var dum;
                            //            dum = 40000 - sumApprove;
                            //           print(dum);
                            //           return 'โปรดระบุจำนวนเงินจ่าย';
                            //         }
                            //       },
                            //       onSaved: (newValue) => _payamount = newValue!,
                            //     ),
                            //   ),
                            //   // child: Text(
                            //   //   widget.Notes.payamount,
                            //   //   textAlign: TextAlign.end,
                            //   // ),
                            // ),
                          ] else ...[
                            Expanded(
                              child: Text(
                                'จำนวนเงินจ่าย',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.Notes.payamount,
                                textAlign: TextAlign.end,
                                style: TextStyle(fontFamily: 'Sarabun',),
                              ),
                            ),
                          ]
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          if (widget.Notes.status == "ร้องขอ") ...[
                            // Expanded(
                            //   child: Text(
                            //     'จำนวนเงินจ่าย',
                            //     textAlign: TextAlign.left,
                            //     style: TextStyle(fontWeight: FontWeight.bold),
                            //   ),
                            // ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: TextFormField(
                                  maxLength: 10,
                                  //controller: _addressc,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'ระบุจำนวนเงินจ่าย',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'โปรดระบุจำนวนเงิน';
                                    } 
                                      else if (sumApprove == 0 && int.parse(value) > dum) {
                                      // var dum;
                                      // dum = 40000 - sumApprove;
                                      // print(dum);
                                      // setState(() {
                                      //   dum = dum;
                                      // });
                                      return 'โปรดระบุจำนวนเงินจ่ายไม่เกิน $dum บาท';
                                    }
                                     else if (sumApprove > 0 && int.parse(value) > dum) {
                                      return 'โปรดระบุจำนวนเงินจ่ายไม่เกิน $dum บาท';
                                    }                                        
                                    // else if (int.parse(value) > 40000) {
                                    //   // var dum;
                                    //   dum = 40000 - sumApprove;
                                    //   print(sumApprove);
                                    //   print(dum);
                                    //   setState(() {
                                    //     dum = dum;
                                    //   });
                                    //   return 'โปรดระบุจำนวนเงินจ่ายไม่เกิน $dum บาท';
                                    // } 
                                    else if (int.parse(value) >
                                          int.parse(widget.Notes.amountreceipt)) {
                                      // if (int.parse(value) >
                                      //     int.parse(widget.Notes.amountreceipt))
                             
                                      // {
                                        return 'โปรดระบุจำนวนเงินจ่ายไม่เกินใบเสร็จ';
                                      // }
                                    //   if(sumApprove != 0 || int.parse(value)> 0)
                                    //   return 'โปรดระบุจำนวนเงินจ่ายไม่เกิน $dum บาท';
                                    }
                                  },
                                  onSaved: (newValue) => _payamount = newValue!,
                                ),
                              ),
                              // child: Text(
                              //   widget.Notes.payamount,
                              //   textAlign: TextAlign.end,
                              // ),
                            ),
                          ] else ...[
                            Expanded(
                              child: Text(
                                'จำนวนเงินจ่าย',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.Notes.payamount,
                                textAlign: TextAlign.end,
                                style: TextStyle(fontFamily: 'Sarabun',),
                              ),
                            ),
                          ]
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Row(
                    //     children: [
                    //       if (widget.Notes.status == "ร้องขอ") ...[
                    //         Expanded(
                    //           child: Text(
                    //             'จำนวนเงินจ่าย',
                    //             textAlign: TextAlign.left,
                    //             style: TextStyle(fontWeight: FontWeight.bold),
                    //           ),
                    //         ),
                    //         Expanded(
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(1.0),
                    //             child: TextFormField(
                    //               maxLength: 10,
                    //               //controller: _addressc,
                    //               keyboardType: TextInputType.number,
                    //               decoration: InputDecoration(
                    //                 border: OutlineInputBorder(),
                    //                 hintText: 'ระบุจำนวนเงินจ่าย',
                    //               ),
                    //               validator: (value) {
                    //                 if (value == null || value.isEmpty) {
                    //                   return 'โปรดระบุจำนวนเงินจ่าย';
                    //                 }
                    //               },
                    //               onSaved: (newValue) => _payamount = newValue!,
                    //             ),
                    //           ),
                    //           // child: Text(
                    //           //   widget.Notes.payamount,
                    //           //   textAlign: TextAlign.end,
                    //           // ),
                    //         ),
                    //       ] else ...[
                    //         Expanded(
                    //           child: Text(
                    //             'จำนวนเงินจ่าย',
                    //             textAlign: TextAlign.left,
                    //             style: TextStyle(fontWeight: FontWeight.bold),
                    //           ),
                    //         ),
                    //         Expanded(
                    //           child: Text(
                    //             widget.Notes.payamount,
                    //             textAlign: TextAlign.end,
                    //           ),
                    //         ),
                    //       ]
                    //     ],
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         child: Text(
                    //           'วันที่ทำรายการ',
                    //           textAlign: TextAlign.left,
                    //           style: TextStyle(fontWeight: FontWeight.bold),
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: Text(
                    //           DateFormat.yMd().add_jm().format(DateTime.now()),
                    //           textAlign: TextAlign.end,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
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
                        fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text(widget.Notes.filename.toString(),style: TextStyle(fontFamily: 'Sarabun',),),
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
                    //                                 Card(
                    //                   child: ListTile(
                    //                     title: Text("Test PDF"),
                    //                     trailing: Icon(Icons.remove_red_eye),
                    //                     onTap: () async {

                    //                       final path = 'assets/731962.pdf';
                    //                       final file = await PDFApi.loadAsset(path);
                    //                       openPDF(context, file);

                    //                /*     Navigator.push(
                    //               context,
                    //               MaterialPageRoute(
                    //                 builder: (context) => ViewPDFPage(file:file)) ,
                    // );*/

                    //                     },
                    //                   ),
                    //                 ),
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
              ]),
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
