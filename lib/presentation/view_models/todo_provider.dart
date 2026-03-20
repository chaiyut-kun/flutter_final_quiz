import 'package:flutter/material.dart';
import 'package:flutter_final_quiz/core/todo_status.dart';
import 'package:flutter_final_quiz/data/database_helper.dart';
import 'package:flutter_final_quiz/data/todo_model.dart';

class TodoProvider with ChangeNotifier {
  final DatabaseHelper _db;
  List<Todo> _todos = [];
  bool _isLoading = false;

  TodoProvider({DatabaseHelper? db}) : _db = db ?? DatabaseHelper.instance;

  List<Todo> get todos => _todos;
  bool get isLoading => _isLoading;

  /// Returns todos filtered by their status.
  List<Todo> getTodosByStatus(TodoStatus status) {
    return _todos.where((todo) => todo.status == status).toList();
  }

  /// Loads all todos from the database.
  Future<void> fetchTodos() async {
    _isLoading = true;
    notifyListeners();

    _todos = await _db.readAllTodos();
    
    _isLoading = false;
    notifyListeners();
  }

  /// Adds a new todo to the database and updates the state.
  Future<void> addTodo(String title, String description) async {
    final todo = Todo(
      title: title,
      description: description,
    );
    await _db.create(todo);
    await fetchTodos();
  }

  /// Updates an existing todo's status.
  Future<void> updateTodoStatus(Todo todo, TodoStatus newStatus) async {
    final updatedTodo = todo.copyWith(status: newStatus);
    await _db.update(updatedTodo);
    await fetchTodos();
  }

  /// Updates an existing todo's title and description.
  Future<void> updateTodoContent(Todo todo, String title, String description) async {
    final updatedTodo = todo.copyWith(title: title, description: description);
    await _db.update(updatedTodo);
    await fetchTodos();
  }

  /// Deletes a todo from the database.
  Future<void> deleteTodo(int id) async {
    await _db.delete(id);
    await fetchTodos();
  }

  /// Toggles between 'done' and 'todo' status.
  Future<void> toggleDone(Todo todo) async {
    final newStatus = todo.status == TodoStatus.done 
        ? TodoStatus.todo 
        : TodoStatus.done;
    await updateTodoStatus(todo, newStatus);
  }
}
