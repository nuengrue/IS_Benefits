import 'dart:async';

import 'package:ghb_benefits/All_Services/servics.dart';
import 'package:ghb_benefits/All_Models/education_model.dart';

class EducationController {
  final FirebaseServices servies;
  List<Education> educations = List.empty();

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  EducationController(this.servies);

  Future<List<Education>> fetchEducation() async {
    onSyncController.add(true);
    educations = await servies.getEducation();
    onSyncController.add(false);
    return educations;
  }

/*
  void updateTodo(ChildAllowaneModel todo) async{
    servies.update(todo);
  }
  */
}
