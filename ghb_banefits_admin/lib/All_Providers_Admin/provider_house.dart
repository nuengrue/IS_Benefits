

import 'package:flutter/widgets.dart';
import 'package:ghb_banefits_admin/All_Models_Admin/house_model.dart';




class HouseAllowanceAdminProviders with ChangeNotifier {
  //final firestoreService = FirebaseServices();
  //Notes List

    // HouseAllowanceController controller =
    //   HouseAllowanceController(FirebaseServices());

   List<HouseAllowanceAdmin> _houseAllowanceAdminList  =  [];
 List<HouseAllowanceAdmin> get HouseAllowanceAdminList => this._houseAllowanceAdminList;




 set HouseAllowanceAdminList(List<HouseAllowanceAdmin> value) {

  this._houseAllowanceAdminList = value;

  notifyListeners();
  } 
 int _countAllHouseAllowanceAdmin = 0;
  get fliecountAllHouseAllowanceAdmin => this._countAllHouseAllowanceAdmin;

  set fliecountAllHouseAllowanceAdmin(value) {
    this._countAllHouseAllowanceAdmin = value;
    notifyListeners();
    
  }

    int _countRequestHouseAllowanceAdmin = 0;
  get fliecountRequestHouseAllowanceAdmin => this._countRequestHouseAllowanceAdmin;

  set fliecountRequestHouseAllowanceAdmin(value) {
    this._countRequestHouseAllowanceAdmin = value;
    notifyListeners();
    
  }
      int _countApproveHouseAllowanceAdmin = 0;
  get fliecountApproveHouseAllowanceAdmin => this._countApproveHouseAllowanceAdmin;

  set fliecountApproveHouseAllowanceAdmin(value) {
    this._countApproveHouseAllowanceAdmin = value;
    notifyListeners();
    
  }

        int _countRejectHouseAllowanceAdmin = 0;
  get fliecountRejectHouseAllowanceAdmin => this._countRejectHouseAllowanceAdmin;

  set fliecountRejectHouseAllowanceAdmin(value) {
    this._countRejectHouseAllowanceAdmin = value;
    notifyListeners();
    
  }
// function to update data to list of notes
void modify(int Indexs, String status, String flagread, String payamount, String paydate){
  _houseAllowanceAdminList[Indexs].status = status ;
  _houseAllowanceAdminList[Indexs].flagread = flagread; 
  _houseAllowanceAdminList[Indexs].payamount = payamount ;
  _houseAllowanceAdminList[Indexs].paydate = paydate; 

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
//  void addHouseAllowance( 
//   String no,
//    String empcode,
//    String name,
//    String department,
//    String divisionment,
//    String savedate,
//    String startdate,
// //
//    String position,
//    String segment,
//    String departmentwork,
//    String provincework,
//    String positiondate,
// //
//    String typehouse,
//    String moneyhouse,
//    String housenumber,
//    String alley,
//    String road,
//    String district,
//    String county,
//    String province,
//    String workstatus,
// //
//   ///
//    String payamount,
//    String paydate,
//    String status,
//    String email,
//       String fileUrl, 
//    String filename, 
//    String read, 
//    String id, )
//  {
//    HouseAllowance houseAllowance = new HouseAllowance(
//     no,
//     empcode,
//     name,
//     department,
//     divisionment,
//     savedate,
//     startdate,
//     position,
//     segment,
//     departmentwork,
//     provincework,
//     positiondate,
//     typehouse,
//     moneyhouse,
//     housenumber,
//     alley,
//     road,
//     district,
//     county,
//     province,
//     workstatus,
//     payamount,
//     paydate,
//     status,
//     email,
//     fileUrl,
//     filename,
//     read,
//     id,);

//    _houseAllowanceList.add(houseAllowance);

//     notifyListeners();
//  }


}