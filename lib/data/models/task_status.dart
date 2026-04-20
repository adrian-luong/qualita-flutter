import 'package:flutter/material.dart';
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

  static Color getColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.completed:
        return Colors.green;
      case TaskStatus.onHold:
        return Colors.amber;
      case TaskStatus.inProgress:
        return Colors.blue;
    }
  }

  static Color getTextColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.completed:
        return Colors.green.shade700;
      case TaskStatus.onHold:
        return Colors.amber.shade700;
      case TaskStatus.inProgress:
        return Colors.blue.shade700;
    }
  }

  static String getName(TaskStatus status) {
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
