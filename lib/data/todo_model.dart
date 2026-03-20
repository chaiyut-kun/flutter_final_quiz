import 'package:flutter_final_quiz/core/todo_status.dart';

class Todo {
  final int? id;
  final String title;
  final String description;
  final TodoStatus status;
  final DateTime createdAt;

  Todo({
    this.id,
    required this.title,
    this.description = '',
    this.status = TodoStatus.todo,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  /// Converts a Todo to a Map for database storage.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status.toJson(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  /// Converts a Map from the database to a Todo.
  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as int?,
      title: map['title'] as String,
      description: map['description'] as String,
      status: TodoStatus.fromJson(map['status'] as String),
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  /// Creates a copy of Todo with optional field updates.
  Todo copyWith({
    int? id,
    String? title,
    String? description,
    TodoStatus? status,
    DateTime? createdAt,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
