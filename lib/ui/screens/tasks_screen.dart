import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:qualita/data/models/task_status.dart';
import 'package:qualita/ui/components/task_list.dart';
import 'package:qualita/ui/screen_layout.dart';
import 'package:qualita/data/models/task.dart';
import 'package:qualita/data/repositories/task_repository.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<StatefulWidget> createState() => _TaskScreentate();
}

class _TaskScreentate extends State<TasksScreen> {
  TaskStatus? _filter;
  DateTime _date = DateTime.now();
  final _tasks = ValueNotifier<List<Task>>([]);

  @override
  initState() {
    _tasks.value = TaskRepository.getAllTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final firstDate = _date.subtract(Duration(days: 365));
    final lastDate = _date.add(Duration(days: 365));

    return ScreenLayout(
      screen: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => setState(() {
                      _date = _date.subtract(Duration(days: 1));
                    }),
                    icon: Icon(Icons.arrow_back),
                  ),
                  Spacer(),
                  Text(
                    '${_date.day}/${_date.month}/${_date.year}',
                    style: TextStyle(fontSize: 20),
                  ),
                  IconButton(
                    onPressed: () {
                      final pickedDate = showDatePicker(
                        context: context,
                        firstDate: firstDate,
                        lastDate: lastDate,
                      );
                      pickedDate.then((value) {
                        if (value != null) {
                          setState(() => _date = value);
                        }
                      });
                    },
                    icon: Icon(Icons.calendar_month),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () => setState(() {
                      _date = _date.add(Duration(days: 1));
                    }),
                    icon: Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 5,
              children: [
                SegmentedButton<TaskStatus?>(
                  segments: [
                    ButtonSegment(value: null, label: Text('All')),
                    ...TaskStatus.values.map(
                      (status) => ButtonSegment(
                        value: status,
                        label: Text(
                          TaskStatus.getLabel(status),
                          style: TextStyle(
                            color: _filter == status
                                ? Colors.white
                                : TaskStatus.getTextColor(status),
                          ),
                        ),
                      ),
                    ),
                  ],
                  selected: <TaskStatus?>{_filter},
                  onSelectionChanged: (newSet) =>
                      setState(() => _filter = newSet.first),
                ),
              ],
            ),

            ValueListenableBuilder(
              valueListenable: TaskRepository.box.listenable(),
              builder: (context, box, child) {
                List<Task> tasks = box.values.toList();
                tasks = tasks.where((task) {
                  final startDate = task.startDate;
                  final endDate = task.endDate;
                  var condition =
                      startDate.isBefore(_date.toLocal()) ||
                      startDate.isAtSameMomentAs(_date.toLocal());
                  if (endDate != null) {
                    condition =
                        condition &&
                        (endDate.isAfter(_date.toLocal()) ||
                            endDate.isAtSameMomentAs(_date.toLocal()));
                  }
                  return condition;
                }).toList();

                if (_filter != null) {
                  tasks = tasks
                      .where((task) => task.status == _filter)
                      .toList();
                }
                return Expanded(child: TaskList(tasks: tasks));
              },
            ),
          ],
        ),
      ),
    );
  }
}
