import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qualita/data/models/task_status.dart';
import 'package:qualita/ui/providers/task_filter_provider.dart';

class StatusFilter extends ConsumerWidget {
  const StatusFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(taskFilterProvider.notifier);
    final status = notifier.currentStatus;

    return Row(
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
                    color: status == status
                        ? Colors.white
                        : TaskStatus.getTextColor(status),
                  ),
                ),
              ),
            ),
          ],
          selected: <TaskStatus?>{status},
          onSelectionChanged: (newSet) => notifier.switchStatus(newSet.first),
        ),
      ],
    );
  }
}
