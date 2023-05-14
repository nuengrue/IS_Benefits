import 'dart:async';
import 'package:ghb_benefits/All_Models/house_model.dart';
import 'package:ghb_benefits/All_Services/servics.dart';


class HouseAllowanceController {
  final FirebaseServices servies;
  List<HouseAllowance> houses = List.empty();

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  HouseAllowanceController(this.servies);

  Future<List<HouseAllowance>> fetchHouseAllowance() async {
    onSyncController.add(true);
    houses = await servies.getHouseAllowance();
    onSyncController.add(false);
    return houses;
  }

    Future<List<HouseAllowance>> fetchHouseAllowanceno() async {
    onSyncController.add(true);
    houses = await servies.getHouseAllowancenon();
    onSyncController.add(false);
    return houses;
  }

/*
  void updateTodo(ChildAllowaneModel todo) async{
    servies.update(todo);
  }
  */
}
