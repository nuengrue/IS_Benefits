import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ghb_benefits/All_Controllers/Education_Controller.dart';
import 'package:ghb_benefits/All_Controllers/master_controllers.dart';
import 'package:ghb_benefits/All_Page/Education/list_education_page.dart';
import 'package:ghb_benefits/All_Providers/provider_child_allowance.dart';
import 'package:ghb_benefits/All_Providers/provider_education.dart';
import 'package:ghb_benefits/All_Providers/provider_master.dart';
import 'package:ghb_benefits/All_Services/servics.dart';
import 'package:ghb_benefits/color.dart';
import 'package:ghb_benefits/pdf/files_page.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class AddEduPage extends StatefulWidget {
  const AddEduPage({Key? key}) : super(key: key);

  @override
  State<AddEduPage> createState() => _AddEduPageState();
}

class _AddEduPageState extends State<AddEduPage> {
  _AddEduPageState() {
    _selectedValchild = _childName[0];
    _selectedValclass = _className[0];
    _selectedValacademy = _academyName[0];
    _selectedValyear = _yearName[0];
    _selectedValsector = _sectorName[0];
    _selectedValeducationlevel = _educationlevelName[0];
    _selectedValeducationtype = _educationtypeName[0];
  }

  MasterController mastecontroller = MasterController(FirebaseServices());
  EducationController controller = EducationController(FirebaseServices());

  void initState() {
    super.initState();
    _getEducationadd(context);
  }

  late int _idcounts = 0;
  void _getEducationadd(BuildContext context) async {
    var newEmployee = await mastecontroller.fetchEmployee();
    context.read<EmployeeProviders>().EmployeeList = newEmployee;
    context.read<filedEmployeeProviders>().Empno = newEmployee.first.no;
    context.read<filedEmployeeProviders>().Empempcode =
        newEmployee.first.empcode;
    context.read<filedEmployeeProviders>().Empnameemp =
        newEmployee.first.nameemp;
    context.read<filedEmployeeProviders>().Empdepartment =
        newEmployee.first.department;
    context.read<filedEmployeeProviders>().Empdivisionment =
        newEmployee.first.divisionment;
    context.read<filedEmployeeProviders>().Empdate = newEmployee.first.date;
    context.read<filedEmployeeProviders>().Empuid = newEmployee.first.uid;

    setState(() {
      _empcode = newEmployee.first.empcode;
      _name = newEmployee.first.nameemp;
      _department = newEmployee.first.department;
      _divisionment = newEmployee.first.divisionment;
    });

    var newEducation = await controller.fetchEducation();
    setState(() {
      _idcounts = newEducation.length + 1;
    });
  }

  final List<String> _childName = [
    "เลือกบุตร",
    "ทดสอบ คนที่1",
    "ทดสอบ คนที่2",
    "ทดสอบ คนที่3",
    "ทดสอบ คนที่4"
  ];
  final List<String> _className = [
    "อ.1",
    "อ.2",
    "อ.3",
    "ป.1",
    "ป.2",
    "ป.3 ",
    "ป.4",
    "ป.5",
    "ป.6"
  ];
  final List<String> _academyName = [
    "โรงเรียนสามเสนวิทยาลัย",
    "โรงเรียนพญาไท",
    "โรงเรียนฤทธิยะวรรณาลัย"
  ];
  final List<String> _yearName = [
    DateFormat.y().format(DateTime.now()).toString(),
    "2022",
  ];
  final List<String> _sectorName = [
    "1",
    "2",
  ];
  final List<String> _educationlevelName = ["อนุบาล", "ประถมต้น", "ประถมปลาย"];
  final List<String> _educationtypeName = [
    "เอกชน",
    "รัฐบาล",
  ];
  String? _selectedValchild = "";
  String? _selectedValclass = "";
  String? _selectedValacademy = "";
  String? _selectedValyear = "";
  String? _selectedValsector = "";
  String? _selectedValeducationlevel = "";
  String? _selectedValeducationtype = "";
  TextEditingController _date = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final user = FirebaseAuth.instance.currentUser!;
  late String _no;
  late String _empcode = "";
  late String _name = "";
  late String _department = "";
  late String _divisionment = "";
//
  late String _typeedu;
  late String _yearedu;
  late String _savedate;
//

  late String _namechild = _selectedValchild!;

//
  late String _level;
  late String _school;
  late String _year;
  late String _term;
  late String _educationlevel;
  late String _schooltype;
//
  late String _receiptnumber;
  late String _volume;
  late String _tel;
  late String _receiptdate;
  //
  late String _amountreceipt;

  ///
  late String _payamount;
  late String _paydate;
  late String _status;
  late String _email;
  late String _url;
  late String _filename = "";
  late String _flagread;
  late String _id;
  late String _remarks = "";
  void addEducation() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      _idcounts = _idcounts;
      _empcode = _empcode;
      _name = _name;
      _department = _department;
      _divisionment = _divisionment;

      _typeedu = "ขอเบิก";
      _yearedu = DateFormat.y().format(DateTime.now());
      _savedate = DateFormat('dd-MM-yyyy  kk:mm').format(DateTime.now());
//

      _namechild = _selectedValchild!;
      ;

//
      _level = _selectedValclass!;

      _school = _selectedValacademy!;

      _year = DateFormat.y().format(DateTime.now());

      _term = _selectedValsector!;
      _educationlevel = _selectedValeducationlevel!;
      _schooltype = _selectedValeducationtype!;
//
      _receiptnumber;
      _volume;
      _tel;
      _receiptdate;
      //
      _amountreceipt;

      ///
      _payamount = "0";
      _paydate = "";

      _status = "ร้องขอ";
      _email = user.uid;
      _url = _url;
      _filename = _filename;
      _flagread = "0";
      _id = "";
      _remarks = _remarks;

      Provider.of<EducationProviders>(context, listen: false).addEducation(
          _idcounts,
          _empcode,
          _name,
          _department,
          _divisionment,
//
          _typeedu,
          _yearedu,
          _savedate,
//

          _namechild,

//
          _level,
          _school,
          _year,
          _term,
          _educationlevel,
          _schooltype,
//
          _receiptnumber,
          _volume,
          _tel,
          _receiptdate,
          //
          _amountreceipt,

          ///
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
      CollectionReference educations =
          FirebaseFirestore.instance.collection('Education');
      DocumentReference doc = await educations.add({
        'no': _idcounts,
        'empcode': _empcode,
        'name': _name,
        'department': _department,
        'divisionment': _divisionment,
        'typeedu': _typeedu,
        'yearedu': _yearedu,
        'savedate': _savedate,
        'namechild': _namechild,
        'level': _level,
        'school': _school,
        'year': _year,
        'term': _term,
        'educationlevel': _educationlevel,
        'schooltype': _schooltype,
        'receiptnumber': _receiptnumber,
        'volume': _volume,
        'tel': _tel,
        'receiptdate': _receiptdate,
        'amountreceipt': _amountreceipt,
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

      context.read<flieEducationModal>().flieEducationChoice = '';

      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        showCloseIcon: true,
        btnOkText : "ตกลง",
        title: "สำเร็จ",
        desc: "ดำเนินการบันทึกข้อมูลสำเร็จ",
        btnOkOnPress: () {
          Navigator.pop(
            context,
            MaterialPageRoute(
              builder: (context) => ListEducationPage(),
            ),
          );
        },
      ).show();

      // Navigator.pop(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => ListEducationPage(),
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
    context.read<flieEducationModal>().flieEducationChoice = filename;

    // await FirebaseFirestore.instance
    // .collection("file")
    // .doc()
    // .set({'fileUrl':url,'num' : "file FDF" + filename.toString()});
    // //.set({'fileUrl':url,'num' : "file FDF" + number.toString()});
  }

  void deleteflie() async {
    Provider.of<flieEducationModal>(context, listen: false).deleteflie();
    setState(() {
      _filename = "";
    });
    // _filename = "";
    // _url = "";
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for
    // the major Material Components.
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'สร้างคำขอค่าช่วยเหลือการศึกษาบุตร',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Sarabun',
            color: iWhiteColor,
          ),
        ),
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
                      'สร้างคำขอเบิกเงินค่าช่วยเหลือการศึกษาบุตร',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 9, 28, 235),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Sarabun',
                      ),
                    ),
                    const Divider(),
                    //                        Row(
                    //   children: [
                    //     Expanded(
                    //       child: Text(
                    //         'เลขที่',
                    //         textAlign: TextAlign.left,
                    //         style: TextStyle(fontWeight: FontWeight.bold),
                    //       ),
                    //     ),
                    //     Consumer<ChildAllowanceProviders>(
                    //       builder: (context, value, child) {
                    //         int Counts = 0;
                    //         String number_text = "";

                    //         Counts = value.ChildAllowanceList.length + 1;
                    //         _no = "500000" + Counts.toString();

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
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sarabun',
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            _name,
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
                              _department,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontFamily: 'Sarabun',
                              ),
                            ),
                            Text(
                              _divisionment,
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
                    //         'ขอเบิก',
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
                            DateFormat('dd-MM-yyyy  kk:mm')
                                .format(DateTime.now()),
                            textAlign: TextAlign.end,
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
                            DateFormat.y().format(DateTime.now()),
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
                      'ข้อมูลบุตร',
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
                            'บุตร',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sarabun',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton(
                            value: _selectedValchild,
                            items: _childName
                                .map((e) => DropdownMenuItem(
                                      child: Text(e),
                                      value: e,
                                    ))
                                .toList(),
                            onChanged: (val) {
                              setState(() {
                                _selectedValchild = val as String;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //
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
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Sarabun',
                      ),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'ระดับชั้น',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sarabun',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        DropdownButton(
                          value: _selectedValclass,
                          items: _className
                              .map((e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              _selectedValclass = val as String;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'สถานศึกษา',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sarabun',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        DropdownButton(
                          value: _selectedValacademy,
                          items: _academyName
                              .map((e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              _selectedValacademy = val as String;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'ปีการศึกษา',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sarabun',
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            DateFormat.y().format(DateTime.now()),
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontFamily: 'Sarabun',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'ภาค',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Sarabun',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        DropdownButton(
                          value: _selectedValsector,
                          items: _sectorName
                              .map((e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              _selectedValsector = val as String;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'ระดับการศึกษา',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sarabun',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        DropdownButton(
                          value: _selectedValeducationlevel,
                          items: _educationlevelName
                              .map((e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              _selectedValeducationlevel = val as String;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'ประเภทการศึกษา',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sarabun',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        DropdownButton(
                          value: _selectedValeducationtype,
                          items: _educationtypeName
                              .map((e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              _selectedValeducationtype = val as String;
                            });
                          },
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

                    // key: _formKey,
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            'เลขที่ใบเสร็จ',
                            style: TextStyle(
                              fontFamily: 'Sarabun',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            maxLength: 150,
                            //controller: _addressc,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'ระบุเลขที่ใบเสร็จ',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'โปรดระบุเลขที่ใบเสร็จ';
                              }
                            },
                            onSaved: (newValue) => _receiptnumber = newValue!,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text('เล่มที่'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            maxLength: 10,
                            //controller: _amountc,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'เล่มที่',
                            ),

                            onSaved: (newValue) => _volume = newValue!,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            'หมายเลขติดต่อกลับ',
                            style: TextStyle(
                              fontFamily: 'Sarabun',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            maxLength: 10,
                            //controller: _amountc,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'หมายเลขติดต่อกลับ',
                            ),

                            onSaved: (newValue) => _tel = newValue!,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            'วันที่ใบเสร็จ',
                            style: TextStyle(
                              fontFamily: 'Sarabun',
                            ),
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

                              hintText: 'วันที่ใบเสร็จ',
                            ),
                            onTap: () async {
                              DateTime? pickddate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(9999));

                              if (pickddate != null) {
                                setState(() {
                                  _date.text = DateFormat('dd-MM-yyyy')
                                      .format(pickddate);
                                  //var _date = DateFormat("dd-MM-yyyy").format(now);
                                });
                              }
                            },
                            onSaved: (newValue) => _receiptdate = newValue!,
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
                        color: iBlueColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Sarabun',
                      ),
                    ),
                    const Divider(),

                    // key: _formKey,
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            'จำนวนเงินตามใบเสร็จ',
                            style: TextStyle(
                              fontFamily: 'Sarabun',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            maxLength: 10,
                            //controller: _addressc,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'ระบุจำนวนเงินตามใบเสร็จ',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'โปรดระบุจำนวนเงินตามใบเสร็จ';
                              }
                            },
                            onSaved: (newValue) => _amountreceipt = newValue!,
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
                      'เอกสารแนบ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 9, 28, 235),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Sarabun',
                      ),
                    ),
                    const Divider(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: iBlueColor),
                      onPressed: () {
                        uploadDataToFirebase();
                      },
                      child: Text(
                        "เอกสารแนบ",
                        style: TextStyle(
                          fontFamily: 'Sarabun',
                        ),
                      ),
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
                    // Consumer<flieEducationModal>(
                    //   builder: (context, value, child) {

                    //     if (value.flieEducationChoice
                    //               .toString()
                    //               .isNotEmpty) {
                    //       //Carimg = '${value.flieChildAllowanceChoice}';
                    //        return

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
                    //       );
                    //     } else {
                    //       return Text("");
                    //     }
                    //   },
                    // ),
                    //             ElevatedButton(
                    //               child: Text("เอกสารแนบ"),
                    //               onPressed: () async {
                    //                 final result = await FilePicker.platform.pickFiles(
                    //                   allowMultiple: true,
                    //                   type: FileType.custom,
                    //                   allowedExtensions: ['pdf', 'jpeg', 'jpg'],
                    //                 );
                    //                 if (result == null) return;

                    //                 //open
                    //                 //  final file = result.files.first;
                    //                 openFiles(context, result.files);
                    // /*
                    //       print('Name: ${file.name}');
                    //                   print('Bytes: ${file.bytes}');
                    //                               print('Size: ${file.size}');
                    //                                           print('Extension: ${file.extension}');
                    //                                                       print('Path: ${file.path}');

                    //       final newFile  = await saveFilePermanently(file);
                    //       print('From Path: ${file.path!}');
                    //                   print('To Path: ${newFile.path!}');

                    //                   */
                    //               },
                    //             ),
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
                  addEducation();
                },
                child: Text(
                  'บันทึกข้อมูล',
                  style: TextStyle(
                    fontFamily: 'Sarabun',
                  ),
                ),
              ),
              //                 ElevatedButton(
              //   child: Text("บันทึกข้อมูล"),
              //   onPressed: () {
              //     addEducation();
              //   },
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
              //   child: GestureDetector(
              //     onTap: addEducation,
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
              ////end
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
        title: Text(
          'รายละเอียดเอกสาร',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Sarabun',
            color: iWhiteColor,
          ),
        ),
        backgroundColor: iBlueColor,
      ),
      body: SfPdfViewer.network(
        url,
        controller: _pdfViewerController,
      ),
    );
  }
}

class flieEducationModal extends ChangeNotifier {
  String _flie = '';
  get flieEducationChoice => this._flie;

  set flieEducationChoice(value) {
    this._flie = value;
    notifyListeners();
  }

  void deleteflie() {
    this._flie = '';
    notifyListeners();
  }
}
