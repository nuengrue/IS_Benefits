import 'package:flutter/material.dart';

class ListdataMedical {
  String empcode;
  String fname;
  String lname;
  String codedepartment;
  String namedepartment;
  String codegroup;
  String codegroupemp;
  String numbercodemed;
  String savedate;
  String typemed;
  String yearmed;
  String patienttype;
  String patientname;
  String hospitalcode;
  String hospitalname;
  String hospitaltype;
  String claimstartdate;
  String claimenddate;
  String idreceiptnumber;
  String receiptnumber;
  String tel;
  String diseasecode;
  String namedisease;
  String diseasegroup;
  String medicalcode;
  String medicallist;
  String numberdays;
  String amount;
  String othernotes;
  String receiptamount;
  String payamount;
  String paydate;

  ListdataMedical(
      {required this.empcode,
      required this.fname,
      required this.lname,
      required this.codedepartment,
      required this.namedepartment,
      required this.codegroup,
      required this.codegroupemp,
      required this.numbercodemed,
      required this.typemed,
      required this.savedate,
      required this.yearmed,
      required this.patienttype,
      required this.patientname,
      required this.hospitalcode,
      required this.hospitalname,
      required this.hospitaltype,
      required this.claimstartdate,
      required this.claimenddate,
      required this.idreceiptnumber,
      required this.receiptnumber,
      required this.tel,
      required this.diseasecode,
      required this.namedisease,
      required this.diseasegroup,
      required this.medicalcode,
      required this.medicallist,
      required this.numberdays,
      required this.amount,
      required this.othernotes,
      required this.receiptamount,
      required this.payamount,
      required this.paydate});
}

List<ListdataMedical> ListdataMedicalmodal = [
  ListdataMedical(
    empcode: '57315',
    fname: 'หนึ่งฤทัย พวงแก้ว',
    lname: 'พวงแก้ว',
    codedepartment: 'ฝ่ายทรัพยากรบุคคล',
    namedepartment: 'ส่วนสวัสดิการ',
    codegroup: '',
    codegroupemp: '',
    numbercodemed: '2020340000007',
    typemed: 'ขอเบิก',
    savedate: '06.01.2022 10.00 AM',
    yearmed: '2022',
    patienttype: '',
    patientname: '',
    hospitalcode: '',
    hospitalname: 'โรงพยาบาลอังคทวนิช',
    hospitaltype: 'เอกชน',
    claimstartdate: '01.01.2022',
    claimenddate: '06.01.2022',
    idreceiptnumber: 'OPD-20200610001',
    receiptnumber: 'ส1',
    tel: '0954875370',
    diseasecode: '10000002',
    namedisease: 'ติดเชื้อไวรัส',
    diseasegroup: 'ผิวหนัง',
    medicalcode: '001',
    medicallist: 'ค่ายาและค่ารักษา',
    numberdays: '5',
    amount: '800',
    othernotes: '.....',
    receiptamount: '1500',
    payamount: '1000',
    paydate: '07.01.2022',
  ),
    ListdataMedical(
    empcode: '57315',
    fname: 'หนึ่งฤทัย พวงแก้ว',
    lname: 'พวงแก้ว',
    codedepartment: 'ฝ่ายทรัพยากรบุคคล',
    namedepartment: 'ส่วนสวัสดิการ',
    codegroup: '',
    codegroupemp: '',
    numbercodemed: '2020340000007',
    typemed: 'ขอเบิก',
    savedate: '06.10.2022 15.00 AM',
    yearmed: '2022',
    patienttype: '',
    patientname: '',
    hospitalcode: '',
    hospitalname: 'โรงพยาบาลพระราม 9',
    hospitaltype: 'เอกชน',
    claimstartdate: '01.10.2022',
    claimenddate: '06.10.2022',
    idreceiptnumber: 'OPD-20200610010',
    receiptnumber: 'ป1',
    tel: '0954875370',
    diseasecode: '10000003',
    namedisease: 'ไข้หวัด',
    diseasegroup: 'ทางเดินหายใจ',
    medicalcode: '001',
    medicallist: 'ค่ายาและค่ารักษา',
    numberdays: '5',
    amount: '1000',
    othernotes: '.....',
    receiptamount: '1500',
    payamount: '1000',
    paydate: '07.10.2022',
  )
];
