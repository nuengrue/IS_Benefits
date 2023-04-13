import 'dart:async';

import 'package:ghb_banefits_admin/All_Models_Admin/medical_model.dart';
import 'package:ghb_banefits_admin/All_Services_Admin/servics.dart';




class MedicalAdminController {
  final FirebaseServicesAdmin servies;
  List<MedicalAdmin> medicals = List.empty();

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  MedicalAdminController(this.servies);

  Future<List<MedicalAdmin>> fetchMedicalAdmin() async {
    onSyncController.add(true);
    medicals = await servies.getMedicalAdmin();
    onSyncController.add(false);
    return medicals;
  }

/*
  void updateTodo(ChildAllowaneModel todo) async{
    servies.update(todo);
  }
  */
}
