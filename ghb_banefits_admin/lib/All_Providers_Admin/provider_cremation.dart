

import 'package:flutter/widgets.dart';
import 'package:ghb_banefits_admin/All_Models_Admin/cremation_service_model.dart';




class CremationServiceAdminProviders with ChangeNotifier {

  //Notes List
 List<CremationServiceAdmin> _cremationserviceAdminList  =  [];
 // List<ChildAllowaneModel> _childAllowaneList  =  List.empty();
    //late CremationService cremationServiceModels;
    
 List<CremationServiceAdmin> get CremationServiceAdminList => this._cremationserviceAdminList;

 set CremationServiceAdminList(List<CremationServiceAdmin> value) {

  this._cremationserviceAdminList = value;

  notifyListeners();
  } 

   List<CremationServiceAdmin> _cremationserviceAdminListwhere  =  [];
 // List<ChildAllowaneModel> _childAllowaneList  =  List.empty();
    //late CremationService cremationServiceModels;
    
 List<CremationServiceAdmin> get CremationServiceAdminListwhere => this._cremationserviceAdminListwhere;

 set CremationServiceAdminListwhere(List<CremationServiceAdmin> value) {

  this._cremationserviceAdminListwhere = value;

  notifyListeners();
  } 

  

  int _countAllCremationServiceAdmin = 0;
  get fliecountAllCremationServiceAdmin => this._countAllCremationServiceAdmin;

  set fliecountAllCremationServiceAdmin(value) {
    this._countAllCremationServiceAdmin = value;
    notifyListeners();
    
  }

    int _countRequestCremationServiceAdmin = 0;
  get fliecountRequestCremationServiceAdmin => this._countRequestCremationServiceAdmin;

  set fliecountRequestCremationServiceAdmin(value) {
    this._countRequestCremationServiceAdmin = value;
    notifyListeners();
    
  }
      int _countApproveCremationServiceAdmin = 0;
  get fliecountApproveCremationServiceAdmin => this._countApproveCremationServiceAdmin;

  set fliecountApproveCremationServiceAdmin(value) {
    this._countApproveCremationServiceAdmin = value;
    notifyListeners();
    
  }

        int _countRejectCremationServiceAdmin = 0;
  get fliecountRejectCremationServiceAdmin => this._countRejectCremationServiceAdmin;

  set fliecountRejectCremationServiceAdmin(value) {
    this._countRejectCremationServiceAdmin = value;
    notifyListeners();
    
  }
// function to update data to list of notes
void modify(int Indexs, String status, String flagread ,String payamount, String paydate , String remarks ){
  _cremationserviceAdminList[Indexs].status = status ;
  _cremationserviceAdminList[Indexs].flagread = flagread; 
  _cremationserviceAdminList[Indexs].payamount = payamount; 
  _cremationserviceAdminList[Indexs].paydate = paydate; 
  _cremationserviceAdminList[Indexs].remarks = remarks; 
  

  notifyListeners();

}
// function to add data to list of notes 
//  void addCremationService( 
//    String         no,
//    String        empcode,
//    String        name,
//    String        department,
//    String        divisionment,
//    String        idcard,
//    String        savedate,
//    String        housenumber,
//    String        alley,
//    String       road,
//    String        district,
//    String        county,
//    String        province,
//    String        tel,
//    bool        readrules,
//    String        age,
//    String        datebirth,
//    String        namepartner,
//    bool        pay1,
//    bool        pay2,
//    bool        pay3,
//    String        managername,
//    String        cardnumber,
//    String       relationship,
//    String        percentage,
//    String        conditions,
//    String        payamount,
//    String        paydate,
//    String        status,
//    String        email,
//       String fileUrl, 
//    String filename, 
//    String read, 
//    String id, 
// )
//  {
//     CremationService cremationService = new CremationService(
//       no,
//       empcode,
//       name,
//       department,
//       divisionment,
//       idcard,
//       savedate,
//       housenumber,
//       alley,
//       road,
//       district,
//       county,
//       province,
//       tel,
//       readrules,
//       age,
//       datebirth,
//       namepartner,
//       pay1,
//       pay2,
//       pay3,
//       managername,
//       cardnumber,
//       relationship,
//       percentage,
//       conditions,
//       payamount,
//       paydate,
//       status,
//       email,
//       fileUrl,
//     filename,
//     read,
//     id,);

//    _cremationserviceList.add(cremationService);

//     notifyListeners();
//  }


}
