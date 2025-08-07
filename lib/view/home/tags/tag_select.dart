import 'package:flutter/material.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:provider/provider.dart';
import 'package:qualita/data/providers/home_provider.dart';

class TagSelect extends StatefulWidget {
  final List<String> tags;
  final void Function(List<String> selected) onPickingTags;
  const TagSelect({super.key, required this.onPickingTags, required this.tags});

  @override
  State<StatefulWidget> createState() => _SelectState();
}

class _SelectState extends State<TagSelect> {
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
                .map((tag) => MultiSelectItem<String>(tag.id!, tag.name))
                .toList();
        var preSelectedItems =
            items.where((item) => widget.tags.contains(item.value)).toList();
        return Container(
          decoration: BoxDecoration(
            color: scheme.surface,
            border: BoxBorder.all(color: scheme.onSurface),
            borderRadius: BorderRadiusGeometry.circular(4),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: MultiSelectDialogField<String>(
              items: items,
              initialValue: preSelectedItems.map((item) => item.value).toList(),
              listType: MultiSelectListType.CHIP,
              chipDisplay: MultiSelectChipDisplay(items: items),
              title: Text('Select tags for this task'),
              buttonText: Text('Tag'),
              onConfirm: (values) => widget.onPickingTags(values),
              selectedColor: scheme.primary,
              selectedItemsTextStyle: TextStyle(color: scheme.onSurface),
              decoration: BoxDecoration(),
              // searchable: true,
              // searchHint: 'Select tags for this task',
              // searchTextStyle: TextStyle(fontSize: 16),
            ),
          ),
        );
      },
    );
  }
}
