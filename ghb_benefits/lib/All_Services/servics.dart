
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ghb_benefits/All_Models/child_allowane_model.dart';
import 'package:ghb_benefits/All_Models/childer_model.dart';
import 'package:ghb_benefits/All_Models/cremation_service_model.dart';
import 'package:ghb_benefits/All_Models/employee_model.dart';
import 'package:ghb_benefits/All_Models/house_model.dart';

import 'package:ghb_benefits/All_Models/medical_model.dart';
import 'package:ghb_benefits/All_Models/education_model.dart';
import 'package:http/http.dart';

class FirebaseServices{
    final user = FirebaseAuth.instance.currentUser!;
  Future<List<Employee>> getEmployee() async {
   QuerySnapshot snapshot = 
   await FirebaseFirestore.instance.collection('Employee').where('uid',isEqualTo: user.uid).get();

   AllEmployee employee = AllEmployee.fromSnapshot(snapshot);
   return employee.employees;
  }

  Future<List<Childer>> getChilder() async {
   QuerySnapshot snapshot = 
   await FirebaseFirestore.instance.collection('Childer').where('uid',isEqualTo: user.uid).get();

   AllChilder childer = AllChilder.fromSnapshot(snapshot);
   return childer.childers;
  }

  Future<List<ChildAllowance>> getChildAllowance() async {
   QuerySnapshot snapshot = 
   await FirebaseFirestore.instance.collection('ChildAllowance').where('email',isEqualTo: user.uid).get();

   AllChildAllowance allowance = AllChildAllowance.fromSnapshot(snapshot);
   return allowance.allowances;
  }
// get CremationService
  Future<List<CremationService>> getCremationService() async {
   QuerySnapshot snapshot = 
   await FirebaseFirestore.instance.collection('CremationService').where('email',isEqualTo: user.uid).get();

   AllCremationService Cremation = AllCremationService.fromSnapshot(snapshot);
   return Cremation.Cremations;

  }

    Future<List<HouseAllowance>> getHouseAllowance() async {
   QuerySnapshot snapshot = 
   await FirebaseFirestore.instance.collection('HouseAllowance').where('email',isEqualTo: user.uid).get();

   AllHouseAllowance house = AllHouseAllowance.fromSnapshot(snapshot);
   return house.houses;

  }
      Future<List<Medical>> getMedical() async {
   QuerySnapshot snapshot = 
   await FirebaseFirestore.instance.collection('Medical').where('email',isEqualTo: user.uid).get();

   AllMedical medical = AllMedical.fromSnapshot(snapshot);
   return medical.medicals;

  }

        Future<List<Education>> getEducation() async {
   QuerySnapshot snapshot = 
   await FirebaseFirestore.instance.collection('Education').where('email',isEqualTo: user.uid).get();

   AllEducation education = AllEducation.fromSnapshot(snapshot);
   return education.educations;

  }

     Future<List<Medical>> getMedicalDashboard() async {
   QuerySnapshot snapshot = 
   await FirebaseFirestore.instance.collection('Medical').where('email',isEqualTo: user.uid).where('status',isEqualTo: "Approve").get();
     
   AllMedical medical = AllMedical.fromSnapshot(snapshot);
   
   return medical.medicals;

  }

        Future<List<Education>> getEducationDashboard() async {
   QuerySnapshot snapshot = 
   await FirebaseFirestore.instance.collection('Education').where('email',isEqualTo: user.uid).where('status',isEqualTo: "Approve").get();

   AllEducation education = AllEducation.fromSnapshot(snapshot);
   return education.educations;

  }


/*
  void update(Todo todos) async {
    final todoRef = 
    await FirebaseFirestore.instance.
    collection('todos').
    where('id',isEqualTo: todos.id);
    //todoRef.count();
   print('update ${todos.id}');
    await FirebaseFirestore.instance.collection('todos').doc(todos.id).update({
      'completed' : todos.completed,

    });



  }
  */


}
