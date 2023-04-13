
// import 'package:cloud_firestore/cloud_firestore.dart';

// class ChildAllowance {
//   String no;
//   final String empcode;
//   final String nameemp;
//   final String department;
//   final String divisionment;
//   final String savedate;
//   final String namechild;
//   final String namepartner;
//   final String officetner;
//   final String maritalstatus;
//   final String submaritalstatus;
//   String status;
//   final String email;
//   final String fileUrl;
//   final String filename;
//   late  String  flagread;
//     String id;
//   ChildAllowance(
//        this.no,
//        this.empcode,
//        this.nameemp,
//        this.department,
//        this.divisionment,
//        this.savedate,
//        this.namechild,
//        this.namepartner,
//        this.officetner,
//        this.maritalstatus,
//        this.submaritalstatus,
//        this.status,
//        this.email,
//        this.fileUrl,
//        this.filename,
//        this.flagread,
//        this.id,);

// factory ChildAllowance.fromJson(Map<String, dynamic> json) {
//     print(json);
//     return ChildAllowance(
//       json['no'] as String,
//       json['empcode'] as String,
//       json['nameemp'] as String,
//       json['department'] as String,
//       json['divisionment'] as String,
//       json['savedate'] as String,
//       json['namechild'] as String,
//       json['namepartner'] as String,
//       json['officetner'] as String,
//       json['maritalstatus'] as String,
//       json['submaritalstatus'] as String,
//       json['status'] as String,
//       json['email'] as String,
//       json['fileUrl'] as String,
//       json['filename'] as String,
//       json['flagread'] as String,
//       json['id'] as String,      
//     );
//   }

//   Map<String,dynamic> toMap(){
//   return{
//     'no' : no,
//     'empcode' : empcode,
//     'nameemp' : nameemp,
//     'department' : department,
//     'divisionment' : divisionment,
//     'savedate' : savedate,        
//     'namechild' : namechild,
//     'namepartner' : namepartner,
//     'officetner' : officetner,
//     'maritalstatus' : maritalstatus,
//     'submaritalstatus' : submaritalstatus,
//     'status' : status,   
//     'email' : email, 
//     'fileUrl' : fileUrl, 
//     'filename' : filename,    
//     'flagread' : flagread,    
//     'id' : id,     
//   };
// }

// }


// class AllChildAllowance {
//   final List<ChildAllowance> allowances;

//   AllChildAllowance(this.allowances);
//   factory AllChildAllowance.fromJson(List<dynamic> json) {
//     List<ChildAllowance> allowances;
//     allowances = json.map((item) => ChildAllowance.fromJson(item)).toList();
//     return AllChildAllowance(allowances);
//   }
//   factory AllChildAllowance.fromSnapshot(QuerySnapshot s){
//      List<ChildAllowance> allowances = s.docs.map((DocumentSnapshot ds) {
//        ChildAllowance allowance  = ChildAllowance.fromJson(ds.data() as Map<String, dynamic>);
//       // allowance.no = ds.id.substring(1,8);
//       // print(ds.id);
//       return allowance;


//     }).toList();

//     return AllChildAllowance(allowances);
//   }
// }
