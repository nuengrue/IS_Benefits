//import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ghb_banefits_admin/All_Models_Admin/child_allowane_model.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Child_Allowances/list_child_allowance.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_child_allowance.dart';
import 'package:provider/provider.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

//import 'package:flutter/widgets.dart';

class DetailChildAllowanceAdminPage extends StatefulWidget {
  const DetailChildAllowanceAdminPage(
      {super.key, required this.Notes, required this.Indexs});

  // Declare a field that holds the Todo.
  final ChildAllowanceAdmin Notes;
  final int Indexs;

  @override
  State<DetailChildAllowanceAdminPage> createState() =>
      _DetailChildAllowanceAdminPageState();
}

class _DetailChildAllowanceAdminPageState
    extends State<DetailChildAllowanceAdminPage> {
  late String _status;
  late String _flagread;
  late int _Indexs;
  void ModifydataApprove() async {
    _Indexs = widget.Indexs.toInt();
    _status = "Approve";
    _flagread = "1";

    Provider.of<ChildAllowanceAdminProviders>(context, listen: false)
        .modify(_Indexs, _status, _flagread);
    print("done");

    final docStatus = FirebaseFirestore.instance
        .collection('ChildAllowance')
        .doc(widget.Notes.id);

    docStatus.update({'status': _status, 'flagread': _flagread});

    Navigator.pop(
      context,
      MaterialPageRoute(
        builder: (context) => ListChildAllowanceAdminPage(),
      ),
    );
  }

  void ModifydataReject() async {
    _Indexs = widget.Indexs.toInt();
    _status = "Reject";
    _flagread = "1";
    print(_status);
    print(_flagread);
    print(_Indexs);

    Provider.of<ChildAllowanceAdminProviders>(context, listen: false)
        .modify(_Indexs, _status, _flagread);
    print("done");

    final docStatus = FirebaseFirestore.instance
        .collection('ChildAllowance')
        .doc(widget.Notes.id);

    docStatus.update({'status': _status, 'flagread': _flagread});

    Navigator.pop(
      context,
      MaterialPageRoute(
        builder: (context) => ListChildAllowanceAdminPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายละเอียดรายการ'),
      ),
      body: SingleChildScrollView(
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
                    'รายการคำขอเบิกเงินค่าช่วยเหลือบุตร',
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
                          'เลขที่รายการ',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.Notes.no,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
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
                          widget.Notes.nameemp,
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
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'ชื่อ-นามสกุลของคู่มสมรส',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.Notes.namepartner,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'สถานะการสมรส',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.Notes.maritalstatus,
                            textAlign: TextAlign.end,
                          ),
                          Text(
                            widget.Notes.submaritalstatus,
                            textAlign: TextAlign.end,
                          ),
                        ],
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
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    title: Text(widget.Notes.filename.toString()),
                    //subtitle:Text(widget.Indexs.toString()),
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

            Column(children: [
              if (widget.Notes.status == "Request") ...[
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
              height: 30,
            ),

          ],
        ),
      ),
    );
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
