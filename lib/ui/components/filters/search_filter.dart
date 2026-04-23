import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qualita/ui/providers/task_filter_provider.dart';

class SearchFilter extends ConsumerWidget {
  const SearchFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(taskFilterProvider.notifier);
    final TextEditingController controller = TextEditingController(
      text: notifier.currentSearch,
    );

    return Expanded(
      child: TextField(
        controller: controller,
        onChanged: (value) => notifier.search(value),
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'Search by title',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
