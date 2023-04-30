
import 'package:flutter/widgets.dart';




class MyDashboardProviders with ChangeNotifier {


    double _SumMedical = 0;
  get SumMedicalModalChoice => this._SumMedical;

  set SumMedicalModalChoice(value) {
    this._SumMedical = value;
    notifyListeners();
    
  }
  
      double _RemainMedical = 0;
  get RemainMedicalModalChoice => this._RemainMedical;

  set RemainMedicalModalChoice(value) {
    this._RemainMedical = value;
    notifyListeners();
    
  }


   double _SumEducation = 0;
  get SumEducationModalChoice => this._SumEducation;

  set SumEducationModalChoice(value) {
    this._SumEducation = value;
    notifyListeners();
    
  }
  
      double _RemainEducation = 0;
  get RemainEducationModalChoice => this._RemainEducation;

  set RemainEducationModalChoice(value) {
    this._RemainEducation = value;
    notifyListeners();
    
  }

     double _Sumchild = 0;
  get SumchildnModalChoice => this._Sumchild;

  set SumchildModalChoice(value) {
    this._Sumchild = value;
    notifyListeners();
    
  }
  
      double _Remainchild = 0;
  get RemainchildModalChoice => this._Remainchild;

  set RemainchildModalChoice(value) {
    this._Remainchild = value;
    notifyListeners();
    
  }


      int _Childage = 0;
  get Childage => this._Childage;

  set Childage(value) {
    this._Childage = value;
    notifyListeners();
    
  }
}


