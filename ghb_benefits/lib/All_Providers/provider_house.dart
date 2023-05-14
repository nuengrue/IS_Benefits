

import 'package:flutter/widgets.dart';
import 'package:ghb_benefits/All_Models/house_model.dart';
import 'package:ghb_benefits/All_Services/servics.dart';
import 'package:ghb_benefits/All_Controllers/House_controllers.dart';


import 'dart:convert';



class HouseAllowanceProviders with ChangeNotifier {
  //final firestoreService = FirebaseServices();
  //Notes List

    // HouseAllowanceController controller =
    //   HouseAllowanceController(FirebaseServices());

   List<HouseAllowance> _houseAllowanceList  =  [];
 List<HouseAllowance> get HouseAllowanceList => this._houseAllowanceList;




 set HouseAllowanceList(List<HouseAllowance> value) {

  this._houseAllowanceList = value;

  notifyListeners();
  } 

//  List<HouseAllowance> _houseAllowanceList  =  [];
//  // List<ChildAllowaneModel> _childAllowaneList  =  List.empty();
//     late HouseAllowance houseAllowanceModels;
    
    
//      // List<ChildAllowaneModel> get data => List<ChildAllowaneModel>;


// //List<Notes> _notes = new List<Notes>();

// // Stream<List<Childall>> get getentries => firestoreService.getdata();

//  List<HouseAllowanceModels> get gethouseallowance{ return _houseAllowanceList;}

 

// function to add data to list of notes 
 void addHouseAllowance( 
  int no,
   String empcode,
   String name,
   String department,
   String divisionment,
   String savedate,
   String startdate,
//
   String position,
   String segment,
   String departmentwork,
   String provincework,
   String positiondate,
//
   String typehouse,
   String moneyhouse,
   String housenumber,
   String alley,
   String road,
   String district,
   String county,
   String province,
   String workstatus,
//
  ///
   String payamount,
   String paydate,
   String status,
   String email,
      String fileUrl, 
   String filename, 
   String read, 
   String id, 
      String remarks, )
 {
   HouseAllowance houseAllowance = new HouseAllowance(
    no,
    empcode,
    name,
    department,
    divisionment,
    savedate,
    startdate,
    position,
    segment,
    departmentwork,
    provincework,
    positiondate,
    typehouse,
    moneyhouse,
    housenumber,
    alley,
    road,
    district,
    county,
    province,
    workstatus,
    payamount,
    paydate,
    status,
    email,
    fileUrl,
    filename,
    read,
    id,
    remarks,);

   _houseAllowanceList.add(houseAllowance);

    notifyListeners();
 }


}