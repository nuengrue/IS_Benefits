
import 'package:flutter/widgets.dart';
import 'package:ghb_banefits_admin/All_Controllers_Admin/Education_Controller.dart';
import 'package:ghb_banefits_admin/All_Models_Admin/education_model.dart';
import 'package:ghb_banefits_admin/All_Services_Admin/servics.dart';




class EducationAdminProviders with ChangeNotifier {

    EducationAdminController controller =
      EducationAdminController(FirebaseServicesAdmin());

      

 List<EducationAdmin> _EducationAdminList  =  [];
 List<EducationAdmin> get EducationAdminList => this._EducationAdminList;




 set EducationAdminList(List<EducationAdmin> value) {

  this._EducationAdminList = value;

  notifyListeners();
  } 
 int _countAllEducationAdmin = 0;
  get fliecountAllEducationAdmin => this._countAllEducationAdmin;

  set fliecountAllEducationAdmin(value) {
    this._countAllEducationAdmin = value;
    notifyListeners();
    
  }

    int _countRequestEducationAdmin = 0;
  get fliecountRequestEducationAdmin => this._countRequestEducationAdmin;

  set fliecountRequestEducationAdmin(value) {
    this._countRequestEducationAdmin = value;
    notifyListeners();
    
  }
      int _countApproveEducationAdmin = 0;
  get fliecountApproveEducationAdmin => this._countApproveEducationAdmin;

  set fliecountApproveEducationAdmin(value) {
    this._countApproveEducationAdmin = value;
    notifyListeners();
    
  }

        int _countRejectEducationAdmin = 0;
  get fliecountRejectEducationAdmin => this._countRejectEducationAdmin;

  set fliecountRejectEducationAdmin(value) {
    this._countRejectEducationAdmin = value;
    notifyListeners();
    
  }
// function to update data to list of notes
void modify(int Indexs, String status, String flagread, String payamount, String paydate, String remarks){
  _EducationAdminList[Indexs].status = status ;
  _EducationAdminList[Indexs].flagread = flagread; 
  _EducationAdminList[Indexs].payamount = payamount ;
  _EducationAdminList[Indexs].paydate = paydate; 
  _EducationAdminList[Indexs].remarks = remarks; 
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
//   void addEducation(
//     String no,
//     String empcode,
//     String name,
//     String department,
//     String divisionment,
// //
//     String typeedu,
//     String yearedu,
//     String savedate,
// //

//     String namechild,

// //
//     String level,
//     String school,
//     String year,
//     String term,
//     String educationlevel,
//     String schooltype,
// //
//     String receiptnumber,
//     String volume,
//     String tel,
//     String receiptdate,
//     //
//     String amountreceipt,

//     ///
//     String payamount,
//     String paydate,
//     String status,
//     String email,
//        String fileUrl, 
//    String filename, 
//    String read, 
//    String id,
//   ) {
//     Education education = new Education(
//       no,

//       empcode,
//       name,
//       department,
//       divisionment,
// //
//       typeedu,
//       yearedu,
//       savedate,
// //

//       namechild,

// //
//       level,
//       school,
//       year,
//       term,
//       educationlevel,
//       schooltype,
// //
//       receiptnumber,
//       volume,
//       tel,
//       receiptdate,
//       //
//       amountreceipt,

//       ///
//       payamount,
//       paydate,
//       status,
//       email,
//           fileUrl,
//     filename,
//     read,
//     id,
//     );

//     _EducationeList.add(education);

//     notifyListeners();
//   }
}
