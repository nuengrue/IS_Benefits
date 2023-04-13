import 'dart:async';

import 'package:ghb_banefits_admin/All_Models_Admin/education_model.dart';
import 'package:ghb_banefits_admin/All_Services_Admin/servics.dart';


class EducationAdminController {
  final FirebaseServicesAdmin servies;
  List<EducationAdmin> educations = List.empty();

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  EducationAdminController(this.servies);

  Future<List<EducationAdmin>> fetchEducationAdmin() async {
    onSyncController.add(true);
    educations = await servies.getEducationAdmin();
    onSyncController.add(false);
    return educations;
  }

/*
  void updateTodo(ChildAllowaneModel todo) async{
    servies.update(todo);
  }
  */
}
