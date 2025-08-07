import 'package:flutter/material.dart';
import 'package:to_do_practice/interfaces/todo_interface.dart';

class TodosLogic extends StatefulWidget {
  const TodosLogic({super.key});

  @override
  State<TodosLogic> createState() => TodosLogicState();
}

class TodosLogicState<T extends TodosLogic> extends State<T> {
  final TextEditingController controller = TextEditingController(text: '');
  bool asc = false;
  final List<Todo> todos = [];
  double progress = 0;

  void setProgress() {
    if (todos.isEmpty) {
      setState(() {
        progress = 0;
      });
      return;
    }
    int itemsCompleted = todos.where((item) => item.completed).length;
    setState(() {
      progress = itemsCompleted / todos.length;
    });
  }

  void addTodo() {
    if (controller.text.isEmpty) return;
    Todo todo = Todo(controller.text, false, DateTime.now(), UniqueKey());
    setState(() {
      todos.add(todo);
    });
    controller.clear();
    setProgress();
  }

  void toggleTodo(Todo todo) {
    Todo item = todos.where((item) => todo.key == item.key).first;
    setState(() {
      item.completed = !item.completed;
    });
    setProgress();
  }

  void deleteTodo(Todo todo) {
    setState(() {
      todos.removeWhere((item) => item.key == todo.key);
    });
    setProgress();
  }

  void _orderByDateAsc() {
    setState(() {
      todos.sort(
        (Todo prev, Todo curr) =>
            prev.createdAt.isAfter(curr.createdAt) ? -1 : 1,
      );
    });
  }

  void _orderByDateDes() {
    setState(() {
      todos.sort(
        (Todo prev, Todo curr) =>
            prev.createdAt.isAfter(curr.createdAt) ? 1 : -1,
      );
    });
  }

  void toggleOrder() {
    if (asc) {
      _orderByDateDes();
      asc = false;
    } else {
      _orderByDateAsc();
      asc = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}
