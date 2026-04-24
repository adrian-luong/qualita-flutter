import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qualita/data/models/task_status.dart';
import 'package:qualita/ui/providers/task_filter_provider.dart';

class StatusFilter extends ConsumerStatefulWidget {
  const StatusFilter({super.key});

  @override
  ConsumerState<StatusFilter> createState() => _StatusFilterState();
}

class _StatusFilterState extends ConsumerState<StatusFilter> {
  TaskStatus? _status;

  @override
  void initState() {
    setState(
      () => _status = ref.read(taskFilterProvider.notifier).currentStatus,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(taskFilterProvider.notifier);

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
                    color: _status == status
                        ? Colors.white
                        : TaskStatus.getTextColor(status),
                  ),
                ),
              ),
            ),
          ],
          selected: <TaskStatus?>{_status},
          onSelectionChanged: (newSet) {
            setState(() => _status = newSet.first);
            notifier.switchStatus(newSet.first);
          },
        ),
      ],
    );
  }
}
