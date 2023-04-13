import 'package:flutter/material.dart';

class Medtreat{
  final String medicallist;
  final String numberdays;
  final String amount;
  final String othernotes;
  Medtreat(this.medicallist,this.numberdays,this.amount,this.othernotes);

  
factory Medtreat.fromJson(Map<String, dynamic> json) {
    return Medtreat(
      json['medicallist'] as String,
      json['numberdays'] as String,
      json['amount'] as String,
      json['othernotes'] as String
    );
  }

  Map<String,dynamic> toMap(){
  return{
    'medicallist' : medicallist,
    'numberdays' : numberdays,
    'amount' : amount,
    'othernotes' : othernotes,
  };
}
}