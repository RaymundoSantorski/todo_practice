import 'package:flutter/material.dart';
import 'package:to_do_practice/interfaces/todo_interface.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'To-Do Practice'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController(text: '');
  bool _checked = false;
  List<Todo> _todos = [];

  void _addTodo() {
    Todo todo = Todo(_controller.text, false, DateTime.now(), UniqueKey());
    setState(() {
      _todos.add(todo);
    });
    _controller.clear();
  }

  void _toggleTodo(Todo todo) {
    Todo item = _todos.where((item) => todo.key == item.key).first;
    setState(() {
      item.completed = !item.completed;
    });
  }

  void _deleteTodo(Todo todo) {
    setState(() {
      _todos.removeWhere((item) => item.key == todo.key);
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            color: scheme.onSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: scheme.secondary,
      ),
      backgroundColor: scheme.inverseSurface,
      body: Column(
        children: [
          Card(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(border: InputBorder.none),
                    style: TextStyle(color: scheme.inverseSurface),
                    onSubmitted: (value) => _addTodo(),
                  ),
                ),
                IconButton(onPressed: _addTodo, icon: Icon(Icons.add)),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                for (Todo todo in _todos)
                  Dismissible(
                    key: todo.key,
                    onDismissed: (DismissDirection dir) => _deleteTodo(todo),
                    child: Card(
                      color: !todo.completed
                          ? scheme.tertiaryFixedDim
                          : scheme.secondaryContainer,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              todo.title,
                              style: TextStyle(
                                decoration: todo.completed
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                          ),
                          Checkbox(
                            value: todo.completed,
                            onChanged: (value) => _toggleTodo(todo),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
