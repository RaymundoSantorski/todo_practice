import 'package:flutter/material.dart';

class Todo {
  String title = '';
  bool completed = false;
  DateTime createdAt = DateTime.now();
  UniqueKey key = UniqueKey();

  Todo(this.title, this.completed, this.createdAt, this.key);

  factory Todo.fromJson(Map<dynamic, dynamic> json) {
    return Todo(
      json['title'] as String,
      json['completed'] as bool,
      json['createdAt'] as DateTime,
      json['key'] as UniqueKey,
    );
  }
}
