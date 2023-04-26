import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ghb_benefits/All_Controllers/master_controllers.dart';
import 'package:ghb_benefits/All_Models/employee_model.dart';
import 'package:ghb_benefits/All_Page/Child_Allowances/list_child_allowance.dart';
import 'package:ghb_benefits/All_Providers/provider_child_allowance.dart';
import 'package:ghb_benefits/All_Providers/provider_master.dart';
import 'package:ghb_benefits/All_Services/servics.dart';
import 'package:ghb_benefits/color.dart';
import 'package:ghb_benefits/pdf/files_page.dart';
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

  void initState() {
    super.initState();
    _getMaster(context);
  }

  void _getMaster(BuildContext context) async {
    var newEmployee = await mastecontroller.fetchEmployee();
    context.read<EmployeeProviders>().EmployeeList = newEmployee;
    var newChilder = await mastecontroller.fetchChilder();
    context.read<ChilderProviders>().ChilderList = newChilder;
  }

  _AddChildAllowancePageState() {
    _selectedVal = _childName[0];
    _selectedpartner = _childpartner[0];
    _selectedstatuspartner = _childstatuspartner[0];
  }

  final _childName = [
    "เลือกบุตร",
    "ด.ช. น้ำใจ มาดี",
    "ด.ช. อุ่นใจ มาดี",
    "ด.ช. ตาใจ มาดี"
  ];
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
  late String _status;
  late String _email;
  late String _url;
  late String _filename;
  late String _flagread;
  late String _id;

  void AddChildAllowance() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _no = _no;
      _empcode = "57315";
      _nameemp = "หนึ่งฤทัย พวงแก้ว";
      _department = "ฝ่ายพัฒนาระบบสารสนเทศ";
      _divisionment = "ส่วนสวัสดิการ";
      _savedate = DateFormat.yMd().add_jm().format(DateTime.now());
      _namechild = _selectedVal!;
      _namepartner;
      _officetner;
      _maritalstatus = _selectedpartner!;
      if (_selectedstatuspartner == "เลือกสถานะ") {
        _submaritalstatus = "-";
      } else {
        _submaritalstatus = _selectedstatuspartner!;
      }
      _status = "Request";
      //print(_status);
      _email = user.uid;
      _url = _url;
      _filename = _filename;
      _flagread = "0";
      _id = "";

      Provider.of<ChildAllowanceProviders>(context, listen: false)
          .addChildAllowane(
              _no,
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
              _id);

      CollectionReference ChildAllowance =
          FirebaseFirestore.instance.collection('ChildAllowance');
      DocumentReference doc = await ChildAllowance.add({
        'no': _no,
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
        'id': _id
      });
      doc.update({
        'id': doc.id,
      });

      context.read<flieChildAllowanceModal>().flieChildAllowanceChoice = '';

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

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for
    // the major Material Components.
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มรายการ'),
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
                      ),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'เลขที่',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Consumer<ChildAllowanceProviders>(
                          builder: (context, value, child) {
                            int Counts = 0;
                            String number_text = "";

                            Counts = value.ChildAllowanceList.length + 1;
                            _no = "100000" + Counts.toString();

                            return Expanded(
                              child: Text(
                                _no.toString(),
                                textAlign: TextAlign.end,
                              ),
                            );
                          },
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
                          // child: Consumer<EmployeeProviders>(builder: (context,value, child) {
                          //   final Employee  Etest;
                          //   Etest =  value.EmployeeList as Employee;
                          // return  Text(
                          // Etest.nameemp,
                          //   textAlign: TextAlign.end,
                          // );
                          // },),
                          child: Text(
                            'หนึ่งฤทัย พวงแก้ว',
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
                              'ฝ่ายทรัพยากรบุคคล',
                              textAlign: TextAlign.end,
                            ),
                            Text(
                              'ส่วนสวัสดิการ',
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
                            DateFormat.yMd().format(DateTime.now()),
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
                                  fontWeight: FontWeight.bold),
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
                                  fontWeight: FontWeight.bold),
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
                      ),
                    ),
                    const Divider(),
                    ElevatedButton(
                      child: Text("เอกสารแนบ"),
                      onPressed: () {
                        uploadDataToFirebase();
                      },
                    ),
                    const Divider(),
                    Consumer<flieChildAllowanceModal>(
                      builder: (context, value, child) {
                        if (value.flieChildAllowanceChoice
                            .toString()
                            .isNotEmpty) {
                          //Carimg = '${value.flieChildAllowanceChoice}';
                          return ListTile(
                            title: Text(_filename.toString()),
                            trailing: Icon(Icons.remove_red_eye),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => View(url: _url)));
                            },
                          );
                        } else {
                          return Text("");
                        }
                      },
                    ),
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
                child: Text('บันทึกข้อมูล'),
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
        title: Text("PDF View"),
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
}
