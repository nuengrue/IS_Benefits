import 'dart:async';

import 'package:ghb_benefits/All_Models/child_allowane_model.dart';
import 'package:ghb_benefits/All_Services/servics.dart';

class ChildAllowanceController {
  final FirebaseServices servies;
  List<ChildAllowance> allowances = List.empty();

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  ChildAllowanceController(this.servies);

  Future<List<ChildAllowance>> fetchChildAllowance() async {
    onSyncController.add(true);
    allowances = await servies.getChildAllowance();
    onSyncController.add(false);
    return allowances;
  }
    Future<List<ChildAllowance>> fetchChildAllowanceno() async {
    onSyncController.add(true);
    allowances = await servies.getChildAllowanceno();
    onSyncController.add(false);
    return allowances;
  }

/*
  void updateTodo(ChildAllowaneModel todo) async{
    servies.update(todo);
  }
  */
}
