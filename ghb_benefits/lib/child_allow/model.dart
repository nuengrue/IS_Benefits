import 'package:cloud_firestore/cloud_firestore.dart';

class ChildAll {
  String no;
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
  ChildAll(this.no,this.empcode, this.nameemp,this.department,this.divisionment,this.savedate,this.namechild
  ,this.namepartner,this.officetner,this.maritalstatus,this.submaritalstatus, this.status,this.email);

  factory ChildAll.fromJson(Map<String, dynamic> json) {
    return ChildAll(
      json['no'] as String,
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
    );
  }
}


class AllChildAlls {
  final List<ChildAll> orders;

  AllChildAlls(this.orders);
  factory AllChildAlls.fromJson(List<dynamic> json) {
    List<ChildAll> orders;
    orders = json.map((item) => ChildAll.fromJson(item)).toList();
    return AllChildAlls(orders);
  }
  factory AllChildAlls.fromSnapshot(QuerySnapshot s){
     List<ChildAll> orders = s.docs.map((DocumentSnapshot ds) {
       ChildAll order  = ChildAll.fromJson(ds.data() as Map<String, dynamic>);
       order.no = ds.id.substring(1,8);
      // print(ds.id);
      return order;


    }).toList();

    return AllChildAlls(orders);
  }
}