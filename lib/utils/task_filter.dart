import 'package:qualita/data/models/task_status.dart';

class TaskFilter {
  DateTime date = DateTime.now();
  TaskStatus? status;
  String search = '';

  TaskFilter({required this.date, required this.status, required this.search});
}
