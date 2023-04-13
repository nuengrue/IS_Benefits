
import 'package:flutter/widgets.dart';
import 'package:ghb_banefits_admin/All_Models_Admin/medical_model.dart';




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
// function to update data to list of notes
void modify(int Indexs, String status, String flagread, String payamount, String paydate){
  _MedicalAdminList[Indexs].status = status ;
  _MedicalAdminList[Indexs].flagread = flagread; 
  _MedicalAdminList[Indexs].payamount = payamount;
  _MedicalAdminList[Indexs].paydate = paydate;  

  notifyListeners();

}
  //Notes List
//  List<Medical> _medicalModel  =  [];
//  // List<ChildAllowaneModel> _childAllowaneList  =  List.empty();
//     late MedicalModel medicalModel;
//      // List<ChildAllowaneModel> get data => List<ChildAllowaneModel>;
//  //Stream<List<Childall>> get getentries => firestoreService.getdata();
//  List<MedicalModel> get getmedicalModel{ return _medicalModel;}


// function to add data to list of notes 
//  void addMedical( 
//    String no,
//    String empcode,
//    String name,
//    String department,
//    String divisionment,
//    String numbercodemed,
//    String savedate,
//    String typemed,
//    String yearmed,
//    String hospitalname,
//    String hospitaltype,
//    String claimstartdate,
//    String claimenddate,
//    String idreceiptnumber,
//    String receiptnumber,
//    String tel,
//    String namedisease,
//    String diseasegroup,
//    String receiptamount,
//    String payamount,
//    String paydate,
//    String status,
//    String email,
//    String fileUrl,
//    String filename,
//    String flagread,
//   String id, )
//  {
//    Medical medical = new Medical(   
//    no,
//     empcode,
//     name,
//     department,
//     divisionment,
//     numbercodemed,
//     savedate,
//     typemed,
//     yearmed,
//     hospitalname,
//     hospitaltype,
//     claimstartdate,
//     claimenddate,
//     idreceiptnumber,
//     receiptnumber,
//     tel,
//     namedisease,
//     diseasegroup,
//     receiptamount,
//     payamount,
//     paydate,
//     status,
//     email,
//     fileUrl,
//     filename,
//     flagread,
//    id,);

//    _MedicalList.add(medical);
   
   

//     notifyListeners();
//  }
}
