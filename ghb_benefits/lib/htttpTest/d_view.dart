
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ghb_benefits/htttpTest/post_modal.dart';

class UpdateStatusAdminPage extends StatefulWidget {
  final Post order;

  const UpdateStatusAdminPage({super.key, required this.order});
 
  @override
  _UpdateStatusAdminPageState createState() => _UpdateStatusAdminPageState();
}
 
class _UpdateStatusAdminPageState extends State<UpdateStatusAdminPage> {

    _UpdateStatusAdminPageState() {
    _selectedVal = _childName[0];
  }

  final  _childName = ["รับออเดอร์แล้ว","กำลังจัดเตรียมน้ำมัน","กำลังจัดส่งน้ำมัน","น้ำมันถูกจัดส่งสำเร็จ","ยกเลิกการจัดส่งน้ำมัน"];
String? _selectedVal = "";

//final String _status;

  @override
  Widget build(BuildContext context) {

    String? _selectedValchild = "รับออเดอร์แล้ว";
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Status'),
      ),
      body: ListView(
        children: [
          InkWell(
            onTap: () {
              // Navigator.pushNamed(context, '/7');
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: 300,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      blurRadius: 6.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 12),
                    const Divider(
                      height: 2,
                      thickness: 1,
                      indent: 1,
                      color: Colors.black,
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Order Information',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    const Divider(
                      height: 2,
                      thickness: 1,
                      indent: 1,
                      color: Colors.black,
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'เลขที่ใบเสร็จ',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.order.id.toString(),
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
 
      
                    SizedBox(height: 12),
                    const Divider(
                      height: 2,
                      thickness: 1,
                      indent: 1,
                      color: Colors.black,
                    ),
                    SizedBox(height: 5),
                    Text(
                      'User Car Information',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    const Divider(
                      height: 2,
                      thickness: 1,
                      indent: 1,
                      color: Colors.black,
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'แบนรด์รถ',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.order.id.toString(),
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'รุ่นรถ',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.order.Doc,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'เลขทะเบียนรถ',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.order.Doc,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'สีรถ',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.order.Doc,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'ประเภทน้ำมัน',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.order.Doc,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          
                        ],
                      ),
                    ),

                                      Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'สถานะจัดส่ง',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.order.Doc,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    const Divider(
                      height: 2,
                      thickness: 1,
                      indent: 1,
                      color: Colors.black,
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Update Status',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    const Divider(
                      height: 2,
                      thickness: 1,
                      indent: 1,
                      color: Colors.black,
                    ),
                    SizedBox(height: 12),
                    
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'เลือกสถานะจัดส่ง',
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
                         /* child :    DropdownButtonFormField(
              value: _selectedVal,
              items: _childName.map((e) => DropdownMenuItem(child: Text(e),value: e,)).toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedVal = val as String;
                  });
                },
 
            ),
            */
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField(
              value: _selectedVal,
              items: _childName.map((e) => DropdownMenuItem(child: Text(e),value: e,)).toList(),
                onChanged: (val) {
                  setState(() {
                      _selectedVal = val as String;
                  });
                },
 
            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed:  () {

                          final docStatus = FirebaseFirestore.instance.collection('Orders').doc();
                          docStatus.update({
                            'status':  _selectedVal,
                          });
                                

                                 
                              },
                              
                        child: Text('Save'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          //text
        ],
      ),
    );
  }
}
