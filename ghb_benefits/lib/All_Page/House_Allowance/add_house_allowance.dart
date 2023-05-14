import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ghb_benefits/All_Controllers/House_controllers.dart';
import 'package:ghb_benefits/All_Controllers/master_controllers.dart';
import 'package:ghb_benefits/All_Page/House_Allowance/list_house_allowance.dart';
import 'package:ghb_benefits/All_Providers/provider_house.dart';
import 'package:ghb_benefits/All_Providers/provider_master.dart';
import 'package:ghb_benefits/All_Services/servics.dart';
import 'package:ghb_benefits/color.dart';


import 'package:ghb_benefits/pdf/files_page.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class AddHouseAllowancePage extends StatefulWidget {
  const AddHouseAllowancePage({Key? key}) : super(key: key);

  @override
  State<AddHouseAllowancePage> createState() => _AddHouseAllowancePageState();
}

class _AddHouseAllowancePageState extends State<AddHouseAllowancePage> {
  _AddHouseAllowancePageState() {
    _selectedVal = _childName[0];
    _selectedpartner = _childpartner[0];
    _selectedstatuspartner = _childstatuspartner[0];
  }

   MasterController mastecontroller = MasterController(FirebaseServices()); 
   HouseAllowanceController controller =
      HouseAllowanceController(FirebaseServices());
      

      void initState() {
        super.initState();
        _getHouseAllowanceeadd(context);
      }
  late  int _idcounts = 0;
   void   _getHouseAllowanceeadd(BuildContext context) async {
      var newEmployee = await mastecontroller.fetchEmployee();

         context.read<filedEmployeeProviders>().Empno = newEmployee.first.no;
     context.read<filedEmployeeProviders>().Empempcode = newEmployee.first.empcode;
     context.read<filedEmployeeProviders>().Empnameemp = newEmployee.first.nameemp;
     context.read<filedEmployeeProviders>().Empdepartment = newEmployee.first.department;
     context.read<filedEmployeeProviders>().Empdivisionment = newEmployee.first.divisionment;
     context.read<filedEmployeeProviders>().Empdate = newEmployee.first.date;   
     context.read<filedEmployeeProviders>().Empuid = newEmployee.first.uid;    


    setState(() {
      _empcode = newEmployee.first.empcode;
      _name = newEmployee.first.nameemp;
      _department = newEmployee.first.department;
      _divisionment = newEmployee.first.divisionment;
      _startdate =  newEmployee.first.date;
      
    });
    context.read<EmployeeProviders>().EmployeeList = newEmployee;
            var newhouse = await controller.fetchHouseAllowance();

                                setState(() {
             _idcounts = newhouse.length + 1;
            });
      }



  final _childName = ["เลือกประเภทการเช่าบ้าน", "เช่าบ้าน", "เช่าซื้อ"];
  String? _selectedVal = "";
  final _childpartner = ["เลือกสถานะ", "ประจำ", "ชั่วคราว"];
  String? _selectedpartner = "";

  final _childstatuspartner = ["เลือกสถานะ", "จดทะเบียน", "ไม่จดทะเบียน"];
  String? _selectedstatuspartner = "";

  final _formKey = GlobalKey<FormState>();
  TextEditingController _date = TextEditingController();
  TextEditingController _dates = TextEditingController();

  bool visibilityTag = false;

  void _changed(bool visibility, String field) {
    setState(() {
      if (field == "สมรส") {
        visibilityTag = visibility;
      }
    });
  }

  final user = FirebaseAuth.instance.currentUser!;
  late int _no;
  late String _empcode = "";
  late String _name = "";
  late String _department = "";
  late String _divisionment = "";
  late String _savedate;
  late String _startdate = "";
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
  late String _payamount;
  late String _paydate;
  late String _status;
  late String _email;
  late String _url;
  late String _filename = "";
  late String _flagread;
  late String _id;
    late String _remarks = "";
  void AddHouseAllowance() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _no = _idcounts;
      _empcode = _empcode;
      _name = _name;
      _department = _department;
      _divisionment = _divisionment;
      _savedate = DateFormat('dd-MM-yyyy  kk:mm').format(DateTime.now());
      _startdate =_startdate;
      _position;
      _segment;
      _departmentwork;
      _provincework;
      _positiondate;
      _typehouse = _selectedVal!;
      _moneyhouse;
      _housenumber;
      _alley;
      _road;
      _district;
      _county;
      _province;
      _workstatus  = _selectedpartner!;
      _payamount= "0";
      _paydate= "";    
      _status = "ร้องขอ";
      _email = user.uid;
      _url = _url;
      _filename = _filename;
      _flagread = "0";
      _id = "";
            _remarks = _remarks;

      Provider.of<HouseAllowanceProviders>(context, listen: false)
      .addHouseAllowance(
      _idcounts,
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
                    _url,
              _filename,
              _flagread,
              _id,         
                   _remarks);
      //final docStatus = FirebaseFirestore.instance.collection('ChildAllowance');
      CollectionReference HouseAllowance =
          FirebaseFirestore.instance.collection('HouseAllowance');
      DocumentReference doc = await HouseAllowance.add({
        'no': _idcounts,
        'empcode': _empcode,
        'name': _name,
        'department': _department,
        'divisionment': _divisionment,
        'savedate': _savedate,
        'startdate': _startdate,
        'position': _position,
        'segment': _segment,
        'departmentwork': _departmentwork,
        'provincework': _provincework,
        'positiondate': _positiondate,
        'typehouse': _typehouse,
        'moneyhouse': _moneyhouse,
        'housenumber': _housenumber,
        'alley': _alley,
        'road': _road,
        'district': _district,
        'county': _county,
        'province': _province,
        'workstatus': _workstatus,
        'payamount': _payamount,
        'paydate': _paydate,
        'status': _status,
        'email': _email,
                'fileUrl': _url,
        'filename': _filename,
        'flagread': _flagread,
        'id': _id,
                 'remarks': _remarks
      });
      doc.update({
        'id': doc.id,

        //'id' : result,
      });

      //Provider.of<ChildAllowaneProviders>(context,listen: false).addNotes(_Title.text, _Description.text);
    // context.read<flieHouseAllowanceModal>().flieHouseAllowanceChoice = '';
      //Navigator.of(context).pop();
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        showCloseIcon: true,
        title: "สำเร็จ",
        desc: "ดำเนินการบันทึกข้อมูลสำเร็จ",
        btnOkOnPress: () {
          Navigator.pop(
            context,
            MaterialPageRoute(
              builder: (context) => ListHouseAllowanceePage(),
            ),
          );
        },
      ).show();

      // Navigator.pop(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => ListHouseAllowanceePage(),
      //   ),
      // );
    }
  }

   String url = "";
  uploadDataToFirebase() async {
    FilePickerResult? resulta = await FilePicker.platform.pickFiles();
    File pick = File(resulta!.files.single.path.toString());
    var file = pick.readAsBytesSync();

    PlatformFile filedetail = resulta.files.first;

    var filename = filedetail.name;

    String name = DateTime.now().microsecondsSinceEpoch.toString();
    var pdfFile = FirebaseStorage.instance
        .ref()
        .child(name)
        .child("/" + filename.toString() + ".pdf");
    UploadTask task = pdfFile.putData(file);
    TaskSnapshot snapshot = await task;
    url = await snapshot.ref.getDownloadURL();
    //_url = url;
    // print(_url);
    setState(() {
      _filename = filename;

      _url = url;
      // print(_url);
    });
    context.read<flieHouseAllowanceModal>().flieHouseAllowanceChoice = filename;

    // await FirebaseFirestore.instance
    // .collection("file")
    // .doc()
    // .set({'fileUrl':url,'num' : "file FDF" + filename.toString()});
    // //.set({'fileUrl':url,'num' : "file FDF" + number.toString()});
  }
void deleteflie()async{
  Provider.of<flieHouseAllowanceModal>(context, listen: false)
          .deleteflie();

    setState(() {
      _filename  = "";
    });
}
  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for
    // the major Material Components.
    return Scaffold(
      appBar: AppBar(
      title: Text('สร้างคำขอค่าเช่าบ้านของพนักงาน',style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                            color: iWhiteColor,
                          ),),
      backgroundColor: iBlueColor,
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
                      'สร้างคำขอเบิกค่าเช่าบ้านสำหรับพนักงาน',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 9, 28, 235),
                        fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                      ),
                    ),
                    const Divider(),
                    //   Row(
                    //   children: [
                    //     Expanded(
                    //       child: Text(
                    //         'เลขที่',
                    //         textAlign: TextAlign.left,
                    //         style: TextStyle(fontWeight: FontWeight.bold),
                    //       ),
                    //     ),
                    //     Consumer<HouseAllowanceProviders>(
                    //       builder: (context, value, child) {
                    //         int Counts = 0;
                    //         String number_text = "";

                    //         Counts = value.HouseAllowanceList.length + 1;
                    //         _no = "300000" + Counts.toString();

                    //         return Expanded(
                    //           child: Text(
                    //             _no.toString(),
                    //             textAlign: TextAlign.end,
                    //           ),
                    //         );
                    //       },
                    //     ),
                    //   ],
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
                            _name,
                            textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),
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
                              _department,
                              textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),
                            ),
                            Text(
                              _divisionment,
                              textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),
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
                            DateFormat('dd-MM-yyyy  kk:mm').format(DateTime.now()),
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
                            style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            _startdate,
                            textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),
                          ),
                        ),
                      ],
                    ),
              //  TextFormField(
              //               maxLength: 10,
              //               controller: _dates,
              //               //keyboardType: TextInputType.text,
              //               decoration: InputDecoration(
              //                 //border: OutlineInputBorder(),
              //                 icon: Icon(Icons.calendar_today_rounded),

              //                 hintText: 'วันที่เข้างาน',
              //               ),
              //               onTap: () async {
              //                 DateTime? pickddate = await showDatePicker(
              //                     context: context,
              //                     initialDate: DateTime.now(),
              //                     firstDate: DateTime(2000),
              //                     lastDate: DateTime(9999));

              //                 if (pickddate != null) {
              //                   setState(() {
              //                     _dates.text = DateFormat('dd-MM-yyyy')
              //                         .format(pickddate);
              //                     //var _date = DateFormat("dd-MM-yyyy").format(now);
              //                   });
              //                 }
              //               },
              //               onSaved: (newValue) => _startdate = newValue!,
              //             ),
                    
                 
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
                      'ข้อมูลคำสั่งให้ไปดำรงตำแหน่ง',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 9, 28, 235),
                        fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        maxLength: 50,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'ตำแหน่ง',
                          labelText: 'ตำแหน่ง',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'โปรดระบุตำแหน่ง';
                          } else if (value.length >= 50) {
                            return 'โปรดระบุข้อมูลไม่เกิน 50 ตัวอักษร';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (newValue) {
                          _position = newValue!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        maxLength: 50,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'ส่วนงาน/สาขา',
                          labelText: 'ส่วนงาน/สาขา',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'โปรดระบุส่วนงาน/สาขา';
                          } else if (value.length >= 50) {
                            return 'โปรดระบุข้อมูลไม่เกิน 50 ตัวอักษร';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (newValue) {
                          _segment = newValue!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        maxLength: 50,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'ฝ่าย/สำนัก',
                          labelText: 'ฝ่าย/สำนัก',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'โปรดระบุฝ่าย/สำนัก';
                          } else if (value.length >= 50) {
                            return 'โปรดระบุข้อมูลไม่เกิน 50 ตัวอักษร';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (newValue) {
                          _departmentwork = newValue!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        maxLength: 50,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'จังหวัด',
                          labelText: 'จังหวัด',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'โปรดระบุจังหวัด';
                          } else if (value.length >= 50) {
                            return 'โปรดระบุข้อมูลไม่เกิน 50 ตัวอักษร';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (newValue) {
                          _provincework = newValue!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        maxLength: 10,
                        controller: _date,
                        //keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          //border: OutlineInputBorder(),
                          icon: Icon(Icons.calendar_today_rounded),

                          hintText: 'วันที่ดำรงตำแหน่ง',
                        ),
                        onTap: () async {
                          DateTime? pickddate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(9999));

                          if (pickddate != null) {
                            setState(() {
                              _date.text =
                                  DateFormat('dd-MM-yyyy').format(pickddate);
                              //var _date = DateFormat("dd-MM-yyyy").format(now);
                            });
                          }
                        },
                        onSaved: (newValue) => _positiondate = newValue!,
                      ),
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
                      'ข้อมูลการค่าเช่าบ้าน',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 9, 28, 235),
                        fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'ประเภทการเช่าบ้าน',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField(
                        value: _selectedVal,
                        items: _childName
                            .map((e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            _selectedVal = val as String;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'จำนวนเงินการชำระเดือน',
                          labelText: 'จำนวนเงินการชำระเดือน',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'โปรดระบุจำนวนเงินการชำระเดือน';
                          } else if (value.length >= 10) {
                            return 'โปรดระบุข้อมูลไม่เกิน 50 ตัวอักษร';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (newValue) {
                          _moneyhouse = newValue!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        maxLength: 50,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'บ้านเลขที่',
                          labelText: 'บ้านเลขที่',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'โปรดระบุบ้านเลขที่';
                          } else if (value.length >= 50) {
                            return 'โปรดระบุข้อมูลไม่เกิน 50 ตัวอักษร';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (newValue) {
                          _housenumber = newValue!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        maxLength: 50,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'ตรอก/ซอย',
                          labelText: 'ตรอก/ซอย',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'โปรดระบุตรอก/ซอย';
                          } else if (value.length >= 50) {
                            return 'โปรดระบุข้อมูลไม่เกิน 50 ตัวอักษร';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (newValue) {
                          _alley = newValue!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        maxLength: 50,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'ถนน',
                          labelText: 'ถนน',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'โปรดระบุถนน';
                          } else if (value.length >= 50) {
                            return 'โปรดระบุข้อมูลไม่เกิน 50 ตัวอักษร';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (newValue) {
                          _road = newValue!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        maxLength: 50,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'ตำบล/แขวง',
                          labelText: 'ตำบล/แขวง',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'โปรดระบุตำบล/แขวง';
                          } else if (value.length >= 50) {
                            return 'โปรดระบุข้อมูลไม่เกิน 50 ตัวอักษร';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (newValue) {
                          _district = newValue!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        maxLength: 50,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'อำเภอ/เขต',
                          labelText: 'อำเภอ/เขต',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'โปรดระบุอำเภอ/เขต';
                          } else if (value.length >= 50) {
                            return 'โปรดระบุข้อมูลไม่เกิน 50 ตัวอักษร';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (newValue) {
                          _county = newValue!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        maxLength: 50,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'จังหวัด',
                          labelText: 'จังหวัด',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'โปรดระบุจังหวัด';
                          } else if (value.length >= 50) {
                            return 'โปรดระบุข้อมูลไม่เกิน 50 ตัวอักษร';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (newValue) {
                          _province = newValue!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Text(
                            'เพื่อใช้เป็นบ้านพักอาศัยในท้องที่ที่ปฏิบัติงาน',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField(
                        value: _selectedpartner,
                        items: _childpartner
                            .map((e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            _selectedpartner = val as String;
                            visibilityTag
                                ? null
                                : _changed(true, _selectedpartner!);
                          });
                        },
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
                        color: iBlueColor,
                        fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                      ),
                    ),
                    const Divider(),
                    ElevatedButton(
                style: ElevatedButton.styleFrom(primary:iBlueColor),
                onPressed: () {uploadDataToFirebase();},
                child: Text("เอกสารแนบ",style: TextStyle(fontFamily: 'Sarabun',),),
                
                ),
                    const Divider(),

                                        if (_filename == "" || _filename == null) ...[
                      Text(""),
                    ] else ...[
                      ListTile(
                        title: Text(_filename.toString()),
                        trailing: Container(
                          width: 70,
                          child: Row(
                            children: [
                              Expanded(
                                  child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              View(url: _url)));
                                },
                                icon: Icon(Icons.remove_red_eye),
                              )),
                              Expanded(
                                  child: IconButton(
                                onPressed: () {
                                  deleteflie();
                                },
                                icon: Icon(Icons.delete),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ]
                    // Consumer<flieHouseAllowanceModal>(
                    //   builder: (context, value, child) {

                    //     if (value.flieHouseAllowanceChoice
                    //               .toString()
                    //               .isNotEmpty) {
                    //       //Carimg = '${value.flieChildAllowanceChoice}';
                    //                           return 
                          
                    //       ListTile(
                    //         title: Text(_filename.toString()),
                    //         trailing: Container(
                    //           width: 70,
                    //           child: Row(
                    //             children: [
                    //               Expanded(child:IconButton(
                    //                 onPressed:() { Navigator.push(
                    //                   context,MaterialPageRoute
                    //                   (builder: (context) => View(url: _url)));},
                    //                   icon:Icon(Icons.remove_red_eye) ,) ),
                    //               Expanded(child:IconButton(
                    //                 onPressed:() { deleteflie();},
                    //                   icon:Icon(Icons.delete) ,) ),
                    //             ],
                    //           ),
                    //         ),
                    //         // Icon(Icons.remove_red_eye),
                    //         // onTap: () {
                    //         //   Navigator.push(
                    //         //       context,
                    //         //       MaterialPageRoute(
                    //         //           builder: (context) => View(url: _url)));
                    //         // },

                    //       );
                    //     } else {
                    //       return Text("");
                    //     }
                    //   },
                    // ),
              //       ElevatedButton(
              //         child: Text("เอกสารแนบ"),
              //         onPressed: () async {
              //           final result = await FilePicker.platform.pickFiles(
              //             allowMultiple: true,
              //             type: FileType.custom,
              //             allowedExtensions: ['pdf', 'jpeg', 'jpg'],
              //           );
              //           if (result == null) return;

              //           //open
              //           //  final file = result.files.first;
              //           openFiles(context, result.files);
              //           /*
              // print('Name: ${file.name}');
              //             print('Bytes: ${file.bytes}');
              //                         print('Size: ${file.size}');
              //                                     print('Extension: ${file.extension}');
              //                                                 print('Path: ${file.path}');
        
              // final newFile  = await saveFilePermanently(file);
              // print('From Path: ${file.path!}');
              //             print('To Path: ${newFile.path!}');
        
              //             */
              //         },
              //       ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
               ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: iBluebuttonColor,
                  onPrimary: Colors.white,
                  shadowColor: iBluebuttonColor,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: Size(200, 40), //////// HERE
                ),
                onPressed: () {
                  AddHouseAllowance();
                },
                child: Text('บันทึกข้อมูล',style: TextStyle(fontFamily: 'Sarabun',),),
              ),
              //               ElevatedButton(
              //   child: Text("บันทึกข้อมูล"),
              //   onPressed: () {
              //     AddHouseAllowance();
              //   },
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
              //   child: GestureDetector(
              //     onTap: AddHouseAllowance,
              //     child: Container(
              //       padding: EdgeInsets.all(20),
              //       decoration: BoxDecoration(
              //         color: iBlueColor,
              //         borderRadius: BorderRadius.circular(12),
              //       ),
              //       child: Center(
              //         child: Text(
              //           'บันทึกข้อมูล',
              //           style: TextStyle(
              //               color: iWhiteColor,
              //               fontWeight: FontWeight.bold,
              //               fontSize: 18),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
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

  void openFiles(context, List<PlatformFile> files) =>
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FilesPage(
          files: files,
          onOpenFile: openFile,
        ),
      ));
  void openFile(PlatformFile file) {
    OpenFile.open(file.path!);
  }
}

class View extends StatelessWidget {
  PdfViewerController? _pdfViewerController;
  final url;
  View({this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียดเอกสาร',style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                            color: iWhiteColor,
                          ),),
      backgroundColor: iBlueColor,
),
      
      body: SfPdfViewer.network(
        url,
        controller: _pdfViewerController,
      ),
    );
  }
}

class flieHouseAllowanceModal extends ChangeNotifier {
  String _flie = '';
  get flieHouseAllowanceChoice => this._flie;

  set flieHouseAllowanceChoice(value) {
    this._flie = value;
    notifyListeners();
  }
    void deleteflie(){
    this._flie = '';
   notifyListeners();


}
}
