import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ghb_banefits_admin/All_Controllers_Admin/Medical_Controller.dart';
import 'package:ghb_banefits_admin/All_Controllers_Admin/master_controllers.dart';
import 'package:ghb_banefits_admin/All_Models_Admin/medical_model.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Medical/list_medical_page.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_child_allowance.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_master.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_medical.dart';
import 'package:ghb_banefits_admin/All_Services_Admin/servics.dart';
import 'package:ghb_banefits_admin/color.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class DetailMedicalAdminPage extends StatefulWidget {
  const DetailMedicalAdminPage(
      {super.key, required this.Notes, required this.Indexs});

  // Declare a field that holds the Todo.
  final MedicalAdmin Notes;
  final int Indexs;

  @override
  State<DetailMedicalAdminPage> createState() => _DetailMedicalAdminPageState();
}

class _DetailMedicalAdminPageState extends State<DetailMedicalAdminPage> {
  late String _no;
  late String _empcode;
  late String _name;
  late String _department;
  late String _divisionment;
  late String _numbercodemed;
  late String _savedate;
  late String _typemed;
  late String _yearmed;
  late String _hospitalname;
  late String _hospitaltype;
  late String _claimstartdate;
  late String _claimenddate;
  late String _idreceiptnumber;
  late String _receiptnumber;
  late String _tel;
  late String _namedisease;
  late String _diseasegroup;
  late String _receiptamount;
  late String _email;
  late String _fileUrl;
  late String _filename;
  late String _remarks;

  late Future<MedicalAdmin> _futureMedicalAdmin;
  Future<MedicalAdmin> createMedicalAdmin(
    String no,
    String empcode,
    String name,
    String department,
    String divisionment,
    String numbercodemed,
    String savedate,
    String typemed,
    String yearmed,
    String hospitalname,
    String hospitaltype,
    String claimstartdate,
    String claimenddate,
    String idreceiptnumber,
    String receiptnumber,
    String tel,
    String namedisease,
    String diseasegroup,
    String receiptamount,
    String payamount,
    String paydate,
    String status,
    String email,
    String fileUrl,
    String filename,
    String flagread,
    String id,
    String remarks,
  ) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.43/APIBenefit/Medical/InsertMedical'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'empcode': empcode,
        'name': name,
        'department': department,
        'divisionment': divisionment,
        'numbercodemed': numbercodemed,
        'savedate': savedate,
        'typemed': typemed,
        'yearmed': yearmed,
        'hospitalname': hospitalname,
        'hospitaltype': hospitaltype,
        'claimstartdate': claimstartdate,
        'claimenddate': claimenddate,
        'idreceiptnumber': idreceiptnumber,
        'receiptnumber': receiptnumber,
        'tel': tel,
        'namedisease': namedisease,
        'diseasegroup': diseasegroup,
        'receiptamount': receiptamount,
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
      return MedicalAdmin.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.

      throw Exception('Failed to create.');
    }
  }

  late String _status = "";
  late String _flagread = "";
  late int _Indexs;
  late String _payamount = "";
  late String _remark = "";
  final _formKey = GlobalKey<FormState>();
  late String _paydate = "";
  late final String _title = "แจ้งผลรายการคำขอเบิกค่ารักษาพยาบาล";
  late String _content;
  final String _createDate =
      DateFormat('dd-MM-yyyy  kk:mm').format(DateTime.now());
  late String _id = "";
  late String _uid;
  late int sumApprove = 0;
  late int sumRequest = 0;
  late int sumReject = 0;
  late int dum = 0;
  MasterController mastecontroller = MasterController(FirebaseServicesAdmin());
  MedicalAdminController controller =
      MedicalAdminController(FirebaseServicesAdmin());

  void initState() {
    super.initState();
    _getcountnoti(context);
  }

  late int _idcounts = 0;
  void _getcountnoti(BuildContext context) async {
    var _dataMedical = await controller.fetchMedicalAdmin();
    var _dataMedicaluid =
        _dataMedical.where((x) => x.email == widget.Notes.email);
    print(widget.Notes.email);

    _dataMedicaluid.forEach((b) {
      if (b.status == "อนุมัติ") {
        sumApprove += int.parse(b.payamount);
      } else if (b.status == "ร้องขอ") {
        sumRequest += int.parse(b.receiptamount);
      } else if (b.status == "ปฏิเสธ") {
        sumReject += int.parse(b.receiptamount);
      }
    });
    print(sumApprove);
    setState(() {

      dum = 40000 - sumApprove ;
          print(dum);
    });
    // print(_dataMedical.length);
    // // if(_dataMedical.length > 0){
    // //             setState(() {
    // //   data = _dataMedical;
    // //   filteredData = _dataMedical;
    // //   // print(filteredData);
    // // });
    // context.read<MedicalAdminProviders>().MedicalAdminList = _dataMedical;
    // }
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
      _numbercodemed = widget.Notes.numbercodemed;
      _savedate = widget.Notes.savedate;
      _typemed = widget.Notes.typemed;
      _yearmed = widget.Notes.yearmed;
      _hospitalname = widget.Notes.hospitalname;
      _hospitaltype = widget.Notes.hospitaltype;
      _claimstartdate = widget.Notes.claimstartdate;
      _claimenddate = widget.Notes.claimenddate;
      _idreceiptnumber = widget.Notes.idreceiptnumber;
      _receiptnumber = widget.Notes.receiptnumber;
      _tel = widget.Notes.tel;
      _namedisease = widget.Notes.namedisease;
      _diseasegroup = widget.Notes.diseasegroup;
      _receiptamount = widget.Notes.receiptamount;

      _email = widget.Notes.email;
      _fileUrl = widget.Notes.fileUrl;
      _filename = widget.Notes.filename;
      _id = widget.Notes.id;
//set insert api
      setState(() {
        _futureMedicalAdmin = createMedicalAdmin(
            _empcode,
            _name,
            _department,
            _divisionment,
            _numbercodemed,
            _savedate,
            _typemed,
            _yearmed,
            _hospitalname,
            _hospitaltype,
            _claimstartdate,
            _claimenddate,
            _idreceiptnumber,
            _receiptnumber,
            _tel,
            _namedisease,
            _diseasegroup,
            _receiptamount,
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
      print(_futureMedicalAdmin);
      //
      print(_status);
      Provider.of<MedicalAdminProviders>(context, listen: false)
          .modify(_Indexs, _status, _flagread, _payamount, _paydate, _remark);
      print("done");

      final docStatus =
          FirebaseFirestore.instance.collection('Medical').doc(widget.Notes.id);

      docStatus.update({
        'status': _status,
        'flagread': _flagread,
        'payamount': _payamount,
        'paydate': _paydate,
        'remarks': _remark
      });
      _content = "คำขอเบิกค่ารักษาพยาบาล  เลขที่ใบเสร็จ " +
          widget.Notes.idreceiptnumber +
          " ได้รับการอนุมัติจำนวน " +
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
        btnOkText: "ตกลง",
        title: "สำเร็จ",
        desc: "ดำเนินการบันทึกข้อมูลสำเร็จ",
        btnOkOnPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListMedicalAdminPage(Status: "ร้องขอ"),
            ),
          );
        },
      ).show();

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => ListMedicalAdminPage(Status:"ร้องขอ"),
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
      _payamount = _payamount;
      _remark = _remark;
      _paydate = DateFormat('dd-MM-yyyy  kk:mm').format(DateTime.now());
      
      _no = widget.Notes.no.toString();
      _empcode = widget.Notes.empcode;
      _name = widget.Notes.name;
      _department = widget.Notes.department;
      _divisionment = widget.Notes.divisionment;
      _numbercodemed = widget.Notes.numbercodemed;
      _savedate = widget.Notes.savedate;
      _typemed = widget.Notes.typemed;
      _yearmed = widget.Notes.yearmed;
      _hospitalname = widget.Notes.hospitalname;
      _hospitaltype = widget.Notes.hospitaltype;
      _claimstartdate = widget.Notes.claimstartdate;
      _claimenddate = widget.Notes.claimenddate;
      _idreceiptnumber = widget.Notes.idreceiptnumber;
      _receiptnumber = widget.Notes.receiptnumber;
      _tel = widget.Notes.tel;
      _namedisease = widget.Notes.namedisease;
      _diseasegroup = widget.Notes.diseasegroup;
      _receiptamount = widget.Notes.receiptamount;

      _email = widget.Notes.email;
      _fileUrl = widget.Notes.fileUrl;
      _filename = widget.Notes.filename;
      _id = widget.Notes.id;
//set insert api
      setState(() {
        _futureMedicalAdmin = createMedicalAdmin(
            _empcode,
            _name,
            _department,
            _divisionment,
            _numbercodemed,
            _savedate,
            _typemed,
            _yearmed,
            _hospitalname,
            _hospitaltype,
            _claimstartdate,
            _claimenddate,
            _idreceiptnumber,
            _receiptnumber,
            _tel,
            _namedisease,
            _diseasegroup,
            _receiptamount,
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
      print(_futureMedicalAdmin);
      //
      print(_status);
      Provider.of<MedicalAdminProviders>(context, listen: false)
          .modify(_Indexs, _status, _flagread, _payamount, _paydate, _remark);
      print("done");

      final docStatus =
          FirebaseFirestore.instance.collection('Medical').doc(widget.Notes.id);

      docStatus.update({
        'status': _status,
        'flagread': _flagread,
        'payamount': _payamount,
        'paydate': _paydate,
        'remarks': _remark
      });
      _content = "คำขอเบิกค่ารักษาพยาบาล  เลขที่ใบเสร็จ " +
          widget.Notes.idreceiptnumber +
          " ได้รับการปฏิเสธจำนวน " +
          widget.Notes.receiptamount +
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
        btnOkText: "ตกลง",
        title: "สำเร็จ",
        desc: "ดำเนินการบันทึกข้อมูลสำเร็จ",
        btnOkOnPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListMedicalAdminPage(Status: "ร้องขอ"),
            ),
          );
        },
      ).show();
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => ListMedicalAdminPage(Status:"ร้องขอ"),
      //   ),
      // );
    }
  }

  // void ModifydataReject() async {
  //    if (_formKey.currentState!.validate()) {
  //    _formKey.currentState!.save();
  //   _Indexs = widget.Indexs.toInt();
  //   _status = "ปฏิเสธ";
  //   _flagread = "1";
  //   _payamount = "0";
  //   _paydate = DateFormat('dd-MM-yyyy  kk:mm').format(DateTime.now());
  //   _remark = _remark;
  //         print(_status);
  //               print(_payamount);
  //   Provider.of<MedicalAdminProviders>(context, listen: false)
  //       .modify(_Indexs, _status, _flagread, _payamount, _paydate, _remark);
  //   print("done");

  //   final docStatus =
  //       FirebaseFirestore.instance.collection('Medical').doc(widget.Notes.id);

  //   docStatus.update({
  //     'status': _status,
  //     'flagread': _flagread,
  //     'payamount': _payamount,
  //     'paydate': _paydate,
  //     'remarks': _remark
  //   });
  //   _content = "คำขอเบิกค่ารักษาพยาบาล  เลขที่ใบเสร็จ " +
  //       widget.Notes.idreceiptnumber +
  //       " ได้รับการปฏิเสธจำนวน " +
  //       widget.Notes.receiptamount +
  //       " บาท";
  //   _uid = widget.Notes.email;
  //   CollectionReference Notifications =
  //       FirebaseFirestore.instance.collection('Notifications');
  //   DocumentReference doc = await Notifications.add({
  //     'no': _idcounts,
  //     'title': _title,
  //     'content': _content,
  //     'read': 0,
  //     'createDate': _createDate,
  //     'uid': _uid,
  //     'id': _id,
  //     'remarks': _remark
  //   });
  //   doc.update({
  //     'id': doc.id,
  //   });

  //   Navigator.pop(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => ListMedicalAdminPage(Status: "ร้องขอ"),
  //     ),
  //   );
  //     }
  // }

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for
    // the major Material Components.
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'รายละเอียดคำขอเบิกค่ารักษาพยาบาล',
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
                      'รายการคำขอเงินช่วยเหลือค่ารักษาพยาบาล',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 9, 28, 235),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Sarabun',
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
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.status,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontFamily: 'Sarabun',
                            ),
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
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Sarabun',
                      ),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'พนักงาน',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sarabun',
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.name,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontFamily: 'Sarabun',
                            ),
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
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sarabun',
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              widget.Notes.department,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontFamily: 'Sarabun',
                              ),
                            ),
                            Text(
                              widget.Notes.divisionment,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontFamily: 'Sarabun',
                              ),
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
                        fontFamily: 'Sarabun',
                      ),
                    ),
                    const Divider(),

                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Text(
                    //         'ประเภทคำร้องขอ',
                    //         textAlign: TextAlign.left,
                    //         style: TextStyle(fontWeight: FontWeight.bold),
                    //       ),
                    //     ),
                    //     Expanded(
                    //       child: Text(
                    //         widget.Notes.typemed,
                    //         textAlign: TextAlign.end,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'วันที่บันทึก',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sarabun',
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.savedate,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontFamily: 'Sarabun',
                            ),
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
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sarabun',
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.yearmed,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontFamily: 'Sarabun',
                            ),
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
                      'ข้อมูลโรงพยาบาล',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 9, 28, 235),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Sarabun',
                      ),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'ชื่อโรงพยาบาล',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sarabun',
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              widget.Notes.hospitalname,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontFamily: 'Sarabun',
                              ),
                            ),
                            Text(
                              widget.Notes.hospitaltype,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontFamily: 'Sarabun',
                              ),
                            ),
                          ],
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
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Sarabun',
                      ),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'เลขที่ใบเสร็จ',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sarabun',
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.idreceiptnumber,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontFamily: 'Sarabun',
                            ),
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
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sarabun',
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.receiptnumber,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontFamily: 'Sarabun',
                            ),
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
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sarabun',
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.tel,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontFamily: 'Sarabun',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'วันที่เริ่มต้นการรักษา',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sarabun',
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.claimstartdate,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontFamily: 'Sarabun',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'วันที่สิ้นสุดการรักษา',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sarabun',
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.claimenddate,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontFamily: 'Sarabun',
                            ),
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
                      'รายการโรค/กลุ่มโรค',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 9, 28, 235),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Sarabun',
                      ),
                    ),
                    const Divider(),
                    /*
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'รหัสโรค',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.listdatamedical.diseasecode,
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
                            'ชื่อโรค',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sarabun',
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.namedisease,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontFamily: 'Sarabun',
                            ),
                          ),
                        ),
                      ],
                    ),
                    /*
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'กลุ่มโรค',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.listdatamedical.diseasegroup,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  */
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
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Sarabun',
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
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Sarabun',
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.Notes.receiptamount,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontFamily: 'Sarabun',
                              ),
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
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Sarabun',
                                ),
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
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Sarabun',
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.Notes.payamount,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontFamily: 'Sarabun',
                                ),
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
                                    else if (int.parse(value) > dum) {
                                      if (int.parse(value) >
                                          int.parse(widget.Notes.receiptamount))
                             
                                      {
                                        return 'โปรดระบุจำนวนเงินจ่ายไม่เกินใบเสร็จ';
                                      }
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
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Sarabun',
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.Notes.payamount,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontFamily: 'Sarabun',
                                ),
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
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Sarabun',
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
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Sarabun',
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.Notes.remarks,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontFamily: 'Sarabun',
                                ),
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
                        fontFamily: 'Sarabun',
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text(
                        widget.Notes.filename.toString(),
                        style: TextStyle(
                          fontFamily: 'Sarabun',
                        ),
                      ),
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
                                  child: Text(
                                    "อนุมัติ",
                                    style: TextStyle(
                                      fontFamily: 'Sarabun',
                                    ),
                                  ),
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
                                  child: Text(
                                    "ปฏิเสธ",
                                    style: TextStyle(
                                      fontFamily: 'Sarabun',
                                    ),
                                  ),
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
////end
            ],
          ),
        ),
      ),
    );
  }
}

// class View extends StatelessWidget {
//   PdfViewerController? _pdfViewerController;
//   final url;
//    View({this.url});

//  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('รายละเอียดเอกสาร',style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
//                             color: iWhiteColor,
//                           ),),
//       backgroundColor: iOrangeColor,
// ),

//       body: SfPdfViewer.network(
//         url,
//         controller: _pdfViewerController,
//       ),
//     );
//   }
// }

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
