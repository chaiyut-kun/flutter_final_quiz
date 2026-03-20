import 'package:flutter/material.dart';
import 'package:flutter_final_quiz/core/todo_status.dart';
import 'package:flutter_final_quiz/data/todo_model.dart';
import 'package:flutter_final_quiz/presentation/view_models/todo_provider.dart';
import 'package:flutter_final_quiz/presentation/widgets/add_edit_todo_sheet.dart';
import 'package:flutter_final_quiz/presentation/widgets/todo_card.dart';

class MainScreen extends StatefulWidget {
  final TodoProvider provider;

  const MainScreen({super.key, required this.provider});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    widget.provider.fetchTodos();
  }

  void _showAddEditSheet({Todo? todo}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => AddEditTodoSheet(
        todo: todo,
        onSave: (title, description) {
          if (todo == null) {
            widget.provider.addTodo(title, description);
          } else {
            widget.provider.updateTodoContent(todo, title, description);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('To-Do List'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.list), text: 'To-Do'),
              Tab(icon: Icon(Icons.check_circle_outline), text: 'Done'),
            ],
          ),
        ),
        body: ListenableBuilder(
          listenable: widget.provider,
          builder: (context, child) {
            if (widget.provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return TabBarView(
              children: [
                _buildTodoList(TodoStatus.todo),
                _buildTodoList(TodoStatus.done),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddEditSheet(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildTodoList(TodoStatus status) {
    final todos = widget.provider.getTodosByStatus(status);

    if (todos.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.assignment_turned_in_outlined, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No tasks here!',
              style: TextStyle(color: Colors.grey[600], fontSize: 18),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoCard(
          todo: todo,
          onToggle: () => widget.provider.toggleDone(todo),
          onDelete: () => widget.provider.deleteTodo(todo.id!),
          onEdit: () => _showAddEditSheet(todo: todo),
          onStatusChange: (newStatus) => widget.provider.updateTodoStatus(todo, newStatus),
        );
      },
    );
  }
}
