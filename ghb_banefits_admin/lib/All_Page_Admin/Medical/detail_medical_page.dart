import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ghb_banefits_admin/All_Models_Admin/medical_model.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Medical/list_medical_page.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_child_allowance.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_medical.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';




class DetailMedicalAdminPage extends StatefulWidget {
  const DetailMedicalAdminPage({super.key, required this.Notes,required this.Indexs});

  // Declare a field that holds the Todo.
  final MedicalAdmin Notes;
  final int Indexs;

  @override
  State<DetailMedicalAdminPage> createState() => _DetailMedicalAdminPageState();
}

class _DetailMedicalAdminPageState extends State<DetailMedicalAdminPage> {
late String _status;
late String _flagread;
late int _Indexs;
  late String _payamount;
  final _formKey = GlobalKey<FormState>();
    late String  _paydate;
  
  void ModifydataApprove()  async{
        if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
     _Indexs = widget.Indexs.toInt();
     _status = "Approve";
     _flagread = "1";
     _payamount = _payamount;
       _paydate = DateFormat.yMd().add_jm().format(DateTime.now());


           Provider.of<MedicalAdminProviders>(context, listen: false)
          .modify(
              _Indexs,
              _status,
              _flagread,
              _payamount,
              _paydate);
              print("done");
              
    final docStatus = FirebaseFirestore.instance.collection('Medical').doc(widget.Notes.id);
    
                          docStatus.update({
                            'status':  _status,
                            'flagread': _flagread,
                            'payamount': _payamount,
                            'paydate': _paydate

                          });

                    Navigator.pop(
        context,
        MaterialPageRoute(
          builder: (context) => ListMedicalAdminPage(),
        ),
      );
        }
  }

    void ModifydataReject()  async{
     _Indexs = widget.Indexs.toInt();
     _status = "Reject";
     _flagread = "1";
     _payamount = "0";
     _paydate = DateFormat.yMd().add_jm().format(DateTime.now());


           Provider.of<MedicalAdminProviders>(context, listen: false)
          .modify(
              _Indexs,
              _status,
              _flagread,
              _payamount,
              _paydate);
              print("done");
              
    final docStatus = FirebaseFirestore.instance.collection('Medical').doc(widget.Notes.id);
    
                          docStatus.update({
                            'status':  _status,
                            'flagread': _flagread,
                            'paydate': _paydate

                          });

                    Navigator.pop(
        context,
        MaterialPageRoute(
          builder: (context) => ListMedicalAdminPage(),
        ),
      );
  }
  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for
    // the major Material Components.
    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียดรายการ'),
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
                      'รายการคำขอเงินช่วยเหลือค่ารักษาพยาบาล',
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
                          widget.Notes.typemed,
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
                          widget.Notes.yearmed,
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
                          'ชื่อโรงพยาบาล',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.Notes.hospitalname,
                            textAlign: TextAlign.end,
                          ),
                          Text(
                            widget.Notes.hospitaltype,
                            textAlign: TextAlign.end,
                          ),
                        ],
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
                          widget.Notes.idreceiptnumber,
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
                          'วันที่เริ่มต้นการรักษา',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.Notes.claimstartdate,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'วันที่สิ้นสุดการรักษา',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.Notes.claimenddate,
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
                    'รายการโรค/กลุ่มโรค',
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
                          'รหัสโรค',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.listdatamedical.diseasecode,
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
                          'ชื่อโรค',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.Notes.namedisease,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  /*
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'กลุ่มโรค',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.listdatamedical.diseasegroup,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
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
                            widget.Notes.receiptamount,
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
                        if(widget.Notes.status == "Request")...[
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
                          ]else...[
 
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
                              Navigator.push(context, MaterialPageRoute(builder: (context) => View(url: widget.Notes.fileUrl,)));
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
                Column(
  children: [ 
    if(widget.Notes.status == "Request")...[
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
                              style: ElevatedButton.styleFrom(primary:Colors.green ),
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
                            style: ElevatedButton.styleFrom(primary:Colors.red ),
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
    ]else...[
      Text(""),
    ]
]),
 SizedBox(
                height: 10,
              ),
////end
          ],
        ),
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