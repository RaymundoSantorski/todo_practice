import 'package:flutter/material.dart';

class TodoInput extends StatelessWidget {
  const TodoInput({super.key, required this.controller, required this.addTodo});
  final VoidCallback addTodo;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Card(
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(border: InputBorder.none),
              style: TextStyle(color: scheme.inverseSurface),
              onSubmitted: (value) => addTodo(),
            ),
          ),
          IconButton(onPressed: addTodo, icon: Icon(Icons.add)),
        ],
      ),
    );
  }
}
