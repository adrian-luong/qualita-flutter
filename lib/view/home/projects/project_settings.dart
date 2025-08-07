import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualita/data/providers/home_provider.dart';
import 'package:qualita/global_keys.dart';
import 'package:qualita/utils/common_types.dart';
import 'package:qualita/utils/display_dialog.dart';
import 'package:qualita/utils/empty_objects.dart';
import 'package:qualita/view/home/tags/tag_form.dart';

class ProjectSettings extends StatefulWidget {
  const ProjectSettings({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends State<ProjectSettings> {
  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.of(context);

    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.errorMessage != null) {
          return Center(
            child: Text(
              provider.errorMessage!,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        var headerRow = TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Tag name'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Description'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed:
                    () => displayDialog(context, [
                      TagForm(
                        formMode: FormTypes.create,
                        tag: getEmptyTag(
                          customProjectId: provider.selectedProject!,
                        ),
                      ),
                    ]),
                child: Text('Add new tag +'),
              ),
            ),
          ],
        );
        var dataRows =
            provider.tags
                .map(
                  (tag) => TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(tag.name),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(tag.description ?? ''),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed:
                                  () => displayDialog(context, [
                                    TagForm(formMode: FormTypes.edit, tag: tag),
                                  ]),
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed:
                                  () => confirmDelete(context, 'Delete tag', () {
                                    try {
                                      provider.deleteTag(tag.id!);
                                      displayMessage(
                                        SnackBar(
                                          content: Text(
                                            'Tag ${tag.name} has been successfully deleted',
                                          ),
                                        ),
                                      );
                                    } catch (e) {
                                      displayMessage(
                                        SnackBar(content: Text(e.toString())),
                                      );
                                    } finally {
                                      popContext(); // Close the confirmation dialog
                                    }
                                  }),
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
                .toList();

        return Expanded(
          child: Table(
            border: TableBorder.all(color: scheme.primary, width: 2.0),
            defaultVerticalAlignment: TableCellVerticalAlignment.top,
            children: [headerRow, ...dataRows],
            columnWidths: const <int, TableColumnWidth>{
              0: IntrinsicColumnWidth(),
              1: IntrinsicColumnWidth(),
              2: IntrinsicColumnWidth(),
            },
          ),
        );
      },
    );
  }
}
