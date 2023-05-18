//import 'dart:developer';
import 'dart:convert';
import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ghb_banefits_admin/All_Controllers_Admin/master_controllers.dart';
import 'package:ghb_banefits_admin/All_Models_Admin/house_model.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/House_Allowance/list_house_allowance.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_house.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_master.dart';
import 'package:ghb_banefits_admin/All_Services_Admin/servics.dart';
import 'package:ghb_banefits_admin/color.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:http/http.dart' as http;
//import 'package:flutter/widgets.dart';

class DetailHouseAdminPage extends StatefulWidget {
  const DetailHouseAdminPage(
      {super.key, required this.Notes, required this.Indexs});

  // Declare a field that holds the Todo.
  final HouseAllowanceAdmin Notes;
  final int Indexs;

  @override
  State<DetailHouseAdminPage> createState() => _DetailHouseAdminPageState();
}

class _DetailHouseAdminPageState extends State<DetailHouseAdminPage> {
  late String _no;
  late String _empcode;
  late String _name;
  late String _department;
  late String _divisionment;
  late String _savedate;
  late String _startdate;
  late String _position;
  late String _segment;
  late String _departmentwork;
  late String _provincework;
  late String _positiondate;
  late String _typehouse;
  late String _moneyhouse;
  late String _housenumber;
  late String _alley;
  late String _road;
  late String _district;
  late String _county;
  late String _province;
  late String _workstatus;
  late String _email;
  late String _fileUrl;
  late String _filename;
  late String _remarks;

  late Future<HouseAllowanceAdmin> _futureHouseAllowanceAdmin;
  Future<HouseAllowanceAdmin> createHouseAllowanceAdmin(
      String no,
      String empcode,
      String name,
      String department,
      String divisionment,
      String savedate,
      String startdate,
      String position,
      String segment,
      String departmentwork,
      String provincework,
      String positiondate,
      String typehouse,
      String moneyhouse,
      String housenumber,
      String alley,
      String road,
      String district,
      String county,
      String province,
      String workstatus,
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
      Uri.parse(
          'http://192.168.1.43/APIBenefit/HouseAllowance/InsertHouseAllowance'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'empcode': empcode,
        'name': name,
        'department': department,
        'divisionment': divisionment,
        'savedate': savedate,
        'startdate': startdate,
        'position': position,
        'segment': segment,
        'departmentwork': departmentwork,
        'provincework': provincework,
        'positiondate': positiondate,
        'typehouse': typehouse,
        'housenumber': housenumber,
        'alley': alley,
        'road': road,
        'district': district,
        'county': county,
        'province': province,
        'workstatus': workstatus,
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
      return HouseAllowanceAdmin.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.

      throw Exception('Failed to create.');
    }
  }

  late String _status = "";
  late String _flagread;
  late int _Indexs;
  late String _payamount = "";
  late String _remark = "";
  final _formKey = GlobalKey<FormState>();
  late String _paydate = "";
  late final String _title = "แจ้งผลรายการคำคำขอค่าเช่าบ้านของพนักงาน";
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
      _no = widget.Notes.no.toString();
      _empcode = widget.Notes.empcode;
      _name = widget.Notes.name;
      _department = widget.Notes.department;
      _divisionment = widget.Notes.departmentwork;
      _savedate = widget.Notes.savedate;
      _startdate = widget.Notes.startdate;
      _position = widget.Notes.position;
      _segment = widget.Notes.segment;
      _departmentwork = widget.Notes.departmentwork;
      _provincework = widget.Notes.provincework;
      _positiondate = widget.Notes.positiondate;
      _typehouse = widget.Notes.typehouse;
      _moneyhouse = widget.Notes.moneyhouse;
      _housenumber = widget.Notes.housenumber;
      _alley = widget.Notes.alley;
      _road = widget.Notes.road;
      _district = widget.Notes.district;
      _county = widget.Notes.county;
      _province = widget.Notes.province;
      _workstatus = widget.Notes.workstatus;
      _email = widget.Notes.email;
      _fileUrl = widget.Notes.fileUrl;
      _filename = widget.Notes.filename;

      _id = widget.Notes.id;
//set insert api
      setState(() {
        _futureHouseAllowanceAdmin = createHouseAllowanceAdmin(
            _empcode,
            _name,
            _department,
            _divisionment,
            _savedate,
            _startdate,
            _position,
            _segment,
            _departmentwork,
            _provincework,
            _positiondate,
            _typehouse,
            _moneyhouse,
            _housenumber,
            _alley,
            _road,
            _district,
            _county,
            _province,
            _workstatus,
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
      print(_futureHouseAllowanceAdmin);
      //

      Provider.of<HouseAllowanceAdminProviders>(context, listen: false)
          .modify(_Indexs, _status, _flagread, _payamount, _paydate, _remark);
      print("done");

      final docStatus = FirebaseFirestore.instance
          .collection('HouseAllowance')
          .doc(widget.Notes.id);

      docStatus.update({
        'status': _status,
        'flagread': _flagread,
        'payamount': _payamount,
        'paydate': _paydate,
        'remarks': _remark
      });
      _content = "คำขอค่าเช่าบ้านของพนักงาน " +
          " ได้รับการอนุมัติจำนวน " +
          widget.Notes.moneyhouse +
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
          builder: (context) => ListHouseAllowanceAdminPage(Status: "ร้องขอ"),
        ),
      );
        },
      ).show();
      // Navigator.pop(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => ListHouseAllowanceAdminPage(Status: "ร้องขอ"),
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
      _divisionment = widget.Notes.departmentwork;
      _savedate = widget.Notes.savedate;
      _startdate = widget.Notes.startdate;
      _position = widget.Notes.position;
      _segment = widget.Notes.segment;
      _departmentwork = widget.Notes.departmentwork;
      _provincework = widget.Notes.provincework;
      _positiondate = widget.Notes.positiondate;
      _typehouse = widget.Notes.typehouse;
      _moneyhouse = widget.Notes.moneyhouse;
      _housenumber = widget.Notes.housenumber;
      _alley = widget.Notes.alley;
      _road = widget.Notes.road;
      _district = widget.Notes.district;
      _county = widget.Notes.county;
      _province = widget.Notes.province;
      _workstatus = widget.Notes.workstatus;
      _email = widget.Notes.email;
      _fileUrl = widget.Notes.fileUrl;
      _filename = widget.Notes.filename;

      _id = widget.Notes.id;
//set insert api
      setState(() {
        _futureHouseAllowanceAdmin = createHouseAllowanceAdmin(
            _empcode,
            _name,
            _department,
            _divisionment,
            _savedate,
            _startdate,
            _position,
            _segment,
            _departmentwork,
            _provincework,
            _positiondate,
            _typehouse,
            _moneyhouse,
            _housenumber,
            _alley,
            _road,
            _district,
            _county,
            _province,
            _workstatus,
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
      print(_futureHouseAllowanceAdmin);
      //     
      Provider.of<HouseAllowanceAdminProviders>(context, listen: false)
          .modify(_Indexs, _status, _flagread, _payamount, _paydate, _remark);
      print("done");

      final docStatus = FirebaseFirestore.instance
          .collection('HouseAllowance')
          .doc(widget.Notes.id);

      docStatus.update({
        'status': _status,
        'flagread': _flagread,
        'payamount': _payamount,
        'paydate': _paydate,
        'remarks': _remark
      });
      _content = "คำขอค่าเช่าบ้านของพนักงาน " +
          " ได้รับการปฏิเสธจำนวน " +
          widget.Notes.moneyhouse +
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
          builder: (context) => ListHouseAllowanceAdminPage(Status: "ร้องขอ"),
        ),
      );
        },
      ).show();
      // Navigator.pop(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => ListHouseAllowanceAdminPage(Status: "ร้องขอ"),
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'รายละเอียดคำขอค่าเช่าบ้านของพนักงาน',
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
                      'รายการคำขอเบิกค่าเช่าบ้านสำหรับพนักงาน',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 9, 28, 235),
                        fontWeight: FontWeight.bold,
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
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'วันที่เข้างาน',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.startdate,
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
                      'ข้อมูลตำสั่งให้ไปดำรงตำแหน่ง',
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
                            'ตำแหน่ง',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.position,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'ส่วนงาน/สาขา',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.segment,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'ฝ่าย/สำนัก',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.departmentwork,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'จังหวัด',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.provincework,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'วันที่ดำรงตำแหน่ง',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.positiondate,
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
                      'ข้อมูลการค่าเช่าบ้าน',
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
                            'ประเภทการเช่าบ้าน',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.typehouse,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'จำนวนเงินค่าเช่าบ้าน',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.moneyhouse,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'บ้านเลขที่',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.housenumber,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'ตรอก/ซอย',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.alley,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'ถนน',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.road,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'ตำบล/แขวง',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.district,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'อำเภอ/เขต',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.county,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'จังหวัด',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.province,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'เพื่อใช้พักอาศับปฏิบัติงาน',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.workstatus,
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
