import 'package:cloud_firestore/cloud_firestore.dart';

class Employee {
  final String  no;
  final String empcode;
  final String nameemp;
  final String department;
  final String divisionment;
  final String date;
  final String uid;
  final String idcard;
  
  Employee(
    this.no,
    this.empcode,
    this.nameemp,
    this.department,
    this.divisionment,
    this.date,
    this.uid,
    this.idcard,
  );

  factory Employee.fromJson(Map<String, dynamic> json) {
    print(json);
    return Employee(
      json['no'] as String,
      json['empcode'] as String,
      json['nameemp'] as String,
      json['department'] as String,
      json['divisionment'] as String,
      json['date'] as String,
      json['uid'] as String,
      json['idcard'] as String,      
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'no': no,
      'empcode': empcode,
      'nameemp': nameemp,
      'department': department,
      'divisionment': divisionment,
      'date': date,
      'uid': uid,
      'idcard': idcard,      
    };
  }
}

class AllEmployee {
  final List<Employee> employees;

  AllEmployee(this.employees);
  factory AllEmployee.fromJson(List<dynamic> json) {
    List<Employee> employees;
    employees = json.map((item) => Employee.fromJson(item)).toList();
    return AllEmployee(employees);
  }
  factory AllEmployee.fromSnapshot(QuerySnapshot s) {
    List<Employee> employees = s.docs.map((DocumentSnapshot ds) {
      Employee employee = Employee.fromJson(ds.data() as Map<String, dynamic>);
      return employee;
    }).toList();

    return AllEmployee(employees);
  }
}
