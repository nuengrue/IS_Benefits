import 'dart:async';

import 'package:ghb_benefits/All_Services/servics.dart';
import 'package:ghb_benefits/All_Models/medical_model.dart';



class MedicalController {
  final FirebaseServices servies;
  List<Medical> medicals = List.empty();

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  MedicalController(this.servies);

  Future<List<Medical>> fetchMedical() async {
    onSyncController.add(true);
    medicals = await servies.getMedical();
    onSyncController.add(false);
    return medicals;
  }

    Future<List<Medical>> fetchMedicalDashboard() async {
    onSyncController.add(true);
    medicals = await servies.getMedicalDashboard();
    onSyncController.add(false);
    return medicals;
  }

/*
  void updateTodo(ChildAllowaneModel todo) async{
    servies.update(todo);
  }
  */
}
