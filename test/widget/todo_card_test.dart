import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_final_quiz/core/todo_status.dart';
import 'package:flutter_final_quiz/data/todo_model.dart';
import 'package:flutter_final_quiz/presentation/widgets/todo_card.dart';

void main() {
  group('TodoCard Widget Tests', () {
    testWidgets('Should display title and description', (WidgetTester tester) async {
      final todo = Todo(
        id: 1,
        title: 'Learn Flutter',
        description: 'Practice widget testing',
      );

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: TodoCard(
            todo: todo,
            onToggle: () {},
            onDelete: () {},
            onEdit: () {},
            onStatusChange: (_) {},
          ),
        ),
      ));

      expect(find.text('Learn Flutter'), findsOneWidget);
      expect(find.text('Practice widget testing'), findsOneWidget);
    });

    testWidgets('Done task should have strikethrough decoration', (WidgetTester tester) async {
      final todo = Todo(
        id: 1,
        title: 'Learn Flutter',
        status: TodoStatus.done,
      );

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: TodoCard(
            todo: todo,
            onToggle: () {},
            onDelete: () {},
            onEdit: () {},
            onStatusChange: (_) {},
          ),
        ),
      ));

      final textWidget = tester.widget<Text>(find.text('Learn Flutter'));
      expect(textWidget.style?.decoration, TextDecoration.lineThrough);
    });

    testWidgets('Toggling checkbox should call onToggle', (WidgetTester tester) async {
      bool toggleCalled = false;
      final todo = Todo(id: 1, title: 'Learn Flutter');

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: TodoCard(
            todo: todo,
            onToggle: () => toggleCalled = true,
            onDelete: () {},
            onEdit: () {},
            onStatusChange: (_) {},
          ),
        ),
      ));

      await tester.tap(find.byType(Checkbox));
      expect(toggleCalled, isTrue);
    });
  });
}
