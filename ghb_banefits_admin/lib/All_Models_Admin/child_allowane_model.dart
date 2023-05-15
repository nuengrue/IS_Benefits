
import 'package:cloud_firestore/cloud_firestore.dart';

class ChildAllowanceAdmin {
  final int  no;
  final String empcode;
  final String nameemp;
  final String department;
  final String divisionment;
  final String savedate;
  final String namechild;
  final String namepartner;
  final String officetner;
  final String maritalstatus;
  final String submaritalstatus;
  String status;
  final String email;
  final String fileUrl;
  final String filename;
  late  String  flagread;
  String id;
  late  String   remarks;
  ChildAllowanceAdmin(
       this.no,
       this.empcode,
       this.nameemp,
       this.department,
       this.divisionment,
       this.savedate,
       this.namechild,
       this.namepartner,
       this.officetner,
       this.maritalstatus,
       this.submaritalstatus,
       this.status,
       this.email,
       this.fileUrl,
       this.filename,
       this.flagread,
       this.id,
       this.remarks,);

factory ChildAllowanceAdmin.fromJson(Map<String, dynamic> json) {
    print(json);
    return ChildAllowanceAdmin(
      json['no'] as int,
      json['empcode'] as String,
      json['nameemp'] as String,
      json['department'] as String,
      json['divisionment'] as String,
      json['savedate'] as String,
      json['namechild'] as String,
      json['namepartner'] as String,
      json['officetner'] as String,
      json['maritalstatus'] as String,
      json['submaritalstatus'] as String,
      json['status'] as String,
      json['email'] as String,
      json['fileUrl'] as String,
      json['filename'] as String,
      json['flagread'] as String,
      json['id'] as String,
      json['remarks'] as String,
    );
  }

  Map<String,dynamic> toMap(){
  return{
    'no' : no,
    'empcode' : empcode,
    'nameemp' : nameemp,
    'department' : department,
    'divisionment' : divisionment,
    'savedate' : savedate,        
    'namechild' : namechild,
    'namepartner' : namepartner,
    'officetner' : officetner,
    'maritalstatus' : maritalstatus,
    'submaritalstatus' : submaritalstatus,
    'status' : status,   
    'email' : email, 
    'fileUrl' : fileUrl, 
    'filename' : filename,    
    'flagread' : flagread,   
    'id' : id, 
    'remarks' : remarks, 

  };
}

}


class AllChildAllowanceAdmin {
  final List<ChildAllowanceAdmin> allowances;

  AllChildAllowanceAdmin(this.allowances);
  factory AllChildAllowanceAdmin.fromJson(List<dynamic> json) {
    List<ChildAllowanceAdmin> allowances;
    allowances = json.map((item) => ChildAllowanceAdmin.fromJson(item)).toList();
    return AllChildAllowanceAdmin(allowances);
  }
  factory AllChildAllowanceAdmin.fromSnapshot(QuerySnapshot s){
     List<ChildAllowanceAdmin> allowances = s.docs.map((DocumentSnapshot ds) {
       ChildAllowanceAdmin allowance  = ChildAllowanceAdmin.fromJson(ds.data() as Map<String, dynamic>);
      // allowance.no = ds.id.substring(1,8);
      // print(ds.id);
      return allowance;


    }).toList();

    return AllChildAllowanceAdmin(allowances);
  }
}
