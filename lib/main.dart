import 'package:flutter/material.dart';
import 'package:flutter_final_quiz/presentation/screens/main_screen.dart';
import 'package:flutter_final_quiz/presentation/view_models/todo_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Use a singleton-like instance for the provider
  final todoProvider = TodoProvider();

  runApp(MyApp(todoProvider: todoProvider));
}

class MyApp extends StatelessWidget {
  final TodoProvider todoProvider;

  const MyApp({super.key, required this.todoProvider});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: MainScreen(provider: todoProvider),
    );
  }
}
