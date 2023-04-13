import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<Notification> notifications = List.empty();
  bool isloading = false;

  NotificationController controller = NotificationController(HttpServies());

  void initState() {
    super.initState();
    controller.onSync.listen((bool synState) => setState(() {
          isloading = synState;
        }));
  }

  void _getNotifications() async {
    var newNotifications = await controller.fetchNotifications();
    setState(() => notifications = newNotifications);
  }

  Widget get body => isloading
      ? CircularProgressIndicator()
      : ListView.builder(
          itemCount: !notifications.isEmpty ? notifications.length : 1,
          itemBuilder: (context, index) {
            if (!notifications.isEmpty) {
              return ListTile(
                title: Text(notifications[index].title),
                subtitle: Text(notifications[index].status),
                leading: Image.asset('images/notification.png',height: 50,),
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Tab button to fetch notifications'),
                ],
              );
            }
          });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
      ),
      body: Center(
        child: body,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _getNotifications(),
        child: Icon(Icons.add),
      ),
    );
  }
}

class Notification {
  final int empcode;
  final int id;
  final int typemodule;
  final String title;
  final String status;


  Notification(this.empcode, this.id, this.typemodule, this.title, this.status);

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      json['empcode'] as int,
      json['id'] as int,
      json['typemodule'] as int,
      json['title'] as String,
      json['status'] as String,
    );
  }
}

class AllNotifications {
  final List<Notification> notifications;

  AllNotifications(this.notifications);
  factory AllNotifications.fromJson(List<dynamic> json) {
    List<Notification> notifications;
    notifications = json.map((item) => Notification.fromJson(item)).toList();
    return AllNotifications(notifications);
  }
}
/*
class HttpServies {
  Client client = Client();
  Future<List<Notification>> getNotifications() async {
    final response = await client.get(Uri.parse(
      'assets/no.json',
    ));
    
    if (response.statusCode == 200) {
      var all = AllNotifications.fromJson(json.decode(response.body));
      return all.notifications;
    } else {
      throw Exception('Fail to load Notifications');
    }
  }
}
*/
class HttpServies {
  Client client = Client();
  Future<List<Notification>> getNotifications() async {
    //final assetBundle = DefaultAssetBundle.of(context);
    //final response = await assetBundle.loadString('assets/no.json');
        //List<Notification> notifications;
        final jsondata = await rootBundle.loadString('assets/no.json');
       // final response = 'assets/no.json';
    
    if (!jsondata.isEmpty) {
      var all = AllNotifications.fromJson(json.decode(jsondata));
      return all.notifications;
    } else {
      throw Exception('Fail to load Notifications');
    }
  }
}
class NotificationController {
  final HttpServies servies;
  List<Notification> notifications = List.empty();

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  NotificationController(this.servies);

  Future<List<Notification>> fetchNotifications() async {
    onSyncController.add(true);
    notifications = await servies.getNotifications();
    onSyncController.add(false);
    return notifications;
  }
}
