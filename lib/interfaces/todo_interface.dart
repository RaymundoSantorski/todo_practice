class Todo {
  String title = '';
  bool completed = false;
  DateTime createdAt = DateTime.now();

  Todo(this.title, this.completed, this.createdAt);

  factory Todo.fromJson(Map<dynamic, dynamic> json) {
    return Todo(
      json['title'] as String,
      json['completed'] as bool,
      json['createdAt'] as DateTime,
    );
  }
}
