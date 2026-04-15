import 'package:flutter/material.dart';
import 'package:qualita/data/models/tag.dart';
import 'package:qualita/data/repositories/tag_repository.dart';
import 'package:qualita/utils/constant_enums.dart';
import 'package:qualita/utils/generate_id.dart';

class TagUpsertDialog extends StatefulWidget {
  final FormMode mode;
  final Tag tag;

  const TagUpsertDialog({super.key, required this.mode, required this.tag});

  @override
  State<StatefulWidget> createState() => _TagUpsertDialogState();
}

class _TagUpsertDialogState extends State<TagUpsertDialog> {
  late String formLabel;
  late String? formDesc;

  @override
  void initState() {
    setState(() {
      formLabel = widget.tag.label;
      formDesc = widget.tag.description;
    });
    super.initState();
  }

  void _submit() {
    final newTag = Tag(
      id: widget.tag.id != '' ? widget.tag.id : generateID(),
      label: formLabel,
      description: formDesc,
    );

    if (widget.mode == FormMode.edit) {
      TagRepository.editTag(newTag);
    } else {
      TagRepository.addTag(newTag);
    }

    Navigator.of(context).pop();
  }

  void _delete() {
    TagRepository.deleteTag(widget.tag.id);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.mode == FormMode.create ? 'Add new tag' : 'Edit $formLabel',
      ),
      content: Form(
        child: IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 10,
            children: [
              Divider(),
              TextFormField(
                initialValue: formLabel,
                decoration: InputDecoration(labelText: 'Tag label'),
                onChanged: (value) => setState(() => formLabel = value),
              ),
              TextFormField(
                initialValue: formDesc,
                decoration: InputDecoration(labelText: 'Tag description'),
                onChanged: (value) => setState(() => formDesc = value),
              ),
              Divider(),
              Row(
                children: [
                  if (widget.mode == FormMode.edit)
                    FilledButton(onPressed: _delete, child: Text('Delete')),
                  Spacer(),
                  FilledButton(
                    onPressed: _submit,
                    child: Text(
                      widget.mode == FormMode.create ? 'Add' : 'Edit',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
