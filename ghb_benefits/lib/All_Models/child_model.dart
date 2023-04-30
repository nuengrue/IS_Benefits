import 'package:cloud_firestore/cloud_firestore.dart';

class Child {
  String no;
  final int nochild;
  final String namechild;
  final String birthday;
  final String uid;
  Child(
    this.no,
    this.nochild,
    this.namechild,
    this.birthday,
    this.uid,
  );

  factory Child.fromJson(Map<String, dynamic> json) {
    print(json);
    return Child(
      json['no'] as String,
      json['nochild'] as int,
      json['namechild'] as String,
      json['birthday'] as String,
      json['uid'] as String,

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'no': no,
      'nochild': nochild,
      'namechild': namechild,
      'birthday': birthday,
      'uid': uid,
    };
  }
}

class AllChild {
  final List<Child> childs;

  AllChild(this.childs);
  factory AllChild.fromJson(List<dynamic> json) {
    List<Child> childs;
    childs = json.map((item) => Child.fromJson(item)).toList();
    return AllChild(childs);
  }
  factory AllChild.fromSnapshot(QuerySnapshot s) {
    List<Child> childs = s.docs.map((DocumentSnapshot ds) {
      Child child = Child.fromJson(ds.data() as Map<String, dynamic>);
      return child;
    }).toList();

    return AllChild(childs);
  }
}
