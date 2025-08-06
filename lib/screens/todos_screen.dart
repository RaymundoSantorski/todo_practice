import 'package:flutter/material.dart';
import 'package:to_do_practice/interfaces/todo_interface.dart';

class TodosScreen extends StatefulWidget {
  TodosScreen({super.key});

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  final TextEditingController _controller = TextEditingController(text: '');
  bool _asc = false;
  final List<Todo> _todos = [];
  double _progress = 0;

  void setProgress() {
    if (_todos.length <= 0) {
      setState(() {
        _progress = 0;
      });
      return;
    }
    int itemsCompleted = _todos.where((item) => item.completed).length;
    setState(() {
      _progress = itemsCompleted / _todos.length;
    });
  }

  void _addTodo() {
    Todo todo = Todo(_controller.text, false, DateTime.now(), UniqueKey());
    setState(() {
      _todos.add(todo);
    });
    _controller.clear();
    setProgress();
  }

  void _toggleTodo(Todo todo) {
    Todo item = _todos.where((item) => todo.key == item.key).first;
    setState(() {
      item.completed = !item.completed;
    });
    setProgress();
  }

  void _deleteTodo(Todo todo) {
    setState(() {
      _todos.removeWhere((item) => item.key == todo.key);
    });
    setProgress();
  }

  void _orderByDateAsc() {
    setState(() {
      _todos.sort(
        (Todo prev, Todo curr) =>
            prev.createdAt.isAfter(curr.createdAt) ? -1 : 1,
      );
    });
  }

  void _orderByDateDes() {
    setState(() {
      _todos.sort(
        (Todo prev, Todo curr) =>
            prev.createdAt.isAfter(curr.createdAt) ? 1 : -1,
      );
    });
  }

  void _toggleOrder() {
    if (_asc) {
      _orderByDateDes();
      _asc = false;
    } else {
      _orderByDateAsc();
      _asc = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        FilterChip(
          label: Text('Ordernar por fecha ${_asc ? 'ASC' : 'DES'}'),
          onSelected: (bool sel) => _toggleOrder(),
        ),
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
        LinearProgressIndicator(minHeight: 10, value: _progress),
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
    );
  }
}
