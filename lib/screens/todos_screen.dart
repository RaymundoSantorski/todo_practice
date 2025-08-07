import 'package:flutter/material.dart';
import 'package:to_do_practice/logic/todos_logic.dart';
import 'package:to_do_practice/widgets/todo_input.dart';
import 'package:to_do_practice/widgets/todos_list.dart';

class TodosScreen extends TodosLogic {
  const TodosScreen({super.key});

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends TodosLogicState<TodosScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FilterChip(
          label: Text('Ordernar por fecha ${asc ? 'ASC' : 'DES'}'),
          onSelected: (bool sel) => toggleOrder(),
        ),
        TodoInput(controller: controller, addTodo: addTodo),
        LinearProgressIndicator(minHeight: 10, value: progress),
        TodosList(todos: todos, deleteTodo: deleteTodo, toggleTodo: toggleTodo),
      ],
    );
  }
}
