import 'dart:async';

import 'package:ghb_benefits/All_Models/Notifications_model.dart';
import 'package:ghb_benefits/All_Services/servics.dart';

class NotificationsController {
  final FirebaseServices servies;
  List<Notifications> notifications = List.empty();

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  NotificationsController(this.servies);

  Future<List<Notifications>> fetchNotifications() async {
    onSyncController.add(true);
    notifications = await servies.getNotifications();
    onSyncController.add(false);
    return notifications;
  }


/*
  void updateTodo(ChildAllowaneModel todo) async{
    servies.update(todo);
  }
  */
}
