
import 'package:flutter/widgets.dart';
import 'package:ghb_banefits_admin/All_Models_Admin/medical_model.dart';

import '../All_Page_Admin/Report/Report_Child_Allowance.dart';




class MedicalAdminProviders with ChangeNotifier {


  List<MedicalAdmin> _MedicalAdminList  =  [];
 List<MedicalAdmin> get MedicalAdminList => this._MedicalAdminList;




 set MedicalAdminList(List<MedicalAdmin> value) {

  this._MedicalAdminList = value;

  notifyListeners();
  }


   int _countAllMedicalAdmin = 0;
  get fliecountAllMedicalAdmin => this._countAllMedicalAdmin;

  set fliecountAllMedicalAdmin(value) {
    this._countAllMedicalAdmin = value;
    notifyListeners();
    
  }

    int _countRequestMedicalAdmin = 0;
  get fliecountRequestMedicalAdmin => this._countRequestMedicalAdmin;

  set fliecountRequestMedicalAdmin(value) {
    this._countRequestMedicalAdmin = value;
    notifyListeners();
    
  }
      int _countApproveMedicalAdmin = 0;
  get fliecountApproveMedicalAdmin => this._countApproveMedicalAdmin;

  set fliecountApproveMedicalAdmin(value) {
    this._countApproveMedicalAdmin = value;
    notifyListeners();
    
  }

        int _countRejectMedicalAdmin = 0;
  get fliecountRejectMedicalAdmin => this._countRejectMedicalAdmin;

  set fliecountRejectMedicalAdmin(value) {
    this._countRejectMedicalAdmin = value;
    notifyListeners();
    
  }

      double _RemainRequestMedical = 0;
  get RemainRequestMedical => this._RemainRequestMedical;

  set RemainRequestMedical(value) {
    this._RemainRequestMedical = value;
    notifyListeners();
    
  }
      double _RemainApproveMedical = 0;
  get RemainApproveMedical => this._RemainApproveMedical;

  set RemainApproveMedical(value) {
    this._RemainApproveMedical = value;
    notifyListeners();
    
  }  
      double _RemainRejectMedical = 0;
  get RemainRejectMedical => this._RemainRejectMedical;

  set RemainRejectMedical(value) {
    this._RemainRejectMedical = value;
    notifyListeners();
    
  } 

// function to update data to list of notes
void modify(int Indexs, String status, String flagread, String payamount, String paydate, String remarks){
  _MedicalAdminList[Indexs].status = status ;
  _MedicalAdminList[Indexs].flagread = flagread; 
  _MedicalAdminList[Indexs].payamount = payamount;
  _MedicalAdminList[Indexs].paydate = paydate;  
  _MedicalAdminList[Indexs].remarks = remarks;
  notifyListeners();

}

}
