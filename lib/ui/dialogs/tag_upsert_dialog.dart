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
  late Tag formTag;
  String labelError = '';

  @override
  void initState() {
    setState(() {
      formTag = Tag(
        id: widget.tag.id != '' ? widget.tag.id : generateID(),
        label: widget.tag.label,
        description: widget.tag.description,
      );
    });
    super.initState();
  }

  bool _validate() {
    if (formTag.label.isEmpty) {
      setState(() => labelError = 'A task must have a title');
      return false;
    }
    return true;
  }

  void _submit() {
    if (_validate()) {
      if (widget.mode == FormMode.edit) {
        TagRepository.editTag(formTag);
      } else {
        TagRepository.addTag(formTag);
      }
      _close(
        widget.mode == FormMode.edit
            ? 'Successfully edited tag'
            : 'Successfully created tag',
      );
    }
  }

  void _close(String message) {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _delete() => TagRepository.deleteTag(widget.tag.id);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          child: IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 10,
              children: [
                Text(
                  widget.mode == FormMode.create
                      ? 'Add new tag'
                      : 'Edit ${formTag.label}',
                ),
                Divider(),
                TextFormField(
                  initialValue: formTag.label,
                  decoration: InputDecoration(
                    labelText: 'Tag label',
                    errorText: labelError,
                  ),
                  onChanged: (value) => setState(() => formTag.label = value),
                ),
                TextFormField(
                  initialValue: formTag.description,
                  minLines: 2,
                  maxLines: 20,
                  decoration: InputDecoration(labelText: 'Tag description'),
                  onChanged: (value) =>
                      setState(() => formTag.description = value),
                ),
                Divider(),
                Row(
                  children: [
                    if (widget.mode == FormMode.edit)
                      FilledButton(
                        onPressed: () {
                          _delete();
                          _close('Successfully removed tag');
                        },
                        child: Text('Delete'),
                      ),
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
      ),
    );
  }
}
