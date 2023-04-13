import 'package:cloud_firestore/cloud_firestore.dart';

class Medical {
  final String no;
  final String empcode;
  final String name;
  final String department;
  final String divisionment;
  final String numbercodemed;
  final String savedate;
  final String typemed;
  final String yearmed;
  final String hospitalname;
  final String hospitaltype;
  final String claimstartdate;
  final String claimenddate;
  final String idreceiptnumber;
  final String receiptnumber;
  final String tel;
  final String namedisease;
  final String diseasegroup;
  final String receiptamount;
  final String payamount;
  final String paydate;
  final String status;
  final String email;
  final String fileUrl;
  final String filename;
  final String flagread;
  String id;
  //final List<Medtreat> cedtreat;
  Medical(
  this.no,
  this.empcode,
  this.name,
  this.department,
  this.divisionment,
  this.numbercodemed,
  this.savedate,
  this.typemed,
  this.yearmed,
  this.hospitalname,
  this.hospitaltype,
  this.claimstartdate,
  this.claimenddate,
  this.idreceiptnumber,
  this.receiptnumber,
  this.tel,
  this.namedisease,
  this.diseasegroup,
  this.receiptamount,
  this.payamount,
  this.paydate,
  this.status,
  this.email,
  this.fileUrl,
  this.filename,
  this.flagread,
  this.id
  );

  Map<String, dynamic> toMap() {
    return {
      'no': no,
      'empcode': empcode,
      'name': name,
      'department': department,
      'divisionment': divisionment,
      'numbercodemed': numbercodemed,
      'savedate': savedate,
      'typemed': typemed,
      'yearmed': yearmed,
      'hospitalname': hospitalname,
      'hospitaltype': hospitaltype,
      'claimstartdate': claimstartdate,
      'claimenddate': claimenddate,
      'idreceiptnumber': idreceiptnumber,
      'receiptnumber': receiptnumber,
      'tel': tel,
      'namedisease': namedisease,
      'diseasegroup': diseasegroup,
      'receiptamount': receiptamount,
      'payamount': payamount,
      'paydate': paydate,
      'status': status,
      'email': email,
      'fileUrl': fileUrl,
      'filename': filename,
      'flagread': flagread,
      'id': id,
      //'cedtreat': cedtreat.map((i) => i.toMap()).toList(),
    };
  }

  factory Medical.fromJson(Map<String, dynamic> json) {
    print(json);
    return Medical(
      json['no'] as String,
      json['empcode'] as String,
      json['name'] as String,
      json['department'] as String,
      json['divisionment'] as String,
      json['numbercodemed'] as String,
      json['savedate'] as String,
      json['typemed'] as String,
      json['yearmed'] as String,
      json['hospitalname'] as String,
      json['hospitaltype'] as String,
      json['claimstartdate'] as String,
      json['claimenddate'] as String,
      json['idreceiptnumber'] as String,
      json['receiptnumber'] as String,
      json['tel'] as String,
      json['namedisease'] as String,
      json['diseasegroup'] as String,
      json['receiptamount'] as String,
      json['payamount'] as String,
      json['paydate'] as String,
      json['status'] as String,
      json['email'] as String,
      json['fileUrl'] as String,
      json['filename'] as String,
      json['flagread'] as String,
      json['id'] as String,
      //map['cedtreat'],
    );
  }

/*
  factory Childall.fromJson(Map<String, dynamic> json) {
    return Childall(
      no: json['no'],
      empcode: json['empcode'],
      nameemp: json['nameemp'],
      department: json['department'],
      divisionment: json['divisionment'],
      savedate: json['savedate'],
      namechild: json['namechild'],
      namepartner: json['no'],
      officetner: json['officetner'],
      maritalstatus: json['maritalstatus'],
      submaritalstatus: json['submaritalstatus'],
      status: json['status'],
      email: json['email']
    );
  }
  */

}

class AllMedical {
  final List<Medical> medicals;

  AllMedical(this.medicals);
  factory AllMedical.fromJson(List<dynamic> json) {
    List<Medical> medicals;
    medicals = json.map((item) => Medical.fromJson(item)).toList();
    return AllMedical(medicals);
  }
  factory AllMedical.fromSnapshot(QuerySnapshot s) {
    List<Medical> medicals = s.docs.map((DocumentSnapshot ds) {
      Medical medical = Medical.fromJson(ds.data() as Map<String, dynamic>);
      // allowance.no = ds.id.substring(1,8);
      // print(ds.id);
      return medical;
    }).toList();

    return AllMedical(medicals);
  }
}
