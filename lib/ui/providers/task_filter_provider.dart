import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qualita/data/models/task_status.dart';
import 'package:qualita/utils/task_filter.dart';

final taskFilterProvider = NotifierProvider<TaskFilterNotifier, TaskFilter>(
  TaskFilterNotifier.new,
);

class TaskFilterNotifier extends Notifier<TaskFilter> {
  @override
  TaskFilter build() =>
      TaskFilter(date: DateTime.now(), status: null, search: '');

  DateTime get currentDate => state.date;
  TaskStatus? get currentStatus => state.status;
  String get currentSearch => state.search;

  void switchDate(DateTime newDate) {
    state = TaskFilter(
      date: newDate,
      status: state.status,
      search: state.search,
    );
  }

  void switchStatus(TaskStatus? newStatus) {
    state = TaskFilter(
      date: state.date,
      status: newStatus,
      search: state.search,
    );
  }

  void search(String newSearch) {
    state = TaskFilter(
      date: state.date,
      status: state.status,
      search: newSearch,
    );
  }
}
