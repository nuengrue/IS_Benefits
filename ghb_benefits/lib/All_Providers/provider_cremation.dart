

import 'package:flutter/widgets.dart';
import 'package:ghb_benefits/All_Models/cremation_service_model.dart';
import 'package:ghb_benefits/All_Models/cremation_service_model.dart';



class CremationServiceProviders with ChangeNotifier {

  //Notes List
 List<CremationService> _cremationserviceList  =  [];
 // List<ChildAllowaneModel> _childAllowaneList  =  List.empty();
    //late CremationService cremationServiceModels;
    
 List<CremationService> get CremationServiceList => this._cremationserviceList;

 set CremationServiceList(List<CremationService> value) {

  this._cremationserviceList = value;

  notifyListeners();
  } 
// function to add data to list of notes 
 void addCremationService( 
   int         no,
   String        empcode,
   String        name,
   String        department,
   String        divisionment,
   String        idcard,
   String        savedate,
   String        housenumber,
   String        alley,
   String       road,
   String        district,
   String        county,
   String        province,
   String        tel,
   bool        readrules,
   String        age,
   String        datebirth,
   String        namepartner,
   bool        pay1,
   bool        pay2,
   bool        pay3,
   String        managername,
   String        cardnumber,
   String       relationship,
   String        percentage,
   String        conditions,
   String        payamount,
   String        paydate,
   String        status,
   String        email,
      String fileUrl, 
   String filename, 
   String read, 
   String id,
      String remarks,  
)
 {
    CremationService cremationService = new CremationService(
      no,
      empcode,
      name,
      department,
      divisionment,
      idcard,
      savedate,
      housenumber,
      alley,
      road,
      district,
      county,
      province,
      tel,
      readrules,
      age,
      datebirth,
      namepartner,
      pay1,
      pay2,
      pay3,
      managername,
      cardnumber,
      relationship,
      percentage,
      conditions,
      payamount,
      paydate,
      status,
      email,
      fileUrl,
    filename,
    read,
    id,    
    remarks,);

   _cremationserviceList.add(cremationService);

    notifyListeners();
 }


}
