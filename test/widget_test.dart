import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_final_quiz/main.dart';
import 'package:flutter_final_quiz/data/database_helper.dart';
import 'package:flutter_final_quiz/presentation/view_models/todo_provider.dart';

class MockDatabaseHelper extends Mock implements DatabaseHelper {}

void main() {
  late MockDatabaseHelper mockDb;

  setUp(() {
    mockDb = MockDatabaseHelper();
    // Return empty list by default
    when(() => mockDb.readAllTodos()).thenAnswer((_) async => []);
  });

  testWidgets('App should load with initial state', (WidgetTester tester) async {
    final todoProvider = TodoProvider(db: mockDb);
    
    await tester.pumpWidget(MyApp(todoProvider: todoProvider));

    // Verify that the title is present.
    expect(find.text('To-Do List'), findsOneWidget);
    // Verify that the tabs are present
    expect(find.text('To-Do'), findsOneWidget);
    expect(find.text('In-Progress'), findsOneWidget);
    expect(find.text('Done'), findsOneWidget);
  });
}
