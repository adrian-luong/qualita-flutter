import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:qualita/data/models/task_status.dart';
import 'package:qualita/ui/components/task_list.dart';
import 'package:qualita/ui/dialogs/task_upsert_dialog.dart';
import 'package:qualita/ui/screen_layout.dart';
import 'package:qualita/data/models/task.dart';
import 'package:qualita/data/repositories/task_repository.dart';
import 'package:qualita/utils/constant_enums.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreentate();
}

class _HomeScreentate extends State<HomeScreen> {
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
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => setState(() {
                      _date = _date.subtract(Duration(days: 1));
                    }),
                    icon: Icon(Icons.arrow_back),
                  ),
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
                  IconButton(
                    onPressed: () => setState(() {
                      _date = _date.add(Duration(days: 1));
                    }),
                    icon: Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
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
                      startDate.isBefore(_date) ||
                      startDate.isAtSameMomentAs(_date);
                  if (endDate != null) {
                    condition =
                        condition &&
                        (endDate.isAfter(_date) ||
                            endDate.isAtSameMomentAs(_date));
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

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Tooltip(
                message: 'Create a new task',
                child: FilledButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => TaskUpsertDialog(
                      mode: FormMode.create,
                      task: Task.empty(),
                    ),
                  ),
                  child: const Text('+'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
