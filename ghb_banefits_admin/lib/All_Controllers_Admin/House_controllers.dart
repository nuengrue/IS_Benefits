import 'dart:async';

import 'package:ghb_banefits_admin/All_Models_Admin/house_model.dart';
import 'package:ghb_banefits_admin/All_Services_Admin/servics.dart';



class HouseAllowanceAdminController {
  final FirebaseServicesAdmin servies;
  List<HouseAllowanceAdmin> houses = List.empty();

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  HouseAllowanceAdminController(this.servies);

  Future<List<HouseAllowanceAdmin>> fetchHouseAllowanceAdmin() async {
    onSyncController.add(true);
    houses = await servies.getHouseAllowanceAdmin();
    onSyncController.add(false);
    return houses;
  }

/*
  void updateTodo(ChildAllowaneModel todo) async{
    servies.update(todo);
  }
  */
}
