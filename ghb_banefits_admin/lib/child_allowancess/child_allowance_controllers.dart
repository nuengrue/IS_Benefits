// import 'dart:async';

// import 'package:ghb_banefits_admin/All_Services_Admin/servics.dart';
// import 'package:ghb_banefits_admin/child_allowancess/child_allowane_model_admid.dart';





// class ChildAllowanceController {
//   final FirebaseServices servies;
//   List<ChildAllowance> allowances = List.empty();

//   StreamController<bool> onSyncController = StreamController();
//   Stream<bool> get onSync => onSyncController.stream;

//   ChildAllowanceController(this.servies);

//   Future<List<ChildAllowance>> fetchChildAllowanceAdmid() async {
//     onSyncController.add(true);
//     allowances = await servies.getChildAllowance();
//     onSyncController.add(false);
//     return allowances;
//   }

// /*
//   void updateTodo(ChildAllowaneModel todo) async{
//     servies.update(todo);
//   }
//   */
// }
