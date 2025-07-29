import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:qualita/data/models/tag_model.dart';
import 'package:qualita/data/providers/home_provider.dart';

class TagSelect extends StatefulWidget {
  final void Function(List<TagModel> selected) onPickingTags;
  const TagSelect({super.key, required this.onPickingTags});

  @override
  State<StatefulWidget> createState() => _SelectState();
}

class _SelectState extends State<TagSelect> {
  final controller = MultiSelectController<TagModel>();

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

        var items =
            provider.tags
                .map((tag) => DropdownItem(label: tag.name, value: tag))
                .toList();
        return MultiDropdown<TagModel>(
          items: items,
          controller: controller,
          enabled: true,
          searchEnabled: true,
          chipDecoration: ChipDecoration(
            backgroundColor: scheme.primary,
            wrap: true,
            runSpacing: 2,
            spacing: 10,
          ),
          fieldDecoration: FieldDecoration(
            hintText: 'Tag',
            showClearIcon: true,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: scheme.primary),
            ),
          ),
          dropdownDecoration: DropdownDecoration(
            backgroundColor: scheme.surface,
            header: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Select tags for this task',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          dropdownItemDecoration: DropdownItemDecoration(
            textColor: scheme.secondary,
            selectedIcon: Icon(Icons.check_box, color: scheme.primary),
            disabledIcon: Icon(Icons.lock),
            selectedBackgroundColor: scheme.primary,
            selectedTextColor: scheme.onPrimary,
          ),
          searchDecoration: SearchFieldDecoration(),
          onSelectionChange:
              (selectedItem) => widget.onPickingTags(selectedItem),
        );
      },
    );
  }
}
