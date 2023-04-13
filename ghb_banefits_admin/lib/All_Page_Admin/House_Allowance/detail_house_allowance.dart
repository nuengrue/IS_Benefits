//import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ghb_banefits_admin/All_Models_Admin/house_model.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/House_Allowance/list_house_allowance.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_house.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

//import 'package:flutter/widgets.dart';

class DetailHouseAdminPage extends StatefulWidget {
  const DetailHouseAdminPage({super.key, required this.Notes,required this.Indexs});

  // Declare a field that holds the Todo.
  final HouseAllowanceAdmin Notes;
    final int Indexs;

  @override
  State<DetailHouseAdminPage> createState() => _DetailHouseAdminPageState();
}

class _DetailHouseAdminPageState extends State<DetailHouseAdminPage> {
 late String _status;
  late String _flagread;
  late int _Indexs;
  late String _payamount;
  final _formKey = GlobalKey<FormState>();
  late String _paydate;

  void ModifydataApprove() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _Indexs = widget.Indexs.toInt();
      _status = "Approve";
      _flagread = "1";
      _payamount = _payamount;
      _paydate = DateFormat.yMd().add_jm().format(DateTime.now());

      Provider.of<HouseAllowanceAdminProviders>(context, listen: false)
          .modify(_Indexs, _status, _flagread, _payamount, _paydate);
      print("done");

      final docStatus = FirebaseFirestore.instance
          .collection('HouseAllowance')
          .doc(widget.Notes.id);

      docStatus.update({
        'status': _status,
        'flagread': _flagread,
        'payamount': _payamount,
        'paydate': _paydate
      });

      Navigator.pop(
        context,
        MaterialPageRoute(
          builder: (context) => ListHouseAllowanceAdminPage(),
        ),
      );
    }
  }

  void ModifydataReject() async {
    _Indexs = widget.Indexs.toInt();
    _status = "Reject";
    _flagread = "1";
    _payamount = "0";
    _paydate = DateFormat.yMd().add_jm().format(DateTime.now());

    Provider.of<HouseAllowanceAdminProviders>(context, listen: false)
        .modify(_Indexs, _status, _flagread, _payamount, _paydate);
    print("done");

    final docStatus =
        FirebaseFirestore.instance.collection('HouseAllowance').doc(widget.Notes.id);

    docStatus.update(
        {'status': _status, 'flagread': _flagread,         'payamount': _payamount,
        'paydate': _paydate});

    Navigator.pop(
      context,
      MaterialPageRoute(
        builder: (context) => ListHouseAllowanceAdminPage(),
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
                      'รายการคำขอเบิกค่าเช่าบ้านสำหรับพนักงาน',
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
                              Navigator.push(context, MaterialPageRoute(builder: (context) => View(url: widget.Notes.fileUrl,)));
                            },

                    ),
 
                  
                  
                  ],
                ),
              ),
              SizedBox(
                height: 10,
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
                height: 10,
              ),

              SizedBox(
                height: 30,
              ),

              ///
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