import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualita/data/providers/project_provider.dart';
import 'package:qualita/utils/common_types.dart';
import 'package:qualita/view/home/projects/project_form.dart';
import 'package:qualita/view/home/tags/tag_table.dart';

class ProjectSettings extends StatefulWidget {
  const ProjectSettings({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends State<ProjectSettings> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.of(context);
    final projectProvider = Provider.of<ProjectProvider>(context);

    final tabLabels = ['General', 'Tags'];
    final tabContents = [
      (projectProvider.selectedProject != null)
          ? ProjectForm(
            formMode: FormTypes.edit,
            project: projectProvider.selectedProject!,
          )
          : Text('No project selected'),
      TagTable(),
    ];

    var pills =
        tabLabels
            .asMap()
            .map(
              (index, label) => MapEntry(
                index,
                Container(
                  alignment: Alignment.centerLeft,
                  width: 100,
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 5,
                        color:
                            selectedIndex == index
                                ? scheme.primary
                                : Colors.transparent,
                      ),
                      TextButton(
                        onPressed: () => setState(() => selectedIndex = index),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            tabLabels[index],
                            style: TextStyle(
                              color:
                                  selectedIndex == index
                                      ? scheme.primary
                                      : scheme.onSurface,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .values
            .toList();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 10),
        Column(children: pills),
        SizedBox(width: 10),
        Container(height: 375, width: 2, color: scheme.onSurface),
        SizedBox(width: 20),
        tabContents[selectedIndex],
      ],
    );
  }
}
