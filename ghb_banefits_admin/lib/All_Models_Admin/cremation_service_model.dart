import 'package:cloud_firestore/cloud_firestore.dart';

class CremationServiceAdmin {
  final int  no;
  final String empcode;
  final String name;
  final String department;
  final String divisionment;
  final String idcard;
  final String savedate;

//
  final String housenumber;
  final String alley;
  final String road;
  final String district;
  final String county;
  final String province;
  final String tel;
  //
  bool readrules;
  //

  final String age;
  final String datebirth;
//
  final String namepartner;
  //
  bool pay1;
  bool pay2;
  bool pay3;
  //

  final String managername;
  final String cardnumber;
  final String relationship;
  final String percentage;
  final String  conditions;
//

  ///
  late  String payamount;
  late  String paydate;
  late  String status;
  final String email;
    final String fileUrl;
  final String filename;
  late  String  flagread;
  String id;
  late  String   remarks;
  CremationServiceAdmin(
      this.no,
      this.empcode,
      this.name,
      this.department,
      this.divisionment,
      this.idcard,
      this.savedate,
      this.housenumber,
      this.alley,
      this.road,
      this.district,
      this.county,
      this.province,
      this.tel,
      this.readrules,
      this.age,
      this.datebirth,
      this.namepartner,
      this.pay1,
      this.pay2,
      this.pay3,
      this.managername,
      this.cardnumber,
      this.relationship,
      this.percentage,
      this.conditions,
      this.payamount,
      this.paydate,
      this.status,
      this.email,
      this.fileUrl,
      this.filename,
      this.flagread,
      this.id,
      this.remarks,);

  factory CremationServiceAdmin.fromJson(Map<String, dynamic> json) {
    return CremationServiceAdmin(
      json['no'] as int,
      json['empcode'] as String,
      json['name'] as String,
      json['department'] as String,
      json['divisionment'] as String,
      json['idcard'] as String,
      json['savedate'] as String,
      json['housenumber'] as String,
      json['alley'] as String,
      json['road'] as String,
      json['district'] as String,
      json['county'] as String,
      json['province'] as String,
      json['tel'] as String,
      json['readrules'] as bool,
      json['age'] as String,
      json['datebirth'] as String,
      json['namepartner'] as String,
      json['pay1'] as bool,
      json['pay2'] as bool,
      json['pay3'] as bool,
      json['managername'] as String,
      json['cardnumber'] as String,
      json['relationship'] as String,
      json['percentage'] as String,
      json['conditions'] as String,
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
      'nameemp': name,
      'department': department,
      'divisionment': divisionment,
      'idcard': idcard,
      'savedate': savedate,
      'housenumber': housenumber,
      'alley': alley,
      'road': road,
      'district': district,
      'county': county,
      'province': province,
      'tel': tel,
      'readrules': readrules,
      'age': age,
      'datebirth': datebirth,
      'namepartner': namepartner,
      'pay1': pay1,
      'pay2': pay2,
      'pay3': pay3,
      'managername': managername,
      'cardnumber': cardnumber,
      'relationship': relationship,
      'percentage': percentage,
      'conditions': conditions,
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

class AllCremationServiceAdmin {
  final List<CremationServiceAdmin> Cremations;

  AllCremationServiceAdmin(this.Cremations);
  factory AllCremationServiceAdmin.fromJson(List<dynamic> json) {
    List<CremationServiceAdmin> Cremations;
    Cremations = json.map((item) => CremationServiceAdmin.fromJson(item)).toList();
    return AllCremationServiceAdmin(Cremations);
  }
  factory AllCremationServiceAdmin.fromSnapshot(QuerySnapshot s) {
    List<CremationServiceAdmin> Cremations = s.docs.map((DocumentSnapshot ds) {
      CremationServiceAdmin Cremation =
          CremationServiceAdmin.fromJson(ds.data() as Map<String, dynamic>);
      //order.no = ds.id.substring(1, 8);
      // print(ds.id);
      return Cremation;
    }).toList();

    return AllCremationServiceAdmin(Cremations);
  }
}
