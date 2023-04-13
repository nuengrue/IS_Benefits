import 'dart:async';

import 'package:ghb_banefits_admin/All_Models_Admin/cremation_service_model.dart';
import 'package:ghb_banefits_admin/All_Services_Admin/servics.dart';




class CremationServiceAdminController {
  final FirebaseServicesAdmin servies;
  List<CremationServiceAdmin> Cremations = List.empty();

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  CremationServiceAdminController(this.servies);

  Future<List<CremationServiceAdmin>> fetchCremationServiceAdmin() async {
    onSyncController.add(true);
    Cremations = await servies.getCremationServiceAdmin();
    onSyncController.add(false);
    return Cremations;
  }

/*
  void updateTodo(ChildAllowaneModel todo) async{
    servies.update(todo);
  }
  */
}
