
import 'package:cloud_firestore/cloud_firestore.dart';

class Notifications {
  int no;
  final String title;
  final String content;
  late int read;
  final String createDate;
  final String uid; 
  String id;
  final  String   remarks;
  Notifications(
       this.no,
       this.title,
       this.content,
       this.read,
       this.createDate,
       this.uid,
       this.id,
       this.remarks,);

factory Notifications.fromJson(Map<String, dynamic> json) {
    print(json);
    return Notifications(
      json['no'] as int,
      json['title'] as String,
      json['content'] as String,
      json['read'] as int,
      json['createDate'] as String,
      json['uid'] as String,
      json['id'] as String,
      json['remarks'] as String,
    );
  }


  Map<String,dynamic> toMap(){
  return{
    'no' : no,
    'title' : title,
    'content' : content,
    'read' : read,
    'createDate' : createDate,
    'uid' : uid,        
    'id' : id, 
    'remarks' : remarks, 
  };
}

}


class AllNotifications {
  final List<Notifications> notifications;

  AllNotifications(this.notifications);
  factory AllNotifications.fromJson(List<dynamic> json) {
    List<Notifications> notifications;
    notifications = json.map((item) => Notifications.fromJson(item)).toList();
    return AllNotifications(notifications);
  }
  factory AllNotifications.fromSnapshot(QuerySnapshot s){
     List<Notifications> notifications = s.docs.map((DocumentSnapshot ds) {
       Notifications notification  = Notifications.fromJson(ds.data() as Map<String, dynamic>);
      // notification.no = ds.id.substring(1,8);
      // print(ds.id);
      return notification;


    }).toList();

    return AllNotifications(notifications);
  }
}
