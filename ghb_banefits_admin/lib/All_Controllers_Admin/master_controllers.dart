import 'dart:async';

import 'package:ghb_banefits_admin/All_Models_Admin/Notifications_model.dart';
import 'package:ghb_banefits_admin/All_Models_Admin/employee_model.dart';
import 'package:ghb_banefits_admin/All_Services_Admin/servics.dart';


class MasterController {
  final FirebaseServicesAdmin servies;
  // List<Child> childers = List.empty();
  List<Employee> employees = List.empty();
    List<NotificationsAdmin> notifications = List.empty();

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  MasterController(this.servies);

  // Future<List<Child>> fetchChilder() async {
  //   onSyncController.add(true);
  //   childers = await servies.getChilder();
  //   onSyncController.add(false);
  //   return childers;
  // }

    Future<List<Employee>> fetchEmployee() async {
    onSyncController.add(true);
    employees = await servies.getEmployee();
    onSyncController.add(false);
    return employees;
  }
    Future<List<NotificationsAdmin>> fetchNotiAdmin() async {
    onSyncController.add(true);
    notifications = await servies.getNotiAdmin();
    onSyncController.add(false);
    return notifications;
  }
/*
  void updateTodo(ChildAllowaneModel todo) async{
    servies.update(todo);
  }
  */
}
