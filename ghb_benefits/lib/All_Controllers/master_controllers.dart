import 'dart:async';

import 'package:ghb_benefits/All_Models/child_allowane_model.dart';
import 'package:ghb_benefits/All_Models/child_model.dart';
import 'package:ghb_benefits/All_Models/employee_model.dart';
import 'package:ghb_benefits/All_Services/servics.dart';

class MasterController {
  final FirebaseServices servies;
  List<Child> childers = List.empty();
  List<Employee> employees = List.empty();

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  MasterController(this.servies);

  Future<List<Child>> fetchChilder() async {
    onSyncController.add(true);
    childers = await servies.getChilder();
    onSyncController.add(false);
    return childers;
  }

    Future<List<Employee>> fetchEmployee() async {
    onSyncController.add(true);
    employees = await servies.getEmployee();
    onSyncController.add(false);
    return employees;
  }

/*
  void updateTodo(ChildAllowaneModel todo) async{
    servies.update(todo);
  }
  */
}
