import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qualita/ui/providers/task_filter_provider.dart';

class DateFilter extends ConsumerWidget {
  const DateFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(taskFilterProvider.notifier);
    final date = notifier.currentDate;
    final firstDate = date.subtract(Duration(days: 365));
    final lastDate = date.add(Duration(days: 365));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () =>
              notifier.switchDate(date.subtract(Duration(days: 1))),
          icon: Icon(Icons.arrow_back),
        ),
        Text(
          '${date.day}/${date.month}/${date.year}',
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
                notifier.switchDate(value);
              }
            });
          },
          icon: Icon(Icons.calendar_month),
        ),
        IconButton(
          onPressed: () => notifier.switchDate(date.add(Duration(days: 1))),
          icon: Icon(Icons.arrow_forward),
        ),
      ],
    );
  }
}
