import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SeventhPage extends StatefulWidget {
  const SeventhPage({Key? key}) : super(key: key);

  @override
  State<SeventhPage> createState() => _SeventhPageState();
}

class _SeventhPageState extends State<SeventhPage> {
  List<Todo> todos = List.empty();
  bool isloading = false;

  TodoController controller = TodoController(HttpServies());

  void initState() {
    super.initState();
    controller.onSync.listen((bool synState) => setState(() {
          isloading = synState;
        }));
  }

  void _getTodos() async {
    var newTodos = await controller.fetchTodos();
    setState(() => todos = newTodos);
  }

  void _updateTodo(Todo todo) async{
    controller.updateTodo(todo);
  }
Widget get body => isloading 
? CircularProgressIndicator()
  : ListView.builder(
    itemCount: !todos.isEmpty ? todos.length : 1,
    itemBuilder: (context, index) {
      if(!todos.isEmpty){
        return CheckboxListTile(
          onChanged: (value) {
            setState(() => todos[index].completed = value!);
            _updateTodo(todos[index]);

            },
            value: todos[index].completed,
            title: Text(todos[index].title),
          );

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

class Todo {
  final int userid;
  final int id;
  final String title;
  bool completed;

  Todo(this.userid, this.id, this.title, this.completed);

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      json['userId'] as int,
      json['id'] as int,
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
}

class HttpServies {
  Client client = Client();
  Future<List<Todo>> getTodos() async {
    final response = await client.get(Uri.parse(
      'https://jsonplaceholder.typicode.com/todos',
    ));
    if (response.statusCode == 200) {
      var all = AllTodos.fromJson(json.decode(response.body));
      return all.todos;
    } else {
      throw Exception('Fail to load todos');
    }
  }
  void update(Todo todo) async {
    final response = await client.
    put(Uri.parse('https://jsonplaceholder.typicode.com/todos/${todo.id}'),
    headers: <String, String>{
      "Content-Type": "application/json",
    },
    body: jsonEncode(<String, dynamic>{
      "userId" : todo.userid,
      "id" : todo.id,
      "title" : todo.title,
      "completed" : todo.completed,

    }),
    );
    if(response.statusCode !=200){
      throw Exception("Cannot updete todo");
    }
    print(response.body);

  }
}

class TodoController {
  final HttpServies servies;
  List<Todo> todos = List.empty();

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  TodoController(this.servies);

  Future<List<Todo>> fetchTodos() async {
    onSyncController.add(true);
    todos = await servies.getTodos();
    onSyncController.add(false);
    return todos;
  }

  void updateTodo(Todo todo) async{
    servies.update(todo);
  }
}
