import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ghb_banefits_admin/All_Models_Admin/education_model.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Education/list_education_page.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_education.dart';
import 'package:ghb_banefits_admin/color.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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
  late String _status;
  late String _flagread;
  late int _Indexs;
  late String _payamount;
  final _formKey = GlobalKey<FormState>();
  late String _paydate;
  late final String _title = "แจ้งผลรายการคำขอเบิกค่ารักษาพยาบาล";
  late String _content;
   final String _createDate = DateFormat('dd-MM-yyyy  kk:mm').format(DateTime.now());
  late String _id = "";
  late String _uid;
  void ModifydataApprove() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _Indexs = widget.Indexs.toInt();
      _status = "อนุมัติ";
      _flagread = "1";
      _payamount = _payamount;
      _paydate = DateFormat.yMd().add_jm().format(DateTime.now());

      Provider.of<EducationAdminProviders>(context, listen: false)
          .modify(_Indexs, _status, _flagread, _payamount, _paydate);
      print("done");

      final docStatus = FirebaseFirestore.instance
          .collection('Education')
          .doc(widget.Notes.id);

      docStatus.update({
        'status': _status,
        'flagread': _flagread,
        'payamount': _payamount,
        'paydate': _paydate
      });
   _content = "คำขอเบิกค่ารักษาพยาบาล  เลขที่ใบเสร็จ "+  widget.Notes.receiptnumber + "ได้รับการอนุมัติจำนวน "+ widget.Notes.payamount + " บาท" ;
     _uid = widget.Notes.email;
          CollectionReference Notifications =
          FirebaseFirestore.instance.collection('Notifications');
      DocumentReference doc = await Notifications.add({
        'no': 1,
        'title': _title,
        'content': _content,
        'read': 0,
        'createDate': _createDate,
        'uid': _uid,
        'id': _id
      });
      doc.update({
        'id': doc.id,
      });
      Navigator.pop(
        context,
        MaterialPageRoute(
          builder: (context) => ListEducationAdminPage(Status:"ร้องขอ"),
        ),
      );
    }
  }

  void ModifydataReject() async {
    _Indexs = widget.Indexs.toInt();
    _status = "ปฏิเสธ";
    _flagread = "1";
    _payamount = "0";
    _paydate = DateFormat.yMd().add_jm().format(DateTime.now());

    Provider.of<EducationAdminProviders>(context, listen: false)
        .modify(_Indexs, _status, _flagread, _payamount, _paydate);
    print("done");

    final docStatus =
        FirebaseFirestore.instance.collection('Education').doc(widget.Notes.id);

    docStatus.update(
        {'status': _status, 'flagread': _flagread, 'paydate': _paydate});

    Navigator.pop(
      context,
      MaterialPageRoute(
        builder: (context) => ListEducationAdminPage(Status:"ร้องขอ"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for
    // the major Material Components.
    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียดคำขอช่วยเหลือการศึกษา',style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                            color: iWhiteColor,
                          ),),
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
                    SizedBox(height: 10),
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
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.typeedu,
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
                            'วงเงินประจำปี',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.yearedu,
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
                      'ข้อมูลบุตร',
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
                            'บุตรของพนักงาน',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.namechild,
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
                      'ข้อมูลการศึกษา',
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
                            'ปีการศึกษา',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.year,
                            textAlign: TextAlign.end,
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
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.term,
                            textAlign: TextAlign.end,
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
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              widget.Notes.school,
                              textAlign: TextAlign.end,
                            ),
                            Text(
                              widget.Notes.schooltype,
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
                            'ระดับการศึกษา',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.educationlevel,
                            textAlign: TextAlign.end,
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
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.level,
                            textAlign: TextAlign.end,
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'เลขที่ใบเสร็จ',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.receiptnumber,
                            textAlign: TextAlign.end,
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
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.volume,
                            textAlign: TextAlign.end,
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
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.tel,
                            textAlign: TextAlign.end,
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
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.Notes.receiptdate,
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
                      'ข้อมูลจำนวนเงิน',
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
                              'จำนวนเงินตามใบเสร็จ',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.Notes.amountreceipt,
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
                          if (widget.Notes.status == "ร้องขอ") ...[
                            Expanded(
                              child: Text(
                                'จำนวนเงินจ่าย',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
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
                                      return 'โปรดระบุจำนวนเงินจ่าย';
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
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.Notes.payamount,
                                textAlign: TextAlign.end,
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
  child:Scaffold(
body: SfPdfViewer.network(
      widget.url,
      controller: _pdfViewerController,
    ),
    appBar: AppBar(
              title: Text('รายละเอียดเอกสาร',style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                            color: iWhiteColor,
                          ),),
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