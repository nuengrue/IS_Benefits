import 'dart:async';

import 'package:ghb_benefits/All_Services/servics.dart';
import 'package:ghb_benefits/All_Models/cremation_service_model.dart';



class CremationServiceController {
  final FirebaseServices servies;
  List<CremationService> Cremations = List.empty();

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  CremationServiceController(this.servies);

  Future<List<CremationService>> fetchCremationService() async {
    onSyncController.add(true);
    Cremations = await servies.getCremationService();
    onSyncController.add(false);
    return Cremations;
  }

/*
  void updateTodo(ChildAllowaneModel todo) async{
    servies.update(todo);
  }
  */
}
