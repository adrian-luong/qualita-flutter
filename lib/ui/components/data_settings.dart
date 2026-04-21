import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:qualita/data/models/tag.dart';
import 'package:qualita/data/models/task_status.dart';
import 'package:qualita/data/repositories/tag_repository.dart';
import 'package:qualita/ui/components/dashboard_box.dart';
import 'package:qualita/ui/components/inline_text_field.dart';
import 'package:qualita/ui/dialogs/tag_upsert_dialog.dart';
import 'package:qualita/utils/constant_enums.dart';

class DataSettings extends StatelessWidget {
  const DataSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final messenger = ScaffoldMessenger.of(context);

    return Column(
      spacing: 15,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: DashboardBox(status: TaskStatus.onHold),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: DashboardBox(status: TaskStatus.inProgress),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: DashboardBox(status: TaskStatus.completed),
            ),
          ],
        ),

        ValueListenableBuilder(
          valueListenable: TagRepository.box.listenable(),
          builder: (context, box, child) {
            List<Tag> tags = TagRepository.getAllTags();
            return Table(
              border: TableBorder.all(color: scheme.primary),
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text('Tag label'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text('Tag description'),
                    ),
                  ],
                ),
                ...tags.map(
                  (tag) => TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: InlineTextField(
                          defaultValue: tag.label,
                          onSave: (newLabel) async {
                            final newTag = Tag(
                              id: tag.id,
                              label: newLabel,
                              description: tag.description,
                            );
                            await TagRepository.editTag(newTag);
                            messenger.showSnackBar(
                              SnackBar(
                                content: Text('Successfully edited tag'),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: InlineTextField(
                          defaultValue: tag.description ?? '',
                          onSave: (newDesc) async {
                            final newTag = Tag(
                              id: tag.id,
                              label: tag.label,
                              description: newDesc,
                            );
                            await TagRepository.editTag(newTag);
                            messenger.showSnackBar(
                              SnackBar(
                                content: Text('Successfully edited tag'),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Tooltip(
            message: 'Create a new tag',
            child: FilledButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) =>
                    TagUpsertDialog(mode: FormMode.create, tag: Tag.empty()),
              ),
              child: const Text('+'),
            ),
          ),
        ),
      ],
    );
  }
}
