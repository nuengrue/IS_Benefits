//import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ghb_benefits/color.dart';
import 'package:ghb_benefits/All_Models/cremation_service_model.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

//import 'package:flutter/widgets.dart';

class DetailCremationServicePage extends StatelessWidget {
  const DetailCremationServicePage({super.key, required this.Notes});

  // Declare a field that holds the Todo.
  final CremationService Notes;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
                title: Text('รายการคำขอสมัครฌาปนกิจสงเคราะห์',style: TextStyle(
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
                      'รายการคำขอสมัครเข้าเป็นสมาชิกฌาปนกิจ',
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
                    Text(
                      'ข้อมูลพนักงาน',
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
                    
                                       Row(
                      children: [
                        Expanded(
                          child: Text(
                            'เลขที่บัตรประชาชน',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            Notes.idcard,
                            textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),
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
                  ],
                ),
              ),

              ///

              /////////////
              ///
              //              Container(
              //   margin: const EdgeInsets.all(10.0),
              //   padding: const EdgeInsets.all(10.0),
              //   //height: double.infinity,
              //   width: 450,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(5),
              //     border: Border.all(
              //       color: Colors.white,
              //     ),
              //     color: Colors.white,
              //     boxShadow: [
              //       BoxShadow(
              //         blurRadius: 6.0,
              //         spreadRadius: 2.0,
              //         color: Colors.grey,
              //         offset: Offset(0.0, 0.0),
              //       )
              //     ],
              //   ),
              //   child: Column(
              //     children: <Widget>[
              //       Text(
              //         'ข้อมูลที่อยู่ปัจจุบันของพนักงาน',
              //         style: TextStyle(
              //           fontSize: 16,
              //           color: Color.fromARGB(255, 9, 28, 235),
              //           fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
              //         ),
              //       ),
              //       const Divider(),
              //          Row(
              //         children: [
              //           Expanded(
              //             child: Text(
              //               'บ้านเลขที่',
              //               textAlign: TextAlign.left,
              //               style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
              //             ),
              //           ),
              //           Expanded(
              //             child: Text(
              //               Notes.housenumber,
              //               textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),
              //             ),
              //           ),
              //         ],
              //       ),                 
              //        Row(
              //         children: [
              //           Expanded(
              //             child: Text(
              //               'ตรอก/ซอย',
              //               textAlign: TextAlign.left,
              //               style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
              //             ),
              //           ),
              //           Expanded(
              //             child: Text(
              //               Notes.alley,
              //               textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),
              //             ),
              //           ),
              //         ],
              //       ),
              //       Row(
              //         children: [
              //           Expanded(
              //             child: Text(
              //               'ถนน',
              //               textAlign: TextAlign.left,
              //               style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
              //             ),
              //           ),
              //           Expanded(
              //             child: Text(
              //               Notes.road,
              //               textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),
              //             ),
              //           ),
              //         ],
              //       ),
              //       Row(
              //         children: [
              //           Expanded(
              //             child: Text(
              //               'ตำบล/แขวง',
              //               textAlign: TextAlign.left,
              //               style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
              //             ),
              //           ),
              //           Expanded(
              //             child: Text(
              //               Notes.district,
              //               textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),
              //             ),
              //           ),
              //         ],
              //       ),  
              //        Row(
              //         children: [
              //           Expanded(
              //             child: Text(
              //               'อำเภอ/เขต',
              //               textAlign: TextAlign.left,
              //               style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
              //             ),
              //           ),
              //           Expanded(
              //             child: Text(
              //               Notes.county,
              //               textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),
              //             ),
              //           ),
              //         ],
              //       ),
              //       Row(
              //         children: [
              //           Expanded(
              //             child: Text(
              //               'จังหวัด',
              //               textAlign: TextAlign.left,
              //               style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
              //             ),
              //           ),
              //           Expanded(
              //             child: Text(
              //               Notes.province,
              //               textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),
              //             ),
              //           ),
              //         ],
              //       ),  
              //                           Row(
              //         children: [
              //           Expanded(
              //             child: Text(
              //               'หมายเลขติดต่อ',
              //               textAlign: TextAlign.left,
              //               style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
              //             ),
              //           ),
              //           Expanded(
              //             child: Text(
              //               Notes.tel,
              //               textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),
              //             ),
              //           ),
              //         ],
              //       ),          
              //     ],
              //   ),
              // ),
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
                        fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
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
                              'ได้อ่านและรับทราบข้อบังคับธนาคารอาคารสงเคราะห์ว่าด้วยการฌาปนกิจสงเคราะห์พ.ศ.2559 และที่แก้ไขเพิ่มเติม',style: TextStyle(fontFamily: 'Sarabun',),),
                          //subtitle: const Text('A computer science portal for geeks.'),
                          //secondary: const Icon(Icons.code),
                          autofocus: false,
                          activeColor: iOrangeColor,
                          checkColor: Colors.white,
                          selected: Notes.readrules,
                          value: Notes.readrules,
                          onChanged: (value) {
                           
                          },
                        ), //CheckboxListTile
                      ), //Container
                    ),
                  ],
                ),
              ),
              //                            Container(
              //   margin: const EdgeInsets.all(10.0),
              //   padding: const EdgeInsets.all(10.0),
              //   //height: double.infinity,
              //   width: 450,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(5),
              //     border: Border.all(
              //       color: Colors.white,
              //     ),
              //     color: Colors.white,
              //     boxShadow: [
              //       BoxShadow(
              //         blurRadius: 6.0,
              //         spreadRadius: 2.0,
              //         color: Colors.grey,
              //         offset: Offset(0.0, 0.0),
              //       )
              //     ],
              //   ),
              //   child: Column(
              //     children: <Widget>[
              //       Text(
              //         'ข้อมูลอายุของพนักงาน',
              //         style: TextStyle(
              //           fontSize: 16,
              //           color: Color.fromARGB(255, 9, 28, 235),
              //           fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
              //         ),
              //       ),
              //       const Divider(),
              //          Row(
              //         children: [
              //           Expanded(
              //             child: Text(
              //               'อายุของพนักงาน',
              //               textAlign: TextAlign.left,
              //               style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
              //             ),
              //           ),
              //           Expanded(
              //             child: Text(
              //               Notes.age,
              //               textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),
              //             ),
              //           ),
              //         ],
              //       ),                 
              //        Row(
              //         children: [
              //           Expanded(
              //             child: Text(
              //               'วันที่เกิดของ',
              //               textAlign: TextAlign.left,
              //               style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
              //             ),
              //           ),
              //           Expanded(
              //             child: Text(
              //               Notes.datebirth,
              //               textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),
              //             ),
              //           ),
              //         ],
              //       ),
                   
              //     ],
              //   ),
              // ),
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
                        fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                      ),
                    ),
                    const Divider(),
                       Row(
                      children: [
                        Expanded(
                          child: Text(
                            'ชื่อ-นามสกุลคู่สมรส',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            Notes.namepartner,
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
                      'การชำระเงินฌาปนกิจ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 9, 28, 235),
                        fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
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
                              'ชำระเงินเป็นค่าสมัครเข้าเป็นสมาชิก เป็นเงิน 100 บาท',style: TextStyle(fontFamily: 'Sarabun',),),
                          //subtitle: const Text('A computer science portal for geeks.'),
                          //secondary: const Icon(Icons.code),
                          autofocus: false,
                          activeColor: iOrangeColor,
                          checkColor: Colors.white,
                          selected: Notes.pay1,
                          value: Notes.pay1,
                          onChanged: (value) {

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
                              'ชำระเงินสงเคราะห์ล่วงหน้าตามอัตราที่ทางการฌาปนกิจสงเคราะห์ ธนาคารอาคารสงเคราะห์ เรียกเก็บเป็นเงิน 300 บาท',style: TextStyle(fontFamily: 'Sarabun',),),
                          //subtitle: const Text('A computer science portal for geeks.'),
                          //secondary: const Icon(Icons.code),
                          autofocus: false,
                          activeColor: iOrangeColor,
                          checkColor: Colors.white,
                          selected: Notes.pay2,
                          value: Notes.pay2,
                          onChanged: (value) {

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
                              'ชำระเงินสงเคราะห์ศพเป็นไปตามอัตราที่ทางการฌาปนกิจสงเคราะห์ ธนาคารอาคารสงเคราะห์เรียกเก็บ',style: TextStyle(fontFamily: 'Sarabun',),),
                          //subtitle: const Text('A computer science portal for geeks.'),
                          //secondary: const Icon(Icons.code),
                          autofocus: false,
                          activeColor: iOrangeColor,
                          checkColor: Colors.white,
                          selected: Notes.pay3,
                          value: Notes.pay3,
                          onChanged: (value) {

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
                        fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                      ),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'ชื่อ-นามสกุล',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            Notes.managername,
                            textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),
                          ),
                        ),
                      ],
                    ),
                     Row(
                      children: [
                        Expanded(
                          child: Text(
                            'เลขที่บัตรประชาชน',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            Notes.cardnumber,
                            textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),
                          ),
                        ),
                      ],
                    ),
                     Row(
                      children: [
                        Expanded(
                          child: Text(
                            'ตวามเกี่ยวข้องกับพนักงาน',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            Notes.relationship,
                            textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),
                          ),
                        ),
                      ],
                    ),                 
                    //  Row(
                    //   children: [
                    //     Expanded(
                    //       child: Text(
                    //         'ร้อยละ',
                    //         textAlign: TextAlign.left,
                    //         style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                    //       ),
                    //     ),
                    //     Expanded(
                    //       child: Text(
                    //         Notes.percentage,
                    //         textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'การแบ่งเงินฌาปนกิจ',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            Notes.conditions,
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
 
                  
                  
                  ],
                ),
              ),

                           



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