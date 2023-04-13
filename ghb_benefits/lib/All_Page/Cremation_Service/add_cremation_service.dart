import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ghb_benefits/color.dart';
import 'package:ghb_benefits/All_Page/Cremation_Service/list_cremation_service.dart';
import 'package:ghb_benefits/All_Providers/provider_cremation.dart';
import 'package:ghb_benefits/pdf/files_page.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class AddCremationServicePage extends StatefulWidget {
  const AddCremationServicePage({Key? key}) : super(key: key);

  @override
  State<AddCremationServicePage> createState() =>
      _AddCremationServicePageState();
}

class _AddCremationServicePageState extends State<AddCremationServicePage> {
  _AddCremationServicePageState() {
    _selectedVal = _childName[0];
  }

  final _childName = [
    "เลือกเงื่อนไข",
    "ให้ได้รับเต็มจำนวนแต่เพียงผู้เดียว",
    "ให้ได้รับส่วนแบ่งเท่าๆ กัน"
  ];
  String? _selectedVal = "";

  final _formKey = GlobalKey<FormState>();
  TextEditingController _date = TextEditingController();

  bool visibilityTag = false;

  // value set to false
  bool _valueA = false;
  bool _valueB = false;
  bool _valueC = false;
  bool _value = false;

  void _changed(bool visibility, String field) {
    setState(() {
      if (field == "สมรส") {
        visibilityTag = visibility;
      }
    });
  }

  // List<Beneficiary> beneficiaryList = [];
  // void addBeneficiaryData(Beneficiary beneficiary) {
  //   setState(() {
  //     beneficiaryList.add(beneficiary);
  //   });
  //   print(beneficiaryList);
  //   //print(medtreatList.map((e) => medtreatList.forEach((element) {medtreat.email.toString();})));
  // }

  // void ShowUserDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (_) {
  //       return AlertDialog(
  //         content: AddBeneficiaryDialog(addBeneficiaryData),
  //         shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //       );
  //     },
  //   );
  // }

  final user = FirebaseAuth.instance.currentUser!;

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
  //
  late bool _readrules;
  //

  late String _age;
  late String _datebirth;
//
  late String _namepartner;
  //
  late bool _pay1;
  late bool _pay2;
  late bool _pay3;
  //

  late String _managername;
  late String _cardnumber;
  late String _relationship;
  late String _percentage;
  late String _conditions;
//

  ///
  late String _payamount;
  late String _paydate;
  late String _status;
  late String _email;
  late String _url;
  late String _filename;
  late String _flagread;
  late String _id;

  void AddCremationService() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _no = _no;
      _empcode = "57315";
      _name = "หนึ่งฤทัย พวงแก้ว";
      _department = "ฝ่ายพัฒนาระบบสารสนเทศ";
      _divisionment = "ส่วนสวัสดิการ";
      _idcard;
      _savedate = DateFormat.yMd().add_jm().format(DateTime.now());
      _housenumber;
      _alley;
      _road;
      _district;
      _county;
      _province;
      _tel;

      _readrules = _value;
      _age;
      _datebirth;
      _namepartner;
      _pay1 = _valueA;
      _pay2 = _valueB;
      _pay3 = _valueC;
      _managername;
      _cardnumber;
      _relationship;
      _percentage;
      _conditions = _selectedVal!;
//

      ///
      _payamount = "";
      _paydate = "";

      _status = "Request";
      _email = user.email!;
      _url = _url;
      _filename = _filename;
      _flagread = "0";
      _id = "";

      Provider.of<CremationServiceProviders>(context, listen: false)
          .addCremationService(
              _no,
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
              _url,
              _filename,
              _flagread,
              _id);

      //final docStatus = FirebaseFirestore.instance.collection('ChildAllowance');
      CollectionReference CremationService =
          FirebaseFirestore.instance.collection('CremationService');
      DocumentReference doc = await CremationService.add({
        'no': _no,
        'empcode': _empcode,
        'name': _name,
        'department': _department,
        'divisionment': _divisionment,
        'idcard': _idcard,
        'savedate': _savedate,
        'housenumber': _housenumber,
        'alley': _alley,
        'road': _road,
        'district': _district,
        'county': _county,
        'province': _province,
        'tel': _tel,
        'readrules': _readrules,
        'age': _age,
        'datebirth': _datebirth,
        'namepartner': _namepartner,
        'pay1': _pay1,
        'pay2': _pay2,
        'pay3': _pay3,
        'managername': _managername,
        'cardnumber': _cardnumber,
        'relationship': _relationship,
        'percentage': _percentage,
        'conditions': _conditions,
        'payamount': _payamount,
        'paydate': _paydate,
        'status': _status,
        'email': _email,
        'fileUrl': _url,
        'filename': _filename,
        'flagread': _flagread,
        'id': _id
      });
      doc.update({
        'id': doc.id,

        //'id' : result,
      });
    context.read<flieCremationServiceModal>().flieCremationServiceChoice = "";
      Navigator.pop(
        context,
        MaterialPageRoute(
          builder: (context) => ListCremationServicePage(),
        ),
      );
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
    context.read<flieCremationServiceModal>().flieCremationServiceChoice = filename;

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
                      'สร้างคำขอสมัครเข้าเป็นสมาชิกฌาปนกิจ',
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
                        Consumer<CremationServiceProviders>(
                          builder: (context, value, child) {
                            int Counts = 0;
                            String number_text = "";

                            Counts = value.CremationServiceList.length + 1;
                            _no = "200000" + Counts.toString();

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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'รหัสพนักงาน',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '57315',
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
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
                              'หนึ่งฤทัย พวงแก้ว',
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        maxLength: 13,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'เลขที่บัตรประชาชน',
                          labelText: 'เลขที่บัตรประชาชน',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'โปรดระบุเลขที่บัตรประชาชน';
                          } else if (value.length != 13) {
                            return 'โปรดระบุข้อมูล 13 ตัวอักษร';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (newValue) {
                          _idcard = newValue!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
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
                              DateFormat.yMd().add_jm().format(DateTime.now()),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
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
                      'ข้อมูลที่อยู่ปัจจุบันของพนักงาน',
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
                      child: TextFormField(
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'หมายเลขติดต่อ',
                          labelText: 'หมายเลขติดต่อ',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'โปรดระบุหมายเลขติดต่อ';
                          } else if (value.length > 10) {
                            return 'โปรดระบุข้อมูลไม่เกิน 10 ตัวอักษร';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (newValue) {
                          _tel = newValue!;
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
                          selected: _value,
                          value: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value as bool;
                            });
                          },
                        ), //CheckboxListTile
                      ), //Container
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
                      'ข้อมูลอายุของพนักงาน',
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
                        maxLength: 3,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'อายุของพนักงาน',
                          labelText: 'อายุของพนักงาน',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'โปรดระบุอายุของพนักงาน';
                          } else if (value.length >= 3) {
                            return 'โปรดระบุข้อมูลไม่เกิน 3 ตัวอักษร';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (newValue) {
                          _age = newValue!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          maxLength: 10,
                          controller: _date,
                          //keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            //border: OutlineInputBorder(),
                            icon: Icon(Icons.calendar_today_rounded),

                            hintText: 'วันที่เกิดของพนักงาน',
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
                                    DateFormat('yyyy-MM-dd').format(pickddate);
                                //var _date = DateFormat("dd-MM-yyyy").format(now);
                              });
                            }
                          },
                          onSaved: (newValue) => _datebirth = newValue!,
                        ),
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
                        maxLength: 50,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'ชื่อ-นามสกุลของคู่มสมรส',
                          labelText: 'ชื่อ-นามสกุลของคู่มสมรส',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'โปรดระบุชื่อ-นามสกุลของคู่มสมรส';
                          } else if (value.length >= 50) {
                            return 'โปรดระบุข้อมูลไม่เกิน 50 ตัวอักษร';
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
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'นามสกุลของคู่มสมรส',
                          labelText: 'นามสกุลของคู่มสมรส',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'โปรดระบุนามสกุลของคู่มสมรส';
                          } else if (value.length >= 4) {
                            return 'โปรดระบุข้อมูลไม่เกิน 50 ตัวอักษร';
                          } else {
                            return null;
                          }
                        },
                        //  onSaved: (newValue) {_cvvs = newValue!;},
                      ),
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
                          selected: _valueA,
                          value: _valueA,
                          onChanged: (value) {
                            setState(() {
                              _valueA = value as bool;
                            });
                          },
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
                          selected: _valueB,
                          value: _valueB,
                          onChanged: (value) {
                            setState(() {
                              _valueB = value as bool;
                            });
                          },
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
                          selected: _valueC,
                          value: _valueC,
                          onChanged: (value) {
                            setState(() {
                              _valueC = value as bool;
                            });
                          },
                        ), //CheckboxListTile
                      ), //Container
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              /*
Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.greenAccent),
                  borderRadius: BorderRadius.circular(20),
                ), //BoxDecoration
                 
                /** CheckboxListTile Widget **/
                child: CheckboxListTile(
                  title: const Text('ชำระเงินเป็นค่าสมัครเข้าเป็นสมาชิก เป็นเงิน 100 บาท'),
                  //subtitle: const Text('A computer science portal for geeks.'),
                  //secondary: const Icon(Icons.code),
                  autofocus: false,
                  activeColor: iOrangeColor,
                  checkColor: Colors.white,
                  selected: _valueA,
                  value: _valueA,
                  onChanged: (value) {
                                    setState(() {
                                      _valueA = value as bool;
                                    });
                                  },
                ), //CheckboxListTile
              ), //Container
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.greenAccent),
                  borderRadius: BorderRadius.circular(20),
                ), //BoxDecoration
                 
                /** CheckboxListTile Widget **/
                child: CheckboxListTile(
                  title: const Text('ชำระเงินสงเคราะห์ล่วงหน้าตามอัตราที่ทางการฌาปนกิจสงเคราะห์ ธนาคารอาคารสงเคราะห์ เรียกเก็บเป็นเงิน 300 บาท'),
                  //subtitle: const Text('A computer science portal for geeks.'),
                  //secondary: const Icon(Icons.code),
                  autofocus: false,
                  activeColor: iOrangeColor,
                  checkColor: Colors.white,
                  selected: _valueB,
                  value: _valueB,
                  onChanged: (value) {
                                    setState(() {
                                      _valueB = value as bool;
                                    });
                                  },
                ), //CheckboxListTile
              ), //Container
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.greenAccent),
                  borderRadius: BorderRadius.circular(20),
                ), //BoxDecoration
                 
                /** CheckboxListTile Widget **/
                child: CheckboxListTile(
                  title: const Text('ชำระเงินสงเคราะห์ศพเป็นไปตามอัตราที่ทางการฌาปนกิจสงเคราะห์ ธนาคารอาคารสงเคราะห์เรียกเก็บ'),
                  //subtitle: const Text('A computer science portal for geeks.'),
                  //secondary: const Icon(Icons.code),
                  autofocus: false,
                  activeColor: iOrangeColor,
                  checkColor: Colors.white,
                  selected: _valueC,
                  value: _valueC,
                  onChanged: (value) {
                                    setState(() {
                                      _valueC = value as bool;
                                    });
                                  },
                ), //CheckboxListTile
              ), //Container
            ),
            */
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
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        maxLength: 100,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'ชื่อ-นามสกุล',
                          labelText: 'ชื่อ-นามสกุล',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'โปรดระบุชื่อ-นามสกุล';
                          } else if (value.length >= 100) {
                            return 'โปรดระบุข้อมูลไม่เกิน 100 ตัวอักษร';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (newValue) {
                          _managername = newValue!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        maxLength: 13,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'เลขที่บัตรประชาชน',
                          labelText: 'เลขที่บัตรประชาชน',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'โปรดระบุเลขที่บัตรประชาชน';
                          } else if (value.length > 13) {
                            return 'โปรดระบุข้อมูล 13 ตัวอักษร';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (newValue) {
                          _cardnumber = newValue!;
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
                          hintText: 'ความเกี่ยวข้องกับพนักงาน',
                          labelText: 'ความเกี่ยวข้องกับพนักงาน',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'โปรดระบุความเกี่ยวข้องกับพนักงาน';
                          } else if (value.length >= 50) {
                            return 'โปรดระบุข้อมูลไม่เกิน 50 ตัวอักษร';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (newValue) {
                          _relationship = newValue!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        maxLength: 5,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'ร้อยละ',
                          labelText: 'ร้อยละ',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'โปรดระบุร้อยละ';
                          } else if (value.length == 5) {
                            return 'โปรดระบุข้อมูล 5 ตัวอักษร';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (newValue) {
                          _percentage = newValue!;
                        },
                      ),
                    ),
                    /*
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'ข้อมูลรับผลประโยชน์',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 9, 28, 235),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: IconButton(
                                  icon: const Icon(Icons.add),
                                  // tooltip: 'Show Snackbar',
                                  onPressed: ShowUserDialog,
                                  // onPressed: () {
                                  // Navigator.of(context).push(
                                  //     MaterialPageRoute(builder: (context) => AddMedPage()));
                                  //},
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          
                           Container(
                      height: MediaQuery.of(context).size.height * 0.20,
                      width: 500,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
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
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'ชื่อ-นามสกุล',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          beneficiaryList[index].name,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'อยู่ที่',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          beneficiaryList[index].housenumber,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                /*
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'ตรอก/ซอย',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          beneficiaryList[index].housenumber,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'ถนน',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          beneficiaryList[index].alley,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'ตำบล/แขวง',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          beneficiaryList[index].district,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'อำเภอ/เขต',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          beneficiaryList[index].county,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'จังหวัด',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          beneficiaryList[index].province,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                */
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'หมายเลขติดต่อ',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          beneficiaryList[index].phonenumber,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'ความเกี่ยวข้อง',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          beneficiaryList[index].relationship,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );

                        },
                        itemCount: beneficiaryList.length,
                      ),
                    ),
                        ],
                      ),
                    ),
                    */
/*
                    Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: 500,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
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
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'ชื่อ-นามสกุล',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          beneficiaryList[index].name,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'บ้านเลขที่',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          beneficiaryList[index].housenumber,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'ตรอก/ซอย',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          beneficiaryList[index].housenumber,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'ถนน',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          beneficiaryList[index].alley,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'ตำบล/แขวง',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          beneficiaryList[index].district,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'อำเภอ/เขต',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          beneficiaryList[index].county,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'จังหวัด',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          beneficiaryList[index].province,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'หมายเลขติดต่อ',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          beneficiaryList[index].phonenumber,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'ความเกี่ยวกับพนักงาน',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          beneficiaryList[index].relationship,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );

                        },
                        itemCount: beneficiaryList.length,
                      ),
                    ),
*/
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
                            'การแบ่งผู้รับเงินฌาปนกิจ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 9, 28, 235),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Divider(),
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
                            'เอกสารแนบ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 9, 28, 235),
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
                          Consumer<flieCremationServiceModal>(
                            builder: (context, value, child) {
                              //String Carimg = '';
                              if (value.flieCremationServiceChoice
                                  .toString()
                                  .isNotEmpty) {
                                //Carimg = '${value.flieCremationServiceChoice}';
                                return ListTile(
                                  title: Text(_filename.toString()),
                                  trailing: Icon(Icons.remove_red_eye),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                View(url: _url)));
                                  },
                                );
                              } else {
                                return Text("");
                              }
                            },
                          ),
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
                      child: Text("บันทึกข้อมูล"),
                      onPressed: () {
                        AddCremationService();
                      },
                    ),

                    //               SizedBox(
                    //   height: 10,
                    // ),
                    //       SizedBox(
                    //         height: 10,
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    //         child: GestureDetector(
                    //           onTap: AddCremationService,
                    //           child: Container(
                    //             padding: EdgeInsets.all(20),
                    //             decoration: BoxDecoration(
                    //               color: iBlueColor,
                    //               borderRadius: BorderRadius.circular(12),
                    //             ),
                    //             child: Center(
                    //               child: Text(
                    //                 'บันทึกข้อมูล',
                    //                 style: TextStyle(
                    //                     color: iWhiteColor,
                    //                     fontWeight: FontWeight.bold,
                    //                     fontSize: 18),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         height: 50,
                    //       ),

                    ///
                  ],
                ),
              ),
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

class flieCremationServiceModal extends ChangeNotifier {
  String _flie = '';
  get flieCremationServiceChoice => this._flie;

  set flieCremationServiceChoice(value) {
    this._flie = value;
    notifyListeners();
  }
}
