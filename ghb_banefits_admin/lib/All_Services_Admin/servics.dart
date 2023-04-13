
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ghb_banefits_admin/All_Models_Admin/child_allowane_model.dart';
import 'package:ghb_banefits_admin/All_Models_Admin/cremation_service_model.dart';
import 'package:ghb_banefits_admin/All_Models_Admin/education_model.dart';
import 'package:ghb_banefits_admin/All_Models_Admin/house_model.dart';
import 'package:ghb_banefits_admin/All_Models_Admin/medical_model.dart';


class FirebaseServicesAdmin{
  Future<List<ChildAllowanceAdmin>> getChildAllowanceAdmin() async {
   QuerySnapshot snapshot = 
   await FirebaseFirestore.instance.collection('ChildAllowance').get();

   AllChildAllowanceAdmin allowance = AllChildAllowanceAdmin.fromSnapshot(snapshot);
   return allowance.allowances;
  }
// get CremationService
  Future<List<CremationServiceAdmin>> getCremationServiceAdmin() async {
   QuerySnapshot snapshot = 
   await FirebaseFirestore.instance.collection('CremationService').get();

   AllCremationServiceAdmin Cremation = AllCremationServiceAdmin.fromSnapshot(snapshot);
   return Cremation.Cremations;

  }

    Future<List<HouseAllowanceAdmin>> getHouseAllowanceAdmin() async {
   QuerySnapshot snapshot = 
   await FirebaseFirestore.instance.collection('HouseAllowance').get();

   AllHouseAllowanceAdmin house = AllHouseAllowanceAdmin.fromSnapshot(snapshot);
   return house.houses;

  }
      Future<List<MedicalAdmin>> getMedicalAdmin() async {
   QuerySnapshot snapshot = 
   await FirebaseFirestore.instance.collection('Medical').get();

   AllMedicalAdmin medical = AllMedicalAdmin.fromSnapshot(snapshot);
   return medical.medicals;

  }

        Future<List<EducationAdmin>> getEducationAdmin() async {
   QuerySnapshot snapshot = 
   await FirebaseFirestore.instance.collection('Education').get();

   AllEducationAdmin education = AllEducationAdmin.fromSnapshot(snapshot);
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
