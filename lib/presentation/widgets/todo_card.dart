import 'package:flutter/material.dart';
import 'package:flutter_final_quiz/core/todo_status.dart';
import 'package:flutter_final_quiz/data/todo_model.dart';
import 'package:intl/intl.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final Function(TodoStatus) onStatusChange;

  const TodoCard({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
    required this.onStatusChange,
  });

  @override
  Widget build(BuildContext context) {
    final isDone = todo.status == TodoStatus.done;
    final dateStr = DateFormat('MMM d, yyyy').format(todo.createdAt);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: Checkbox(
          value: isDone,
          onChanged: (_) => onToggle(),
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: isDone ? TextDecoration.lineThrough : null,
            color: isDone ? Colors.grey : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (todo.description.isNotEmpty)
              Text(
                todo.description,
                style: TextStyle(
                  decoration: isDone ? TextDecoration.lineThrough : null,
                ),
              ),
            const SizedBox(height: 4),
            Text(
              'Created: $dateStr',
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PopupMenuButton<TodoStatus>(
              icon: const Icon(Icons.swap_horiz, size: 20),
              onSelected: onStatusChange,
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: TodoStatus.todo,
                  child: Text('Move to To-Do'),
                ),
                const PopupMenuItem(
                  value: TodoStatus.inProgress,
                  child: Text('Move to In-Progress'),
                ),
                const PopupMenuItem(
                  value: TodoStatus.done,
                  child: Text('Move to Done'),
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.edit, size: 20),
              onPressed: onEdit,
              tooltip: 'Edit',
            ),
            IconButton(
              icon: const Icon(Icons.delete, size: 20, color: Colors.redAccent),
              onPressed: onDelete,
              tooltip: 'Delete',
            ),
          ],
        ),
      ),
    );
  }
}
