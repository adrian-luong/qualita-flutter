import 'package:hive_flutter/hive_flutter.dart';
import 'package:qualita/data/models/task_status.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  List<int> tags;
  @HiveField(3)
  DateTime startDate;
  @HiveField(4)
  DateTime? endDate;
  @HiveField(5)
  TaskStatus status;

  Task({
    required this.id,
    required this.title,
    this.tags = const [],
    required this.startDate,
    this.endDate,
    this.status = TaskStatus.inProgress,
  });

  static Task empty() => Task(title: '', startDate: DateTime.now(), id: '');

  Map<String, Task> formMap() => {id: this};
}
