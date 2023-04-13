// import 'dart:async';
// import '../models/meds_model.dart';
// import '../services/meds_services.dart';


// class TodoController {
//   final FirebaseServices servies;
//   List<Todo> todos = List.empty();

//   StreamController<bool> onSyncController = StreamController();
//   Stream<bool> get onSync => onSyncController.stream;

//   TodoController(this.servies);

//   Future<List<Todo>> fetchTodos() async {
//     onSyncController.add(true);
//     todos = await servies.getTodos();
//     onSyncController.add(false);
//     return todos;
//   }


//   void updateTodo(Todo todo) async{
//     servies.update(todo);
//   }
// }

