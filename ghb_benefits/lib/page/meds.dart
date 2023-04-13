// import 'package:flutter/material.dart';
// import '../controller/meds_controller.dart';
// import '../models/meds_model.dart';
// import '../services/meds_services.dart';


// class SeventhPage extends StatefulWidget {
//   const SeventhPage({Key? key}) : super(key: key);

//   @override
//   State<SeventhPage> createState() => _SeventhPageState();
// }

// class _SeventhPageState extends State<SeventhPage> {
//   List<Todo> todos = List.empty();
//   bool isloading = false;

//   TodoController controller = TodoController(FirebaseServices());

//   void initState() {
//     super.initState();
//     controller.onSync.listen((bool synState) => setState(() {
//           isloading = synState;
//         }));
//   }

//   void _getTodos() async {
//     var newTodos = await controller.fetchTodos();
//     setState(() => todos = newTodos);
//   }

//   void _updateTodo(Todo todo) async{
//     controller.updateTodo(todo);
//   }
// Widget get body => isloading 
// ? CircularProgressIndicator()
//   : ListView.builder(
//     itemCount: !todos.isEmpty ? todos.length : 1,
//     itemBuilder: (context, index) {
//       if(!todos.isEmpty){
//         return CheckboxListTile(
//           onChanged: (value) {
//             setState(() => todos[index].completed = value!);
//             _updateTodo(todos[index]);

//             },
//             value: todos[index].completed,
//             title: Text(todos[index].title),
//           );

//           } else {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('Tab button to fetch todos'),
//               ],
//             );

//           }
//     });



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("HTTP Todos"),
//       ),
//       body: Center(
//         child: body,
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _getTodos(),
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }



