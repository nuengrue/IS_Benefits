import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  final int userid;
  String id;
  final String title;
  bool completed;

  Todo(this.userid, this.id, this.title, this.completed);

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      json['userId'] as int,
      json['id'] as String,
      json['title'] as String,
      json['completed'] as bool,
    );
  }
}

class AllTodos {
  final List<Todo> todos;

  AllTodos(this.todos);
  factory AllTodos.fromJson(List<dynamic> json) {
    List<Todo> todos;
    todos = json.map((item) => Todo.fromJson(item)).toList();
    return AllTodos(todos);
  }
  factory AllTodos.fromSnapshot(QuerySnapshot s){
     List<Todo> todos = s.docs.map((DocumentSnapshot ds) {
       Todo todo  = Todo.fromJson(ds.data() as Map<String, dynamic>);
       todo.id = ds.id;
       print(ds.id);
      return todo;


    }).toList();

    return AllTodos(todos);
  }
}