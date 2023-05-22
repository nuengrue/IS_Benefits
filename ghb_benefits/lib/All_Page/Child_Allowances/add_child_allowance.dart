import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ghb_benefits/All_Controllers/child_allowance_controllers.dart';
import 'package:ghb_benefits/All_Controllers/master_controllers.dart';
import 'package:ghb_benefits/All_Models/child_allowane_model.dart';
import 'package:ghb_benefits/All_Models/child_model.dart';
import 'package:ghb_benefits/All_Models/employee_model.dart';
import 'package:ghb_benefits/All_Page/Child_Allowances/list_child_allowance.dart';
import 'package:ghb_benefits/All_Providers/provider_child_allowance.dart';
import 'package:ghb_benefits/All_Providers/provider_master.dart';
import 'package:ghb_benefits/All_Services/servics.dart';
import 'package:ghb_benefits/color.dart';
import 'package:ghb_benefits/pdf/files_page.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class AddChildAllowancePage extends StatefulWidget {
  const AddChildAllowancePage({Key? key}) : super(key: key);
  //final int Count;

  @override
  State<AddChildAllowancePage> createState() => _AddChildAllowancePageState();
}

class _AddChildAllowancePageState extends State<AddChildAllowancePage> {
  MasterController mastecontroller = MasterController(FirebaseServices());
   late String _nochildName  = "";
     List<Child> child = List.empty();
 
  List<DropdownMenuItem<String>> _ddlchildName = [];
  ChildAllowanceController controller =
      ChildAllowanceController(FirebaseServices());

  void initState() {
    super.initState();
    _getMaster(context);
    _getChildAllowanceadd(context);
  }

  void _getMaster(BuildContext context) async {
    var newEmployee = await mastecontroller.fetchEmployee();
    context.read<EmployeeProviders>().EmployeeList = newEmployee;
    var newChilder = await mastecontroller.fetchChilder();
                 newChilder.sort((a,b) => a.nochild.compareTo(b.nochild));

             child =  newChilder.reversed.toList();
        setState(() {
      _ddlchildName
          .add(DropdownMenuItem(value: "", child: Text("เลือกบุตร")));
      child.forEach((e) {
        _ddlchildName.add(DropdownMenuItem(
            child: Text(e.namechild), value: e.namechild));
      });
    });
    context.read<ChilderProviders>().ChilderList = newChilder;
    List<String> childName = [];
    for (var doc in newChilder) {
      childName.add(doc.namechild);
    }
    List<String> sumamounteducation = childName;
    context.read<ChilderProviders>().childnamerList = sumamounteducation;

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
      _nameemp = newEmployee.first.nameemp;
      _department = newEmployee.first.department;
      _divisionment = newEmployee.first.divisionment;
    });
  }

  late int _idcounts = 0;
  void _getChildAllowanceadd(BuildContext context) async {
    var newAllowance = await controller.fetchChildAllowanceno();
    setState(() {
      _idcounts = newAllowance.length + 1;
    });
  }

  _AddChildAllowancePageState() {
    // _selectedVal = _childName[0];
    _selectedpartner = _childpartner[0];
    _selectedstatuspartner = _childstatuspartner[0];
  }


  // List<DropdownMenuItem<String>> _ddlchildName = [];
  late String _selectedchild;
  String dropdownValue = 'Dog';

  final _childName = [
    "เลือกบุตร",
    "ทดสอบ คนที่1",
    "ทดสอบ คนที่2",
    "ทดสอบ คนที่3",
    "ทดสอบ คนที่4"
  ];
  List<String> _childNames = [];
  // late  List<String> _childName =[];
  String? _selectedVal = "";
  final _childpartner = [
    "เลือกสถานะ",
    "สมรส",
    "อย่าขาดจากคู่สมรส",
    "คู่สมรสถึงแก่กรรม"
  ];
  String? _selectedpartner = "";

  final _childstatuspartner = ["เลือกสถานะ", "จดทะเบียน", "ไม่จดทะเบียน"];
  String? _selectedstatuspartner = "";

  final _formKey = GlobalKey<FormState>();

  bool visibilityTag = false;

  void _changed(bool visibility, String field) {
    setState(() {
      if (field == "สมรส") {
        visibilityTag = visibility;
      }
    });
  }

  final user = FirebaseAuth.instance.currentUser!;

  late String _no;
  late String _empcode = "";
  late String _nameemp = "";
  late String _department = "";
  late String _divisionment = "";
  late String _savedate;
  late String _namechild;
  late String _namepartner;
  late String _officetner;
  late String _maritalstatus;
  late String _submaritalstatus;
  late String _status;
  late String _email;
  late String _url;
  late String _filename = "";
  late String _flagread;
  late String _id;
  late String _remarks = "";

  void AddChildAllowance() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _idcounts = _idcounts;
      _empcode = _empcode;
      _nameemp = _nameemp;
      _department = _department;
      _divisionment = _divisionment;
      _savedate = DateFormat('dd-MM-yyyy  kk:mm').format(DateTime.now());
      // _savedate = DateFormat.yMd().add_Hm().format(DateTime.now());
      _namechild = _nochildName;
      _namepartner;
      _officetner;
      _maritalstatus = _selectedpartner!;
      if (_selectedstatuspartner == "เลือกสถานะ") {
        _submaritalstatus = "-";
      } else {
        _submaritalstatus = _selectedstatuspartner!;
      }
      _status = "ร้องขอ";
      //print(_status);
      _email = user.uid;
      _url = _url;
      _filename = _filename;
      _flagread = "0";
      _id = "";
      _remarks = _remarks;

      Provider.of<ChildAllowanceProviders>(context, listen: false)
          .addChildAllowane(
              _idcounts,
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
              _id,
              _remarks);

      CollectionReference ChildAllowance =
          FirebaseFirestore.instance.collection('ChildAllowance');
      DocumentReference doc = await ChildAllowance.add({
        'no': _idcounts,
        'empcode': _empcode,
        'nameemp': _nameemp,
        'department': _department,
        'divisionment': _divisionment,
        'savedate': _savedate,
        'namechild': _namechild,
        'namepartner': _namepartner,
        'officetner': _officetner,
        'maritalstatus': _maritalstatus,
        'submaritalstatus': _submaritalstatus,
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
      });

      // context.read<flieChildAllowanceModal>().flieChildAllowanceChoice = '';

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
              builder: (context) => ListChildAllowancePage(),
            ),
          );
        },
      ).show();
      // Navigator.pop(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => ListChildAllowancePage(),
      //   ),
      // );
      // context.read<flieChildAllowanceModal>().flieChildAllowanceChoice = '';
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
    var pdfFile = FirebaseStorage.instance.ref().child(filename.toString());
    // .child("/" + filename.toString());
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
    context.read<flieChildAllowanceModal>().flieChildAllowanceChoice = filename;

    // await FirebaseFirestore.instance
    // .collection("file")
    // .doc()
    // .set({'fileUrl':url,'num' : "file FDF" + filename.toString()});
    // //.set({'fileUrl':url,'num' : "file FDF" + number.toString()});
  }

  void deleteflie() async {
    Provider.of<flieChildAllowanceModal>(context, listen: false).deleteflie();
    setState(() {
      _filename = "";

      // _url = url;
      // print(_url);
    });
    // _filename = "";
    print(_filename);
    // _url = "";
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for

    // the major Material Components.
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'สร้างรายการคำขอเบิกค่าช่วยเหลือบุตร',
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
                      'สร้างคำขอเบิกเงินค่าช่วยเหลือบุตร',
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
                    //         _no = "100000" + Counts.toString();

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
                          // child: Consumer<EmployeeProviders>(builder: (context,value, child) {
                          //   final Employee  Etest;
                          //   Etest =  value.EmployeeList as Employee;
                          // return  Text(
                          // Etest.nameemp,
                          //   textAlign: TextAlign.end,
                          // );
                          // },),
                          child: Text(
                            _nameemp,
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

              ///

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
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'บุตรของพนักงาน',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Sarabun',
                              ),
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
//              if (value.ChilderList.isNotEmpty) ...[

//  Text('ท่านได้ใช้วงเงินตามสิทธิ์ครบกำหนดแล้ว:'),

// // Step 1.

// // Step 2.
// // DropdownButton<String>(

// //   // Step 3.
// //   value: dropdownValue,
// //   // Step 4.
// //   items: context.read<ChilderProviders>().childnamerList.toList()
// //   // <String>['Dog', 'Cat', 'Tiger', 'Lion']     context.read<ChilderProviders>().childnamerList
// //       .map<DropdownMenuItem<String>>((String value) {
// //     return DropdownMenuItem<String>(
// //       value: value,
// //       child: Text(
// //         value,
// //         style: TextStyle(fontSize: 30),
// //       ),
// //     );
// //   }).toList(),
// //   // Step 5.
// //   onChanged: (String? newValue) {
// //     setState(() {
// //       dropdownValue = newValue!;
// //     });
// //   },
// // ),

//     ] else ...[
//      Text('ท่านได้ใช้วงเงินตามสิทธิ์ครบกำหนดแล้ว: ไม่มี'),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField(
                            decoration: const InputDecoration(
                              labelText: 'ชื่อบุตร',
                            ),
                            value: _nochildName,
                            items: _ddlchildName,
                            validator: (value) {
                              if (value == "") {
                                return "กรุณาระบุ บุตร";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _nochildName = value.toString();
                            },
                            onSaved: (value) {
                              _nochildName = value.toString();
                            },
                          ),
                        ),
                        //     ]


                    // var clients = context.read<ChilderProviders>().ChilderList.toList();
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: DropdownButtonFormField(
                    //     // value: _selectedVal,
                    //     value: _selectedVal,
                    //     items: _childName
                    //         .map((e) => DropdownMenuItem(
                    //               child: Text(e),
                    //               value: e,
                    //             ))
                    //         .toList(),
                    //     onChanged: (val) {
                    //       setState(() {
                    //         _selectedVal = val as String;
                    //       });
                    //     },
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
                      'ข้อมูลคู่สมรส',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 9, 28, 235),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        maxLength: 100,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'ชื่อ-นามสกุลของคู่มสมรส',
                          labelText: 'ชื่อ-นามสกุลของคู่มสมรส',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'โปรดระบุชื่อ-นามสกุลของคู่มสมรส';
                          } else if (value.length >= 100) {
                            return 'โปรดระบุข้อมูลไม่เกิน 100 ตัวอักษร';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (newValue) {
                          _namepartner = newValue!;
                        },
                      ),
                    ),
                    /*
                                   Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  maxLength: 50,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'นามสกุลของคู่มสมรส',
                    labelText: 'นามสกุลของคู่มสมรส',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'โปรดระบุนามสกุลของคู่มสมรส';
                    } else if (value.length != 4) {
                      return 'โปรดระบุข้อมูลไม่เกิน 50 ตัวอักษร';
                    } else {
                      return null;
                    }
                  },
                //  onSaved: (newValue) {_cvvs = newValue!;},
                ),
              ),
              */
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        maxLength: 100,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'สถานที่ทำงาน',
                          labelText: 'สถานที่ทำงาน',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'โปรดระบุสถานที่ทำงาน';
                          } else if (value.length >= 100) {
                            return 'โปรดระบุข้อมูลไม่เกิน 100 ตัวอักษร';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (newValue) {
                          _officetner = newValue!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'สถานะ',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Sarabun',
                              ),
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
                    visibilityTag
                        ? new Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              new Expanded(
                                flex: 11,
                                child: new DropdownButtonFormField(
                                  value: _selectedstatuspartner,
                                  items: _childstatuspartner
                                      .map((e) => DropdownMenuItem(
                                            child: Text(e),
                                            value: e,
                                          ))
                                      .toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      if (val == 'เลือกสถานะ') {
                                        _selectedstatuspartner = "-";
                                      } else {
                                        _selectedstatuspartner = val as String;
                                      }
                                    });
                                  },
                                ),
                              ),
                              new Expanded(
                                flex: 1,
                                child: new IconButton(
                                  color: Colors.grey[400],
                                  icon: const Icon(
                                    Icons.cancel,
                                    size: 22.0,
                                  ),
                                  onPressed: () {
                                    _changed(false, "สมรส");
                                  },
                                ),
                              ),
                            ],
                          )
                        : new Container(),
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
                    // ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //  backgroundColor: Colors.red, foregroundColor: iWhiteColor),
                    //   child: Text("เอกสารแนบ",style: TextStyle(fontFamily: 'Sarabun',),),

                    //   onPressed: () {
                    //     uploadDataToFirebase();
                    //   },
                    // ),
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
                    // if (_filename == ) {
                    //   return ListTile(
                    //     title: Text(_filename.toString()),
                    //     trailing: Container(
                    //       width: 70,
                    //       child: Row(
                    //         children: [
                    //           Expanded(
                    //               child: IconButton(
                    //             onPressed: () {
                    //               Navigator.push(
                    //                   context,
                    //                   MaterialPageRoute(
                    //                       builder: (context) =>
                    //                           View(url: _url)));
                    //             },
                    //             icon: Icon(Icons.remove_red_eye),
                    //           )),
                    //           Expanded(
                    //               child: IconButton(
                    //             onPressed: () {
                    //               deleteflie();
                    //             },
                    //             icon: Icon(Icons.delete),
                    //           )),
                    //         ],
                    //       ),
                    //     ),

                    //   );
                    // } else {
                    //   return Text("");
                    // },

                    // Consumer<flieChildAllowanceModal>(
                    //   builder: (context, value, child) {
                    //     if (value.flieChildAllowanceChoice
                    //         .toString()
                    //         .isNotEmpty) {
                    //       //Carimg = '${value.flieChildAllowanceChoice}';
                    //       return ListTile(
                    //         title: Text(_filename.toString()),
                    //         trailing: Container(
                    //           width: 70,
                    //           child: Row(
                    //             children: [
                    //               Expanded(
                    //                   child: IconButton(
                    //                 onPressed: () {
                    //                   Navigator.push(
                    //                       context,
                    //                       MaterialPageRoute(
                    //                           builder: (context) =>
                    //                               View(url: _url)));
                    //                 },
                    //                 icon: Icon(Icons.remove_red_eye),
                    //               )),
                    //               Expanded(
                    //                   child: IconButton(
                    //                 onPressed: () {
                    //                   deleteflie();
                    //                 },
                    //                 icon: Icon(Icons.delete),
                    //               )),
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
                  AddChildAllowance();
                },
                child: Text(
                  'บันทึกข้อมูล',
                  style: TextStyle(
                    fontFamily: 'Sarabun',
                  ),
                ),
              ),

              // ElevatedButton(
              //   child: Text("บันทึกข้อมูล"),
              //   onPressed: () {
              //     AddChildAllowance();

              //   },
              // ),

              SizedBox(
                height: 10,
              ),

              // AnimatedButton(
              //   text: "บันทึกข้อมูลสำเร็จ",
              //   color: Colors.green,
              //   pressEvent: () {
              //     AwesomeDialog(
              //       context: context,
              //       dialogType: DialogType.success,
              //       animType: AnimType.bottomSlide,
              //       showCloseIcon: true,
              //       title: "สำเร็จ",
              //       desc: "ดำเนินการบันทึกข้อมูลสำเร็จ",
              //       btnOkOnPress: () {
              //         AddChildAllowance();
              //       },
              //     ).show();
              //   },

              //   ),

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

class flieChildAllowanceModal extends ChangeNotifier {
  String _flie = '';
  get flieChildAllowanceChoice => this._flie;

  set flieChildAllowanceChoice(value) {
    this._flie = value;
    notifyListeners();
  }

  void deleteflie() {
    this._flie = '';
    notifyListeners();
  }
}
