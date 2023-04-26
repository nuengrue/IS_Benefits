import 'package:cloud_firestore/cloud_firestore.dart';

class Childer {
  String no;
  final int nochild;
  final String namechild;
  final String date;
  final String uid;
  Childer(
    this.no,
    this.nochild,
    this.namechild,
    this.date,
    this.uid,
  );

  factory Childer.fromJson(Map<String, dynamic> json) {
    print(json);
    return Childer(
      json['no'] as String,
      json['nochild'] as int,
      json['namechild'] as String,
      json['date'] as String,
      json['uid'] as String,

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'no': no,
      'nochild': nochild,
      'namechild': namechild,
      'date': date,
      'uid': uid,
    };
  }
}

class AllChilder {
  final List<Childer> childers;

  AllChilder(this.childers);
  factory AllChilder.fromJson(List<dynamic> json) {
    List<Childer> childers;
    childers = json.map((item) => Childer.fromJson(item)).toList();
    return AllChilder(childers);
  }
  factory AllChilder.fromSnapshot(QuerySnapshot s) {
    List<Childer> childers = s.docs.map((DocumentSnapshot ds) {
      Childer childer = Childer.fromJson(ds.data() as Map<String, dynamic>);
      return childer;
    }).toList();

    return AllChilder(childers);
  }
}
