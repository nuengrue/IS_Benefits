import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ghb_benefits/All_Models/medical_model.dart';
import 'package:ghb_benefits/color.dart';

import 'package:ghb_benefits/pdf/pdf_api.dart';
import 'package:ghb_benefits/pdf/view_pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';



/*
class SubDetailMedicalPage extends StatefulWidget {

    final ListdataMedical listdatamedical;

  SubDetailMedicalPage(this.listdatamedical);

  @override
  State<SubDetailMedicalPage> createState() => _SubDetailMedicalPageState();
}

class _SubDetailMedicalPageState extends State<SubDetailMedicalPage> {
  */


class DetailMedicalPage extends StatelessWidget {
  const DetailMedicalPage({super.key, required this.Notes});

  // Declare a field that holds the Todo.
  final Medical Notes;

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for
    // the major Material Components.
    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียดคำขอเบิกค่ารักษาพยาบาล',style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                            color: iWhiteColor,
                          ),),
      backgroundColor: iBlueColor,
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
                      'รายการคำขอเงินช่วยเหลือค่ารักษาพยาบาล',
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
                            'สถานะรายการ',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            Notes.status,
                            textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),
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
                          style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          Notes.name,
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
                            Notes.department,
                            textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),
                          ),
                          Text(
                            Notes.divisionment,
                            textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),
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
                      fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
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
                  //         Notes.typemed,
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
                          style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          Notes.savedate,
                          textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),
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
                          style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          Notes.yearmed,
                          textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),
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
                      fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                    ),
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'ชื่อโรงพยาบาล',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            Notes.hospitalname,
                            textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),
                          ),
                          Text(
                            Notes.hospitaltype,
                            textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),
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
                      fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                    ),
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'เลขที่ใบเสร็จ',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          Notes.idreceiptnumber,
                          textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),
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
                          style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          Notes.receiptnumber,
                          textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),
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
                          style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          Notes.tel,
                          textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),
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
                          style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          Notes.claimstartdate,
                          textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),
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
                          style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          Notes.claimenddate,
                          textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),
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
                      fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
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
                          style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          Notes.namedisease,
                          textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),
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
                children: <Widget>[
                  Text(
                    'รายการรักษาพยาบาล',
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
                          'รหัสการรักษาพยาบาล',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.listdatamedical.medicalcode,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'รายการรักษาพยาบาล',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.listdatamedical.medicallist,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'จำนวนวัน',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.listdatamedical.numberdays,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'จำนวนเงิน',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.listdatamedical.amount,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'หมายเหตุอื่นๆ',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.listdatamedical.othernotes,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
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
                      fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                    ),
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'จำนวนเงินตามใบเสร็จ',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          Notes.receiptamount,
                          textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'จำนวนเงินจ่าย',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                        ),
                      ),
                                            if(Notes.payamount == "0") ...[
                      
                         Expanded(
                                                  child: Text(''
                          ,
                          textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),
                        ),
                        ),
                        ] else ...[
                            Expanded(
                          child: Text(
                          Notes.payamount,
                          textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),
                        ),
                        ),
                        ]
                        // child: Text(
                        //   Notes.paydate,
                        //   textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),
                        // ),
                      
                    ],
                      // Expanded(
                      //   child: Text(
                      //     Notes.payamount,
                      //     textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),
                      //   ),
                      // ),
                    // ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'วันที่จ่าย',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                        ),
                      ),
                      if(Notes.paydate == "0") ...[
                      
                         Expanded(
                                                  child: Text(''
                          ,
                          textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),
                        ),
                        ),
                        ] else ...[
                            Expanded(
                          child: Text(
                          Notes.paydate,
                          textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),
                        ),
                        ),
                        ]
                        // child: Text(
                        //   Notes.paydate,
                        //   textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),
                        // ),
                      
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
                      fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                    ),
                  ),
                  const Divider(),
                                        ListTile(
                      title: Text(Notes.filename.toString()),
                      trailing: Icon(Icons.remove_red_eye),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => View(url: Notes.fileUrl,)));
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
////end
          ],
        ),
      ),
    );
  }

  void openPDF(BuildContext context, File file) 
  => Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => ViewPDFPage(file:file)) ,
  );
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