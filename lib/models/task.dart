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

  Map<String, dynamic> toMap() => {
    'title': title,
    'tags': tags,
    'startDate': startDate.toIso8601String(),
    'endDate': endDate?.toIso8601String(),
  };

  factory Task.fromMap(Map<String, dynamic> map) => Task(
    title: map['title'],
    tags: List<String>.from(map['tags']),
    startDate: DateTime.parse(map['startDate']),
    endDate: map['endDate'] != null ? DateTime.parse(map['endDate']) : null,
  );

  factory Task.empty() => Task(title: '', startDate: DateTime.now());
}
