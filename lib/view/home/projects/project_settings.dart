import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualita/data/providers/home_provider.dart';

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
                onPressed: () {},
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
                        child: Text(''),
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
