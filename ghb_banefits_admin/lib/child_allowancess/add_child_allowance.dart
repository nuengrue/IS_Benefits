
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:ghb_banefits_admin/child_allowance/provider_child_allowance_admin.dart';
// import 'package:intl/intl.dart';
// import 'package:open_file/open_file.dart';
// import 'package:provider/provider.dart';

// class AddChildAllowancePage extends StatefulWidget {
//   const AddChildAllowancePage({Key? key}) : super(key: key);

//   @override
//   State<AddChildAllowancePage> createState() => _AddChildAllowancePageState();
// }

// class _AddChildAllowancePageState extends State<AddChildAllowancePage> {
//   _AddChildAllowancePageState() {
//     _selectedVal = _childName[0];
//     _selectedpartner = _childpartner[0];
//     _selectedstatuspartner = _childstatuspartner[0];
//   }

//   final _childName = [
//     "เลือกบุตร",
//     "ด.ช. น้ำใจ มาดี",
//     "ด.ช. อุ่นใจ มาดี",
//     "ด.ช. ตาใจ มาดี"
//   ];
//   String? _selectedVal = "";
//   final _childpartner = [
//     "เลือกสถานะ",
//     "สมรส",
//     "อย่าขาดจากคู่สมรส",
//     "คู่สมรสถึงแก่กรรม"
//   ];
//   String? _selectedpartner = "";

//   final _childstatuspartner = ["เลือกสถานะ", "จดทะเบียน", "ไม่จดทะเบียน"];
//   String? _selectedstatuspartner = "";

//   final _formKey = GlobalKey<FormState>();

//   bool visibilityTag = false;

//   void _changed(bool visibility, String field) {
//     setState(() {
//       if (field == "สมรส") {
//         visibilityTag = visibility;
//       }
//     });
//   }

//   //final user = FirebaseAuth.instance.currentUser!;
//   late String _no;
//   late String _empcode;
//   late String _nameemp;
//   late String _department;
//   late String _divisionment;
//   late String _savedate;
//   late String _namechild;
//   late String _namepartner;
//   late String _officetner;
//   late String _maritalstatus;
//   late String _submaritalstatus;
//   late String _status;
//   late String _email;
//   void AddChildAllowance()  async{
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       _no = "2";
//       _empcode = "57315";
//       _nameemp = "หนึ่งฤทัย พวงแก้ว";
//       _department = "ฝ่ายพัฒนาระบบสารสนเทศ";
//       _divisionment = "ส่วนสวัสดิการ";
//       _savedate = DateFormat.yMd().add_jm().format(DateTime.now());
//       _namechild = _selectedVal!;
//       _namepartner;
//       _officetner;
//       _maritalstatus = _selectedpartner!;
//       if(_selectedstatuspartner == "เลือกสถานะ"){
//               _submaritalstatus = "-";
//       }
//       else{
//              _submaritalstatus = _selectedstatuspartner!; 
//       }
//       _status = "ร้องขอ";
//       _email = "ti@gmail.com";   
//       //_email = user.email!;

//       Provider.of<ChildAllowanceProviders>(context, listen: false)
//           .addChildAllowane(
//               _no,
//               _empcode,
//               _nameemp,
//               _department,
//               _divisionment,
//               _savedate,
//               _namechild,
//               _namepartner,
//               _officetner,
//               _maritalstatus,
//               _submaritalstatus,
//               _status,
//               _email);
              
//               print("done");
// /*
//       //final docStatus = FirebaseFirestore.instance.collection('ChildAllowance');
//       CollectionReference orders =  FirebaseFirestore.instance.collection('ChildAllowance');
//       DocumentReference doc = await orders
//       .add({
//         'no': _no,
//         'empcode':      _empcode,
//         'nameemp':      _nameemp,
//         'department':      _department,
//         'divisionment':      _divisionment,
//         'savedate':      _savedate,
//         'namechild':      _namechild,
//         'namepartner':      _namepartner,
//         'officetner':      _officetner,
//         'maritalstatus':      _maritalstatus,
//         'submaritalstatus':      _submaritalstatus,
//         'status':      _status,
//         'email':      _email,
//       });
//           doc.update({
//       'no' : doc.id,

//       //'id' : result,
//     });
// */


   

//       //Provider.of<ChildAllowaneProviders>(context,listen: false).addNotes(_Title.text, _Description.text);

//       //Navigator.of(context).pop();
//       /*
//       Navigator.pop(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ListChildAllowancePage(),
//         ),
//       );
//       */
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Scaffold is a layout for
//     // the major Material Components.
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('เพิ่มรายการ'),
//       ),
//       body: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Container(
//                 margin: const EdgeInsets.all(10.0),
//                 padding: const EdgeInsets.all(10.0),
//                 //height: double.infinity,
//                 width: 450,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                   border: Border.all(
//                     color: Colors.white,
//                   ),
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       blurRadius: 6.0,
//                       spreadRadius: 2.0,
//                       color: Colors.grey,
//                       offset: Offset(0.0, 0.0),
//                     )
//                   ],
//                 ),
//                 child: Column(
//                   children: <Widget>[
//                     Text(
//                       'สร้างคำขอเบิกเงินค่าช่วยเหลือบุตร',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Color.fromARGB(255, 9, 28, 235),
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const Divider(),
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.all(10.0),
//                 padding: const EdgeInsets.all(10.0),
//                 //height: double.infinity,
//                 width: 450,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                   border: Border.all(
//                     color: Colors.white,
//                   ),
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       blurRadius: 6.0,
//                       spreadRadius: 2.0,
//                       color: Colors.grey,
//                       offset: Offset(0.0, 0.0),
//                     )
//                   ],
//                 ),
//                 child: Column(
//                   children: <Widget>[
//                     Text(
//                       'ข้อมูลพนักงาน',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Color.fromARGB(255, 9, 28, 235),
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const Divider(),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             'พนักงาน',
//                             textAlign: TextAlign.left,
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Expanded(
//                           child: Text(
//                             'หนึ่งฤทัย พวงแก้ว',
//                             textAlign: TextAlign.end,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             'หน่วยงาน',
//                             textAlign: TextAlign.left,
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Text(
//                               'ฝ่ายทรัพยากรบุคคล',
//                               textAlign: TextAlign.end,
//                             ),
//                             Text(
//                               'ส่วนสวัสดิการ',
//                               textAlign: TextAlign.end,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             'วันที่บันทึก',
//                             textAlign: TextAlign.left,
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Expanded(
//                           child: Text(
//                             DateFormat.yMd().format(DateTime.now()),
//                             textAlign: TextAlign.end,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),

//               ///

//               /////////////
//               Container(
//                 margin: const EdgeInsets.all(10.0),
//                 padding: const EdgeInsets.all(10.0),
//                 //height: double.infinity,
//                 width: 450,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                   border: Border.all(
//                     color: Colors.white,
//                   ),
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       blurRadius: 6.0,
//                       spreadRadius: 2.0,
//                       color: Colors.grey,
//                       offset: Offset(0.0, 0.0),
//                     )
//                   ],
//                 ),
//                 child: Column(
//                   children: <Widget>[
//                     Text(
//                       'ข้อมูลบุตร',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Color.fromARGB(255, 9, 28, 235),
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const Divider(),
//                     Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Text(
//                               'บุตรของพนักงาน',
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           Expanded(
//                             child: Text(
//                               '',
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: DropdownButtonFormField(
//                         value: _selectedVal,
//                         items: _childName
//                             .map((e) => DropdownMenuItem(
//                                   child: Text(e),
//                                   value: e,
//                                 ))
//                             .toList(),
//                         onChanged: (val) {
//                           setState(() {
//                             _selectedVal = val as String;
//                           });
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.all(10.0),
//                 padding: const EdgeInsets.all(10.0),
//                 //height: double.infinity,
//                 width: 450,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                   border: Border.all(
//                     color: Colors.white,
//                   ),
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       blurRadius: 6.0,
//                       spreadRadius: 2.0,
//                       color: Colors.grey,
//                       offset: Offset(0.0, 0.0),
//                     )
//                   ],
//                 ),
//                 child: Column(
//                   children: <Widget>[
//                     Text(
//                       'ข้อมูลคู่สมรส',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Color.fromARGB(255, 9, 28, 235),
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const Divider(),
//                     Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: TextFormField(
//                         maxLength: 100,
//                         keyboardType: TextInputType.text,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(),
//                           hintText: 'ชื่อ-นามสกุลของคู่มสมรส',
//                           labelText: 'ชื่อ-นามสกุลของคู่มสมรส',
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'โปรดระบุชื่อ-นามสกุลของคู่มสมรส';
//                           } else if (value.length >= 100) {
//                             return 'โปรดระบุข้อมูลไม่เกิน 100 ตัวอักษร';
//                           } else {
//                             return null;
//                           }
//                         },
//                         onSaved: (newValue) {
//                           _namepartner = newValue!;
//                         },
//                       ),
//                     ),
//                     /*
//                                    Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: TextFormField(
//                   maxLength: 50,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     hintText: 'นามสกุลของคู่มสมรส',
//                     labelText: 'นามสกุลของคู่มสมรส',
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'โปรดระบุนามสกุลของคู่มสมรส';
//                     } else if (value.length != 4) {
//                       return 'โปรดระบุข้อมูลไม่เกิน 50 ตัวอักษร';
//                     } else {
//                       return null;
//                     }
//                   },
//                 //  onSaved: (newValue) {_cvvs = newValue!;},
//                 ),
//               ),
//               */
//                     Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: TextFormField(
//                         maxLength: 100,
//                         keyboardType: TextInputType.text,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(),
//                           hintText: 'สถานที่ทำงาน',
//                           labelText: 'สถานที่ทำงาน',
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'โปรดระบุสถานที่ทำงาน';
//                           } else if (value.length >= 100) {
//                             return 'โปรดระบุข้อมูลไม่เกิน 100 ตัวอักษร';
//                           } else {
//                             return null;
//                           }
//                         },
//                         onSaved: (newValue) {
//                           _officetner = newValue!;
//                         },
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Text(
//                               'สถานะ',
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           Expanded(
//                             child: Text(
//                               '',
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: DropdownButtonFormField(
//                         value: _selectedpartner,
//                         items: _childpartner
//                             .map((e) => DropdownMenuItem(
//                                   child: Text(e),
//                                   value: e,
//                                 ))
//                             .toList(),
//                         onChanged: (val) {
//                           setState(() {
//                             _selectedpartner = val as String;
//                             visibilityTag
//                                 ? null
//                                 : _changed(true, _selectedpartner!);
//                           });
//                         },
//                       ),
//                     ),
//                     visibilityTag
//                         ? new Row(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: <Widget>[
//                               new Expanded(
//                                 flex: 11,
//                                 child: new DropdownButtonFormField(
//                                   value: _selectedstatuspartner,
//                                   items: _childstatuspartner
//                                       .map((e) => DropdownMenuItem(
//                                             child: Text(e),
//                                             value: e,
//                                           ))
//                                       .toList(),
//                                   onChanged: (val) {
//                                     setState(() {
//                                       if(val == 'เลือกสถานะ'){

//                                         _selectedstatuspartner = "-";
//                                       }
//                                       else{
//                                         _selectedstatuspartner = val as String;
//                                       }

//                                     });
//                                   },
//                                 ),
//                               ),
//                               new Expanded(
//                                 flex: 1,
//                                 child: new IconButton(
//                                   color: Colors.grey[400],
//                                   icon: const Icon(
//                                     Icons.cancel,
//                                     size: 22.0,
//                                   ),
//                                   onPressed: () {
//                                     _changed(false, "สมรส");
//                                   },
//                                 ),
//                               ),
//                             ],
//                           )
//                         : new Container(),
//                   ],
//                 ),
//               ),
//                             Container(
//                 margin: const EdgeInsets.all(10.0),
//                 padding: const EdgeInsets.all(10.0),
//                 //height: double.infinity,
//                 width: 450,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                   border: Border.all(
//                     color: Colors.white,
//                   ),
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       blurRadius: 6.0,
//                       spreadRadius: 2.0,
//                       color: Colors.grey,
//                       offset: Offset(0.0, 0.0),
//                     )
//                   ],
//                 ),
//                 child: Column(
//                   children: <Widget>[
//                     Text(
//                       'เอกสารแนบ',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.amber,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const Divider(),
//                     ElevatedButton(
//                       child: Text("เอกสารแนบ"),
//                       onPressed: () async {
//                         final result = await FilePicker.platform.pickFiles(
//                           allowMultiple: true,
//                           type: FileType.custom,
//                           allowedExtensions: ['pdf', 'jpeg', 'jpg'],
//                         );
//                         if (result == null) return;
        
//                         //open
//                         //  final file = result.files.first;
//                     //    openFiles(context, result.files);
//         /*
//               print('Name: ${file.name}');
//                           print('Bytes: ${file.bytes}');
//                                       print('Size: ${file.size}');
//                                                   print('Extension: ${file.extension}');
//                                                               print('Path: ${file.path}');
        
//               final newFile  = await saveFilePermanently(file);
//               print('From Path: ${file.path!}');
//                           print('To Path: ${newFile.path!}');
        
//                           */
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                 child: GestureDetector(
//                   onTap: AddChildAllowance,
//                   child: Container(
//                     padding: EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: Colors.amber,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Center(
//                       child: Text(
//                         'บันทึกข้อมูล',
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 30,
//               ),

//               ///
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   /*
//     void openFiles(context, List<PlatformFile> files) =>
//       Navigator.of(context).push(MaterialPageRoute(
//         builder: (context) => FilesPage(
//           files: files,
//           onOpenFile: openFile,
//         ),
//       ));
      
//   void openFile(PlatformFile file) {
//     OpenFile.open(file.path!);
//   }
//   */
// }
