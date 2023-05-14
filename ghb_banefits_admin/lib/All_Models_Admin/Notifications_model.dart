
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationsAdmin {
  int no;
  final String title;
  final String content;
  final int read;
  final String createDate;
  final String uid; 
  String id;
  final  String   remarks;
  NotificationsAdmin(
       this.no,
       this.title,
       this.content,
       this.read,
       this.createDate,
       this.uid,
       this.id,
       this.remarks,);

factory NotificationsAdmin.fromJson(Map<String, dynamic> json) {
    print(json);
    return NotificationsAdmin(
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


class AllNotificationsAdmin {
  final List<NotificationsAdmin> notifications;

  AllNotificationsAdmin(this.notifications);
  factory AllNotificationsAdmin.fromJson(List<dynamic> json) {
    List<NotificationsAdmin> notifications;
    notifications = json.map((item) => NotificationsAdmin.fromJson(item)).toList();
    return AllNotificationsAdmin(notifications);
  }
  factory AllNotificationsAdmin.fromSnapshot(QuerySnapshot s){
     List<NotificationsAdmin> notifications = s.docs.map((DocumentSnapshot ds) {
       NotificationsAdmin notification  = NotificationsAdmin.fromJson(ds.data() as Map<String, dynamic>);
      // notification.no = ds.id.substring(1,8);
      // print(ds.id);
      return notification;


    }).toList();

    return AllNotificationsAdmin(notifications);
  }
}
