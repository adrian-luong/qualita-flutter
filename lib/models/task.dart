import 'package:hive_flutter/hive_flutter.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  String title;
  @HiveField(1)
  List<String> tags;
  @HiveField(2)
  DateTime startDate;
  @HiveField(3)
  DateTime? endDate;

  Task({
    required this.title,
    this.tags = const [],
    required this.startDate,
    this.endDate,
  });

  static Task empty() => Task(title: '', startDate: DateTime.now());
}
