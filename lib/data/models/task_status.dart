import 'package:hive_flutter/hive_flutter.dart';

part 'task_status.g.dart';

@HiveType(typeId: 1)
enum TaskStatus {
  @HiveField(0)
  onHold,
  @HiveField(1)
  inProgress,
  @HiveField(2)
  completed;

  static Map<String, TaskStatus> get list => {
    'On Hold': TaskStatus.onHold,
    'In Progress': TaskStatus.inProgress,
    'Completed': TaskStatus.completed,
  };

  static String getLabel(TaskStatus status) {
    switch (status) {
      case TaskStatus.completed:
        return 'Completed';
      case TaskStatus.inProgress:
        return 'In Progress';
      case TaskStatus.onHold:
        return 'On Hold';
    }
  }
}
