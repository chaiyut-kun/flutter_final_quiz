enum TodoStatus {
  todo,
  inProgress,
  done;

  /// Converts the status to a string for database storage.
  String toJson() => name;

  /// Converts a string from the database to a status.
  static TodoStatus fromJson(String name) {
    return TodoStatus.values.firstWhere(
      (e) => e.name == name,
      orElse: () => TodoStatus.todo,
    );
  }
}
