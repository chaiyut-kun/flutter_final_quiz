import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_final_quiz/core/todo_status.dart';
import 'package:flutter_final_quiz/data/database_helper.dart';
import 'package:flutter_final_quiz/data/todo_model.dart';
import 'package:flutter_final_quiz/presentation/view_models/todo_provider.dart';

class MockDatabaseHelper extends Mock implements DatabaseHelper {}

void main() {
  late TodoProvider todoProvider;
  late MockDatabaseHelper mockDb;

  setUp(() {
    mockDb = MockDatabaseHelper();
    todoProvider = TodoProvider(db: mockDb);
    
    // Default fallback for any Todo object
    registerFallbackValue(Todo(title: 'stub'));
  });

  group('TodoProvider Unit Tests', () {
    test('Initial state should be empty and not loading', () {
      expect(todoProvider.todos, isEmpty);
      expect(todoProvider.isLoading, isFalse);
    });

    test('fetchTodos should update todos list and loading state', () async {
      final mockTodos = [
        Todo(id: 1, title: 'Task 1', status: TodoStatus.todo),
        Todo(id: 2, title: 'Task 2', status: TodoStatus.done),
      ];

      when(() => mockDb.readAllTodos()).thenAnswer((_) async => mockTodos);

      final fetchFuture = todoProvider.fetchTodos();
      
      // Should be loading after start
      expect(todoProvider.isLoading, isTrue);
      
      await fetchFuture;

      expect(todoProvider.todos, mockTodos);
      expect(todoProvider.isLoading, isFalse);
      verify(() => mockDb.readAllTodos()).called(1);
    });

    test('getTodosByStatus should filter todos correctly', () async {
      final mockTodos = [
        Todo(id: 1, title: 'Task 1', status: TodoStatus.todo),
        Todo(id: 2, title: 'Task 2', status: TodoStatus.done),
        Todo(id: 3, title: 'Task 3', status: TodoStatus.todo),
      ];
      
      when(() => mockDb.readAllTodos()).thenAnswer((_) async => mockTodos);
      await todoProvider.fetchTodos();

      final todoTasks = todoProvider.getTodosByStatus(TodoStatus.todo);
      final doneTasks = todoProvider.getTodosByStatus(TodoStatus.done);

      expect(todoTasks.length, 2);
      expect(doneTasks.length, 1);
      expect(todoTasks[0].title, 'Task 1');
      expect(doneTasks[0].title, 'Task 2');
    });

    test('addTodo should call database create and refresh list', () async {
      when(() => mockDb.create(any())).thenAnswer((_) async => 1);
      when(() => mockDb.readAllTodos()).thenAnswer((_) async => []);

      await todoProvider.addTodo('New Title', 'New Desc');

      verify(() => mockDb.create(any())).called(1);
      verify(() => mockDb.readAllTodos()).called(1);
    });
  });
}
