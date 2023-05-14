
import 'package:flutter/widgets.dart';
import 'package:ghb_benefits/All_Services/servics.dart';

import 'package:ghb_benefits/All_Models/education_model.dart';
import 'package:ghb_benefits/All_Controllers/Education_Controller.dart';



class EducationProviders with ChangeNotifier {

    EducationController controller =
      EducationController(FirebaseServices());

      

 List<Education> _EducationeList  =  [];
 List<Education> get EducationList => this._EducationeList;




 set EducationList(List<Education> value) {

  this._EducationeList = value;

  notifyListeners();
  } 

 
//   final firestoreService = FirebaseServices();
//   //Notes List
//   List<EducationModels> _educationList = [];
//   // List<ChildAllowaneModel> _childAllowaneList  =  List.empty();
//   late EducationModels educationModels;

//   // List<ChildAllowaneModel> get data => List<ChildAllowaneModel>;

// //List<Notes> _notes = new List<Notes>();

//  // Stream<List<Childall>> get getentries => firestoreService.getdata();

//   List<EducationModels> get getEducation {
//     return _educationList;
//   }

// function to add data to list of notes
  void addEducation(
    int no,
    String empcode,
    String name,
    String department,
    String divisionment,
//
    String typeedu,
    String yearedu,
    String savedate,
//

    String namechild,

//
    String level,
    String school,
    String year,
    String term,
    String educationlevel,
    String schooltype,
//
    String receiptnumber,
    String volume,
    String tel,
    String receiptdate,
    //
    String amountreceipt,

    ///
    String payamount,
    String paydate,
    String status,
    String email,
       String fileUrl, 
   String filename, 
   String read, 
   String id,
      String remarks, 
  ) {
    Education education = new Education(
      no,

      empcode,
      name,
      department,
      divisionment,
//
      typeedu,
      yearedu,
      savedate,
//

      namechild,

//
      level,
      school,
      year,
      term,
      educationlevel,
      schooltype,
//
      receiptnumber,
      volume,
      tel,
      receiptdate,
      //
      amountreceipt,

      ///
      payamount,
      paydate,
      status,
      email,
          fileUrl,
    filename,
    read,
    id,
    remarks,);

    _EducationeList.add(education);

    notifyListeners();
  }
}
