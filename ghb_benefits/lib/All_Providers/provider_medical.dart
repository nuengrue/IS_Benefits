
import 'package:flutter/widgets.dart';
import 'package:ghb_benefits/All_Models/medical_model.dart';



class MedicalProviders with ChangeNotifier {


  List<Medical> _MedicalList  =  [];
 List<Medical> get MedicalList => this._MedicalList;




 set MedicalList(List<Medical> value) {

  this._MedicalList = value;

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
 void addMedical( 
   String no,
   String empcode,
   String name,
   String department,
   String divisionment,
   String numbercodemed,
   String savedate,
   String typemed,
   String yearmed,
   String hospitalname,
   String hospitaltype,
   String claimstartdate,
   String claimenddate,
   String idreceiptnumber,
   String receiptnumber,
   String tel,
   String namedisease,
   String diseasegroup,
   String receiptamount,
   String payamount,
   String paydate,
   String status,
   String email,
   String fileUrl,
   String filename,
   String flagread,
  String id, )
 {
   Medical medical = new Medical(   
   no,
    empcode,
    name,
    department,
    divisionment,
    numbercodemed,
    savedate,
    typemed,
    yearmed,
    hospitalname,
    hospitaltype,
    claimstartdate,
    claimenddate,
    idreceiptnumber,
    receiptnumber,
    tel,
    namedisease,
    diseasegroup,
    receiptamount,
    payamount,
    paydate,
    status,
    email,
    fileUrl,
    filename,
    flagread,
   id,);

   _MedicalList.add(medical);
   
   

    notifyListeners();
 }
}
