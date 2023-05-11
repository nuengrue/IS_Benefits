import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:ghb_benefits/All_Controllers/Notifications_controllers.dart';
import 'package:ghb_benefits/All_Models/Notifications_model.dart';
import 'package:ghb_benefits/All_Services/servics.dart';
import 'package:path/path.dart';


class NotificationsProviders with ChangeNotifier {

  NotificationsController controller =
      NotificationsController(FirebaseServices());

 List<Notifications> _NotificationsList  =  [];
 List<Notifications> get NotificationsList => this._NotificationsList;

 set NotificationsList(List<Notifications> value) {

  this._NotificationsList = value;

  notifyListeners();
  } 
}


