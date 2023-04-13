

import 'package:flutter/material.dart';
import 'package:ghb_benefits/All_Controllers/child_allowance_controllers.dart';
import 'package:ghb_benefits/All_Models/child_allowane_model.dart';
import 'package:ghb_benefits/All_Services/servics.dart';


class VPage extends StatefulWidget {
  const VPage({Key? key}) : super(key: key);

  @override
  State<VPage> createState() => _VPageState();
}

class _VPageState extends State<VPage> {
  List<ChildAllowance> todos = List.empty();
  bool isloading = false;

  ChildAllowanceController controller = ChildAllowanceController(FirebaseServices());

  void initState() {
    super.initState();
    controller.onSync.listen((bool synState) => setState(() {
          isloading = synState;
        }));
  }

  void _getTodos() async {
    var newTodos = await controller.fetchChildAllowance();
    setState(() => todos = newTodos);
  }
/*
  void _updateTodo(Todo todo) async{
    controller.updateTodo(todo);
  }
  */
Widget get body => isloading 
? CircularProgressIndicator()
  : ListView.builder(
    itemCount: !todos.isEmpty ? todos.length : 1,
    itemBuilder: (context, index) {
      if(!todos.isEmpty){
        

       return Padding(
      padding: const EdgeInsets.all(2.0),

        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topLeft: Radius.circular(10),
            )
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
             leading: Icon(Icons.note),
              title: Text(todos[index].no),
              subtitle: Text(todos[index].nameemp),
              trailing: Icon(Icons.arrow_forward_ios,color: Colors.black26,),
               onTap: () {
                    //Navigator.push( context,MaterialPageRoute(builder: (context) =>DetailChildAllowancePage(Notes : todos)));
                    },
            ),
          ),
        ),
    );
       /* return CheckboxListTile(
        /*  onChanged: (value) {
            setState(() => todos[index].completed = value!);
            _updateTodo(todos[index]);

            },
            */
            value: todos[index].no,
            title: Text(todos[index].nameemp),
          );*/

          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Tab button to fetch todos'),
              ],
            );

          }
    });



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HTTP Todos"),
      ),
      body: Center(
        child: body,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _getTodos(),
        child: Icon(Icons.add),
      ),
    );
  }
}



