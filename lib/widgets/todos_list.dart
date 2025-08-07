import 'package:flutter/material.dart';
import 'package:to_do_practice/interfaces/todo_interface.dart';

class TodosList extends StatelessWidget {
  const TodosList({
    super.key,
    required this.todos,
    required this.deleteTodo,
    required this.toggleTodo,
  });
  final List<Todo> todos;
  final void Function(Todo) deleteTodo;
  final void Function(Todo) toggleTodo;

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Expanded(
      child: ListView(
        children: [
          for (Todo todo in todos)
            Dismissible(
              key: todo.key,
              onDismissed: (DismissDirection dir) => deleteTodo(todo),
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
                      onChanged: (value) => toggleTodo(todo),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
