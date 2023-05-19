
import 'package:flutter/widgets.dart';
import 'package:ghb_benefits/All_Controllers/master_controllers.dart';
import 'package:ghb_benefits/All_Models/child_model.dart';
import 'package:ghb_benefits/All_Models/employee_model.dart';
import 'package:ghb_benefits/All_Services/servics.dart';

class EmployeeProviders with ChangeNotifier {
  MasterController controller = MasterController(FirebaseServices());

  List<Employee> _EmployeeList = [];
  List<Employee> get EmployeeList => this._EmployeeList;

  set EmployeeList(List<Employee> value) {
    this._EmployeeList = value;

    notifyListeners();
  }
}


class filedEmployeeProviders with ChangeNotifier {

    String _Empno = "";
  get Empno => this._Empno;

  set Empno(value) {
    this._Empno = value;
    notifyListeners();
    
  }

    String _Empempcode = "";
  get Empempcode => this._Empempcode;

  set Empempcode(value) {
    this._Empempcode = value;
    notifyListeners();
    
  }

      String _Empnameemp = "";
  get Empnameemp => this._Empnameemp;

  set Empnameemp(value) {
    this._Empnameemp = value;
    notifyListeners();
    
  }

      String _Empdepartment = "";
  get Empdepartment => this._Empdepartment;

  set Empdepartment(value) {
    this._Empdepartment = value;
    notifyListeners();
    
  }
  
      String _Empdivisionment = "";
  get Empdivisionment => this._Empdivisionment;

  set Empdivisionment(value) {
    this._Empdivisionment = value;
    notifyListeners();
    
  }
  
        String _Empdate = "";
  get Empdate => this._Empdate;

  set Empdate(value) {
    this._Empdate = value;
    notifyListeners();
    
  }
          String _Empuid = "";
  get Empuid => this._Empuid;

  set Empuid(value) {
    this._Empuid = value;
    notifyListeners();
    
  }
          String _Empidcard = "";
  get Empidcard => this._Empidcard;

  set Empidcard(value) {
    this._Empidcard = value;
    notifyListeners();
    
  }

}
class ChilderProviders with ChangeNotifier {
  MasterController controller = MasterController(FirebaseServices());

  List<Child> _ChilderList = [];
  List<Child> get ChilderList => this._ChilderList;

  set ChilderList(List<Child> value) {
    this._ChilderList = value;

    notifyListeners();
  }

    List<String> _childname = [];
  List<String> get childnamerList => this._childname;

  set childnamerList(List<String> value) {
    this._childname = value;

    notifyListeners();
  }
}
