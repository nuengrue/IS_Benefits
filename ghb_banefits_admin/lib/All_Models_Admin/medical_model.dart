import 'package:cloud_firestore/cloud_firestore.dart';

class MedicalAdmin {
  final int  no;
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
  late String payamount;
  late String paydate;
  late String status;
  final String email;
  final String fileUrl;
  final String filename;
  late  String flagread;
  String id;
  late  String   remarks;
  //final List<Medtreat> cedtreat;
  MedicalAdmin(
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
  this.id,
         this.remarks,
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
      'remarks' : remarks,     
      //'cedtreat': cedtreat.map((i) => i.toMap()).toList(),
    };
  }

  factory MedicalAdmin.fromJson(Map<String, dynamic> json) {
    print(json);
    return MedicalAdmin(
      json['no'] as int,
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
            json['remarks'] as String,
      //map['cedtreat'],
    );
  }

}

class AllMedicalAdmin {
  final List<MedicalAdmin> medicals;

  AllMedicalAdmin(this.medicals);
  factory AllMedicalAdmin.fromJson(List<dynamic> json) {
    List<MedicalAdmin> medicals;
    medicals = json.map((item) => MedicalAdmin.fromJson(item)).toList();
    return AllMedicalAdmin(medicals);
  }
  factory AllMedicalAdmin.fromSnapshot(QuerySnapshot s) {
    List<MedicalAdmin> medicals = s.docs.map((DocumentSnapshot ds) {
      MedicalAdmin medical = MedicalAdmin.fromJson(ds.data() as Map<String, dynamic>);
      // allowance.no = ds.id.substring(1,8);
      // print(ds.id);
      return medical;
    }).toList();

    return AllMedicalAdmin(medicals);
  }
}
