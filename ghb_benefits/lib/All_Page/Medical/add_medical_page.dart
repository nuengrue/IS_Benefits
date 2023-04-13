import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ghb_benefits/All_Page/Medical/list_medical_page.dart';
import 'package:ghb_benefits/All_Providers/provider_medical.dart';
import 'package:ghb_benefits/color.dart';
import 'package:ghb_benefits/medical/user.dart';
import 'package:ghb_benefits/pdf/files_page.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class AddMedPage extends StatefulWidget {
  const AddMedPage({Key? key}) : super(key: key);

  @override
  State<AddMedPage> createState() => _AddMedPageState();
}

class _AddMedPageState extends State<AddMedPage> {
  _AddMedPageState() {
    _selectedVal = _hotpitalName[0];
    _selectedValD = _diseaseName[0];
    _selectedValT = _treatmentName[0];
    _selectedValType = _hotpitalNameType[0];
  }
  final List<String> _hotpitalName = [
    "โรงพยาบาลเปาโลเมโมเรียล",
    "โรงพยาบาลเปาโลเมโมเรียล โชคชัย 4",
    "โรงพยาบาลเปาโลรังสิต",
    "โรงพยาบาลพญาไท 1"
  ];
  final List<String> _hotpitalNameType = ["รัฐบาล", "เอกชน"];
  final List<String> _diseaseName = [
    "มะเร็งปากมดลูก",
    "เจ็บคอ",
    "ไข้เลือดออก",
    "ต่อมน้ำเหลืองอักเสบ",
    "มะเร็งเต้านม",
    "ไข้เลือดออก ",
    "ไข้หวัด",
    "กรดไหลย้อน",
    "กรวยไตอักเสบ"
  ];
  final List<String> _treatmentName = [
    "ค่ายาและค่ารักษา",
    "ค่าห้องและค่าอาหาร",
    "ค่าอุปกรณ์"
  ];
  String? _selectedVal = "";
  String? _selectedValD = "";
  String? _selectedValT = "";
  String? _selectedValType = "";
  List<Medtreat> medtreatList = [];

  final user = FirebaseAuth.instance.currentUser!;
  late String _no;
  late String _empcode;
  late String _name;
  late String _department;
  late String _divisionment;
  late String _savedate;
  late String _numbercodemed;
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
  late String _payamount;
  late String _paydate;

  late String _status;
  late String _email;
 // late List<Medtreat> _cedtreat;
  late String _url;
  late String _filename;
  late String _flagread;
  late String _id;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _dates = TextEditingController();
  TextEditingController _datee = TextEditingController();
  void addMedical() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _no = _no;
      _empcode = "57315";
      _name = "หนึ่งฤทัย พวงแก้ว";
      _department = "ฝ่ายพัฒนาระบบสารสนเทศ";
      _divisionment = "ส่วนสวัสดิการ";
      _numbercodemed = "0";     
      _savedate = DateFormat.yMd().add_jm().format(DateTime.now());
      _typemed = "ขอเบิก";
      _yearmed = DateFormat.y().format(DateTime.now());
      _hospitalname = _selectedVal!;
      _hospitaltype = _selectedValType!;
      _claimstartdate;
      _claimenddate;
      _idreceiptnumber;
      _receiptnumber;
      _tel;
      _namedisease = _selectedValD!;
      _diseasegroup = "0";      
      _receiptamount ;
      _payamount = "0";
      _paydate = "0";
      _status = "Request";

      _email = user.email!;
   //   _cedtreat = medtreatList;
      _url = _url;
      _filename = _filename;
      _flagread = "0";
      _id = "";

      Provider.of<MedicalProviders>(context, listen: false).addMedical(
      _no,
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
      _url,
      _filename,
      _flagread,
      _id);

      //final docStatus = FirebaseFirestore.instance.collection('ChildAllowance');
      CollectionReference Medical =
          FirebaseFirestore.instance.collection('Medical');
      DocumentReference doc = await Medical.add({
        'no': _no,

        'empcode': _empcode,
        'name': _name,
        'department': _department,
        'divisionment': _divisionment,
        'numbercodemed': _numbercodemed,
        'savedate': _savedate,
        'typemed': _typemed,
        'yearmed': _yearmed,
        'hospitalname': _hospitalname,
        'hospitaltype': _hospitaltype,
        'claimstartdate': _claimstartdate,
        'claimenddate': _claimenddate,
        'idreceiptnumber': _idreceiptnumber,
        'receiptnumber': _receiptnumber,
        'tel': _tel,
        'namedisease': _namedisease,
        'diseasegroup': _diseasegroup,
        'receiptamount': _receiptamount,
        'payamount': _payamount,
        'paydate': _paydate,
        'status': _status,
        'email': _email,
        'fileUrl': _url,
        'filename': _filename,
        'flagread': _flagread,
        'id': _id
        //'Medtreat': _cedtreat.map((i) => i.toMap()).toList(),
      });
      doc.update({
        'id': doc.id,

        //'id' : result,
      });

      context.read<flieMedicalModal>().flieMedicalChoice = '';
      //Provider.of<ChildAllowaneProviders>(context,listen: false).addNotes(_Title.text, _Description.text);

      //Navigator.of(context).pop();
      Navigator.pop(
        context,
        MaterialPageRoute(
          builder: (context) => ListMedicalPage(),
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
    context.read<flieMedicalModal>().flieMedicalChoice = filename;

    // await FirebaseFirestore.instance
    // .collection("file")
    // .doc()
    // .set({'fileUrl':url,'num' : "file FDF" + filename.toString()});
    // //.set({'fileUrl':url,'num' : "file FDF" + number.toString()});
  }

  @override
  Widget build(BuildContext context) {
//     void addMedData(Medtreat medtreat) {
//       setState(() {
//         medtreatList.add(medtreat);

//         for(int i = 0; i < medtreatList.length; i++)
//         {

//         }
// //medtreatList.length,
//       });
//       print(medtreatList);
//       //print(medtreatList.map((e) => medtreatList.forEach((element) {medtreat.email.toString();})));
//     }

    // void ShowUserDialog() {
    //   showDialog(
    //     context: context,
    //     builder: (_) {
    //       return AlertDialog(
    //         content: AddMedDialog(addMedData),
    //         shape:
    //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    //       );
    //     },
    //   );
    // }

    // Scaffold is a layout for
    // the major Material Components.
    return Scaffold(
      appBar: AppBar(
        title: Text('สร้างรายการคำขอ'),
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
                      'สร้างคำขอเงินช่วยเหลือการศึกษาบุตร',
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
                        Consumer<MedicalProviders>(
                          builder: (context, value, child) {
                            int Counts = 0;
                            String number_text = "";

                            Counts = value.MedicalList.length + 1;
                            _no = "400000" + Counts.toString();

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
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'ประเภทคำร้องขอ',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'ขอเบิก',
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
                            DateFormat.yMd().format(DateTime.now()),
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
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            DateFormat.y().format(DateTime.now()),
                            textAlign: TextAlign.end,
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
                      ),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'โรงพยาบาล',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        DropdownButton(
                          value: _selectedVal,
                          items: _hotpitalName
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
                      ],
                    ),
                    Row(
                      children: [
                        DropdownButton(
                          value: _selectedValType,
                          items: _hotpitalNameType
                              .map((e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              _selectedValType = val as String;
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
                      ),
                    ),
                    const Divider(),
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text('เลขที่ใบเสร็จ'),
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
                            onSaved: (newValue) => _idreceiptnumber = newValue!,
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

                            onSaved: (newValue) => _receiptnumber = newValue!,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text('หมายเลขติดต่อกลับ'),
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
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            maxLength: 10,
                            controller: _dates,
                            //keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              //border: OutlineInputBorder(),
                              icon: Icon(Icons.calendar_today_rounded),

                              hintText: 'วันที่เริ่มต้นการรักษา',
                            ),
                            onTap: () async {
                              DateTime? pickddate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2022),
                                  lastDate: DateTime(9999));

                              if (pickddate != null) {
                                setState(() {
                                  _dates.text = DateFormat('yyyy-MM-dd')
                                      .format(pickddate);
                                  //var _date = DateFormat("dd-MM-yyyy").format(now);
                                });
                              }
                            },
                            onSaved: (newValue) => _claimstartdate = newValue!,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            maxLength: 10,
                            controller: _datee,
                            //keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              //border: OutlineInputBorder(),
                              icon: Icon(Icons.calendar_today_rounded),

                              hintText: 'วันที่สิ้นสุดการรักษา',
                            ),
                            onTap: () async {
                              DateTime? pickddate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2022),
                                  lastDate: DateTime(9999));

                              if (pickddate != null) {
                                setState(() {
                                  _datee.text = DateFormat('yyyy-MM-dd')
                                      .format(pickddate);
                                  //var _date = DateFormat("dd-MM-yyyy").format(now);
                                });
                              }
                            },
                            onSaved: (newValue) => _claimenddate = newValue!,
                          ),
                        ),
                        /*
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text('วันที่เริ่มต้นการรักษา'),
                          ),
                          
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              maxLength: 10,
                              //controller: _amountc,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'ระบุวันที่เริ่มต้นการรักษา',
                              ),
        
                               onSaved: (newValue) => _claimstartdate = newValue!,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text('วันที่สิ้นสุดการรักษา'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              maxLength: 10,
                              //controller: _amountc,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'ระบุวันที่สิ้นสุดการรักษา',
                              ),
        
                               onSaved: (newValue) => _claimenddate = newValue!,
                            ),
                          ),
                          */
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
                      ),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'โรค',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton(
                            value: _selectedValD,
                            items: _diseaseName
                                .map((e) => DropdownMenuItem(
                                      child: Text(e),
                                      value: e,
                                    ))
                                .toList(),
                            onChanged: (val) {
                              setState(() {
                                _selectedValD = val as String;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
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
                            'รายการรักษาพยาบาล',
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
                      height: MediaQuery.of(context).size.height * 0.25,
                      //width: 430,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Card(
                            margin: EdgeInsets.all(4),
                            elevation: 8,
                            child: ListTile(
                              title: Text(medtreatList[index].medicallist),
                              subtitle: Text(medtreatList[index].numberdays),
                              trailing: Text(medtreatList[index].amount),
                            ),
                          );
                        },
                        itemCount: medtreatList.length,
                      ),
                    ),
                    /*  Row(
                      children: [
                        Expanded(
                          child: Text(
                            'รายการรักษาพยาบาล',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton(
                            value: _selectedValT,
                            items: _treatmentName
                                .map((e) => DropdownMenuItem(
                                      child: Text(e),
                                      value: e,
                                    ))
                                .toList(),
                            onChanged: (val) {
                              setState(() {
                                _selectedValT = val as String;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Form(
                      // key: _formKey,
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text('จำนวนวันรักษาพยาบาล'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              maxLength: 150,
                              //controller: _addressc,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'ระบุจำนวนวันรักษาพยาบาล',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'โปรดระบุจำนวนวันรักษาพยาบาล';
                                }
                              },
                              // onSaved: (newValue) => _address = newValue!,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text('จำนวนเงิน'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              maxLength: 10,
                              //controller: _amountc,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'ระบุจำนวนเงิน',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'โปรดระบุจำนวนเงิน';
                                }
                              },
                              // onSaved: (newValue) => _amount = newValue!,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text('หมายเหตุอื่นๆ'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              maxLength: 10,
                              //controller: _amountc,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'หมายเหตุอื่นๆ',
                              ),
        
                              // onSaved: (newValue) => _amount = newValue!,
                            ),
                          ),
                        ],
                      ),
                    ),
                    */
                  ],
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
                      'ข้อมูลจำนวนเงิน',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 9, 28, 235),
                        fontWeight: FontWeight.bold,
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
                          child: Text('จำนวนเงินตามใบเสร็จ'),
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
                            onSaved: (newValue) => _receiptamount = newValue!,
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
                    Consumer<flieMedicalModal>(
                      builder: (context, value, child) {
                        if (value.flieMedicalChoice.toString().isNotEmpty) {
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
                  addMedical();
                },
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
              //   child: GestureDetector(
              //     onTap: addMedical,
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
              /*
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(MaterialPageRoute(
                        builder: (context) => DetailMedicalPage()));
                  },
                  child: Text('บันทึกข้อมูล'),
                ),
              ),
              */
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
        title: Text("PDF View"),
      ),
      body: SfPdfViewer.network(
        url,
        controller: _pdfViewerController,
      ),
    );
  }
}

class flieMedicalModal extends ChangeNotifier {
  String _flie = '';
  get flieMedicalChoice => this._flie;

  set flieMedicalChoice(value) {
    this._flie = value;
    notifyListeners();
  }
}
