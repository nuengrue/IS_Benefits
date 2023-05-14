import 'package:cloud_firestore/cloud_firestore.dart';

class EducationAdmin {
   int  no;
  final String empcode;
  final String name;
  final String department;
  final String divisionment;
//
  final String typeedu;
  final String yearedu;
  final String savedate;
//

  final String namechild;

//
  final String level;
  final String school;
  final String year;
  final String term;
  final String educationlevel;
  final String schooltype;
//
  final String receiptnumber;
  final String volume;
  final String tel;
  final String receiptdate;
  //
  final String amountreceipt;

  ///
  late final String payamount;
  late final String paydate;
  late final String status;
  final String email;
    final String fileUrl;
  final String filename;
  late final String  flagread;
  String id;
  late  String   remarks;
  EducationAdmin(
      this.no,
      this.empcode,
      this.name,
      this.department,
      this.divisionment,
      this.typeedu,
      this.yearedu,
      this.savedate,
      this.namechild,
      this.level,
      this.school,
      this.year,
      this.term,
      this.educationlevel,
      this.schooltype,
      this.receiptnumber,
      this.volume,
      this.tel,
      this.receiptdate,
      this.amountreceipt,
      this.payamount,
      this.paydate,
      this.status,
      this.email,
       this.fileUrl,
       this.filename,
       this.flagread,
       this.id,
       this.remarks,);

  factory EducationAdmin.fromJson(Map<String, dynamic> json) {
    return EducationAdmin(
      json['no'] as int,
      json['empcode'] as String,
      json['name'] as String,
      json['department'] as String,
      json['divisionment'] as String,
      json['typeedu'] as String,
      json['yearedu'] as String,
      json['savedate'] as String,
      json['namechild'] as String,
      json['level'] as String,
      json['school'] as String,
      json['year'] as String,
      json['term'] as String,
      json['educationlevel'] as String,
      json['schooltype'] as String,
      json['receiptnumber'] as String,
      json['volume'] as String,
      json['tel'] as String,
      json['receiptdate'] as String,
      json['amountreceipt'] as String,
      json['payamount'] as String,
      json['paydate'] as String,
      json['status'] as String,
      json['email'] as String,
      json['fileUrl'] as String,
      json['filename'] as String,
      json['flagread'] as String,
      json['id'] as String,
            json['remarks'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'no': no,
      'empcode': empcode,
      'name': name,
      'department': department,
      'divisionment': divisionment,
      'typeedu': typeedu,
      'yearedu': yearedu,
      'savedate': savedate,
      'namechild': namechild,
      'level': level,
      'school': school,
      'year': year,
      'term': term,
      'educationlevel': educationlevel,
      'schooltype': schooltype,
      'receiptnumber': receiptnumber,
      'volume': volume,
      'tel': tel,
      'receiptdate': receiptdate,
      'amountreceipt': amountreceipt,
      'payamount': payamount,
      'paydate': paydate,
      'status': status,
      'email': email,
          'fileUrl' : fileUrl, 
    'filename' : filename,    
    'flagread' : flagread,   
    'id' : id, 
        'remarks' : remarks, 
    };
  }
}

class AllEducationAdmin {
  final List<EducationAdmin> educations;

  AllEducationAdmin(this.educations);
  factory AllEducationAdmin.fromJson(List<dynamic> json) {
    List<EducationAdmin> educations;
    educations = json.map((item) => EducationAdmin.fromJson(item)).toList();
    return AllEducationAdmin(educations);
  }
  factory AllEducationAdmin.fromSnapshot(QuerySnapshot s) {
    List<EducationAdmin> educations = s.docs.map((DocumentSnapshot ds) {
      EducationAdmin education =
          EducationAdmin.fromJson(ds.data() as Map<String, dynamic>);
      // order.no = ds.id.substring(1, 8);
      // print(ds.id);
      return education;
    }).toList();

    return AllEducationAdmin(educations);
  }
}
