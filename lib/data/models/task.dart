import 'package:hive_flutter/hive_flutter.dart';
import 'package:qualita/data/models/task_status.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  List<int> tags;
  @HiveField(2)
  DateTime startDate;
  @HiveField(3)
  DateTime? endDate;
  @HiveField(4)
  TaskStatus status;

  Task({
    required this.title,
    this.tags = const [],
    required this.startDate,
    this.endDate,
    this.status = TaskStatus.inProgress,
  });

  static Task empty() => Task(title: '', startDate: DateTime.now());
}
