import 'dart:async';

import 'package:ghb_banefits_admin/All_Models_Admin/child_allowane_model.dart';
import 'package:ghb_banefits_admin/All_Services_Admin/servics.dart';



class ChildAllowanceAdminController {
  final FirebaseServicesAdmin servies;
  List<ChildAllowanceAdmin> allowances = List.empty();

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  ChildAllowanceAdminController(this.servies);

  Future<List<ChildAllowanceAdmin>> fetchChildAllowanceAdmin() async {
    onSyncController.add(true);
    allowances = await servies.getChildAllowanceAdmin();
    onSyncController.add(false);
    return allowances;
  }

  fetchChildAllowanceAdmid() {}

/*
  void updateTodo(ChildAllowaneModel todo) async{
    servies.update(todo);
  }
  */
}
