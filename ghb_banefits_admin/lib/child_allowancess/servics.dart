
/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ghb_banefits_admin/child_allowancess/child_allowane_model_admid.dart';



class FirebaseServices{
  Future<List<ChildAllowance>> getChildAllowance() async {
   QuerySnapshot snapshot = 
   await FirebaseFirestore.instance.collection('ChildAllowance').get();

   AllChildAllowance allowance = AllChildAllowance.fromSnapshot(snapshot);
   return allowance.allowances;
  }
/*
  void update(Todo todos) async {
    final todoRef = 
    await FirebaseFirestore.instance.
    collection('todos').
    where('id',isEqualTo: todos.id);
    //todoRef.count();
   print('update ${todos.id}');
    await FirebaseFirestore.instance.collection('todos').doc(todos.id).update({
      'completed' : todos.completed,

    });



  }
  */


}
*/