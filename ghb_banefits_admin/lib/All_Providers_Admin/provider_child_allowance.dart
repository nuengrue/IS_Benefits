import 'package:flutter/widgets.dart';
import 'package:ghb_banefits_admin/All_Controllers_Admin/child_allowance_controllers.dart';
import 'package:ghb_banefits_admin/All_Models_Admin/child_allowane_model.dart';
import 'package:ghb_banefits_admin/All_Services_Admin/servics.dart';



class ChildAllowanceAdminProviders with ChangeNotifier {

  ChildAllowanceAdminController controller =
      ChildAllowanceAdminController(FirebaseServicesAdmin());

      

 List<ChildAllowanceAdmin> _ChildAllowanceAdminList  =  [];
 List<ChildAllowanceAdmin> get ChildAllowanceAdminList => this._ChildAllowanceAdminList;




 set ChildAllowanceAdminList(List<ChildAllowanceAdmin> value) {

  this._ChildAllowanceAdminList = value;

  notifyListeners();
  } 
 

  int _countAllChildAllowanceAdmin = 0;
  get fliecountAllChildAllowanceAdmin => this._countAllChildAllowanceAdmin;

  set fliecountAllChildAllowanceAdmin(value) {
    this._countAllChildAllowanceAdmin = value;
    notifyListeners();
    
  }

    int _countRequestChildAllowanceAdmin = 0;
  get fliecountRequestChildAllowanceAdmin => this._countRequestChildAllowanceAdmin;

  set fliecountRequestChildAllowanceAdmin(value) {
    this._countRequestChildAllowanceAdmin = value;
    notifyListeners();
    
  }
      int _countApproveChildAllowanceAdmin = 0;
  get fliecountApproveChildAllowanceAdmin => this._countApproveChildAllowanceAdmin;

  set fliecountApproveChildAllowanceAdmin(value) {
    this._countApproveChildAllowanceAdmin = value;
    notifyListeners();
    
  }

        int _countRejectChildAllowanceAdmin = 0;
  get fliecountRejectChildAllowanceAdmin => this._countRejectChildAllowanceAdmin;

  set fliecountRejectChildAllowanceAdmin(value) {
    this._countRejectChildAllowanceAdmin = value;
    notifyListeners();
    
  }
// function to update data to list of notes
void modify(int Indexs, String status, String flagread){
  _ChildAllowanceAdminList[Indexs].status = status ;
  _ChildAllowanceAdminList[Indexs].flagread = flagread; 

  notifyListeners();

}




 

// function to add data to list of notes 
//  void addChildAllowane( 
//    String no,
//    String empcode,
//    String nameemp,
//    String department,
//    String divisionment,
//    String savedate,
//    String namechild,
//    String namepartner,
//    String officetner,
//    String maritalstatus,
//    String submaritalstatus,
//    String status,
//    String email, 
//    String fileUrl, 
//    String filename, 
//    String read, 
//    String id, 
// )

//  {
//    ChildAllowance ChildAllowane = new ChildAllowance(
//     no,
//     empcode,
//     nameemp,
//     department,
//     divisionment,
//     savedate,
//     namechild,
//     namepartner,
//     officetner,
//     maritalstatus,
//     submaritalstatus,
//     status,
//     email,
//     fileUrl,
//     filename,
//     read,
//     id,);


//    _ChildAllowanceList.add(ChildAllowane);

//     notifyListeners();
//  }


}



/*
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:ghb_benefits/child_allowance/child_allowane_model.dart';
import 'package:ghb_benefits/child_allowance/model.dart';
import 'package:ghb_benefits/services/firebaseservice.dart';



class ChildAllowaneProviders with ChangeNotifier {
  final firestoreService = FirebaseServices();
      late final FirebaseServices servies;
  //Notes List
 //List<ChildAllowaneModel> _childAllowaneList  =  [];
 
 // List<ChildAllowaneModel> _childAllowaneList  =  List.empty();
      late ChildAllowaneModel childAllowaneModel;
/*
     childAllowaneModels(QueryDocumentSnapshot element){
     childAllowaneModel = ChildAllowaneModel(
            no : element.get("no"),
            empcode : element.get("empcode"),
            nameemp : element.get("nameemp"),
            department : element.get("department"),
            divisionment : element.get("divisionment"),
            savedate : element.get("savedate"),
            namechild : element.get("namechild"),
            namepartner : element.get("namepartner"),
            officetner : element.get("officetner"),
            maritalstatus : element.get("maritalstatus"),
            submaritalstatus : element.get("submaritalstatus"),
            status : element.get("status"),
            email : element.get("email"),
     );
     }
     */
    
     // List<ChildAllowaneModel> get data => List<ChildAllowaneModel>;

 List<ChildAllowaneModel> _childAllowaneList  =  [];
 
 void  fatchDatas() async {

  List<ChildAllowaneModel> listnew = [];

    listnew = await servies.getdata();
    print(listnew);

      _childAllowaneList = listnew ;
         notifyListeners();
}
/*
   fatchData() async {
     List<ChildAllowaneModel> newList  =  [];
         // List<ChildAllowaneModel> newLists  =  [];
     QuerySnapshot value = 
     /*
     await FirebaseFirestore.instance.collection('ChildAllowance').get();
     print(value);
     value.docs.forEach((element) { 
      childAllowaneModels(element);
      newList.add(childAllowaneModel);
      print(newList);
     },
     );
     */

     await FirebaseFirestore.instance.collection('ChildAllowance').get().then((value) => {
          value.docs.forEach((element) {
            print(element.id);
            var p = AllOrders.fromSnapshot(element);
            newList.add(p);
          })
        });


      _childAllowaneList = newList ;
         notifyListeners();
     //newList.add();

      }

*/
 /// _childAllowaneList = newList;


//List<Notes> _notes = new List<Notes>();

 //Stream<List<Childall>> get getentries => firestoreService.getdata();

 List<ChildAllowaneModel> get getChildAllowane{ 
  return _childAllowaneList;
  }

/*
Future getChildAllowane() async {
  List<ChildAllowaneModel> _childAllowaneList  =  [];
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("collection").get();

  querySnapshot.docs.forEach((element) {
    childAllowaneModel = ChildAllowaneModel(
      no : element.get("no"),

    );

    

  },);

}

*/
 

// function to add data to list of notes 
 void addChildAllowane( 
   String no,
   String empcode,
   String nameemp,
   String department,
   String divisionment,
   String savedate,
   String namechild,
   String namepartner,
   String officetner,
   String maritalstatus,
   String submaritalstatus,
   String status,
   String email, 
)
 {
   ChildAllowaneModel ChildAllowane = new ChildAllowaneModel(
    no,
    empcode,
    nameemp,
    department,
    divisionment,
    savedate,
    namechild,
    namepartner,
    officetner,
    maritalstatus,
    submaritalstatus,
    status,
    email, );
    /*
    no : no,
    empcode : empcode,
    nameemp : nameemp,
    department : department,
    divisionment : divisionment,
    savedate : savedate,
    namechild : namechild,
    namepartner : namepartner,
    officetner : officetner,
    maritalstatus : maritalstatus,
    submaritalstatus : submaritalstatus,
    status : status,
    email :email, );
    */

   _childAllowaneList.add(ChildAllowane);

    notifyListeners();
 }


}
*/