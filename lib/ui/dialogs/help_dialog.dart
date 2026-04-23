import 'package:flutter/material.dart';

class HelpDialog extends StatelessWidget {
  const HelpDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 20,
            children: [
              Text('Help', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: [
                  Column(
                    spacing: 10,
                    children: [
                      const Text('1. Create and manage your tasks'),
                      Image.asset('help/create_task.gif', height: 250),
                    ],
                  ),
                  Column(
                    spacing: 10,
                    children: [
                      const Text(
                        '2. Filter tasks by date, search term, or status',
                      ),
                      Image.asset('help/filter_tasks.gif', height: 250),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: [
                  Column(
                    spacing: 10,
                    children: [
                      const Text('3. Update and delete existing tasks'),
                      Image.asset('help/edit_task.gif', height: 250),
                    ],
                  ),
                  Column(
                    spacing: 10,
                    children: [
                      const Text('4. Switch between light and dark themes'),
                      Image.asset('help/switch_theme.gif', height: 150),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: [
                  Column(
                    spacing: 10,
                    children: [
                      const Text(
                        '5. Create and manage tags for better organization',
                      ),
                      Image.asset('help/upsert_tag.gif', height: 250),
                    ],
                  ),
                ],
              ),
              // const SizedBox(height: 8),

              // Image.asset('help/switch_theme.gif'),
              // const SizedBox(height: 8),
              // const Text('6. Enjoy a clean and intuitive user interface'),
            ],
          ),
        ),
      ),
    );
  }
}
