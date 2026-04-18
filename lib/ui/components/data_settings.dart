import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:qualita/data/models/tag.dart';
import 'package:qualita/data/repositories/tag_repository.dart';
import 'package:qualita/ui/components/inline_text_field.dart';
import 'package:qualita/ui/dialogs/tag_upsert_dialog.dart';
import 'package:qualita/utils/constant_enums.dart';

class DataSettings extends StatelessWidget {
  const DataSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
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
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          FilledButton(
                            onPressed: () => showDialog(
                              context: context,
                              builder: (context) => TagUpsertDialog(
                                mode: FormMode.create,
                                tag: Tag.empty(),
                              ),
                            ),
                            child: Text('Create new tag'),
                          ),
                        ],
                      ),
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
      ],
    );
  }
}
