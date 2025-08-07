import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualita/data/models/tag_model.dart';
import 'package:qualita/data/providers/home_provider.dart';
import 'package:qualita/global_keys.dart';
import 'package:qualita/utils/common_types.dart';

class TagForm extends StatefulWidget {
  final FormTypes formMode;
  final TagModel tag;
  const TagForm({super.key, required this.formMode, required this.tag});

  @override
  State<StatefulWidget> createState() => _FormState();
}

class _FormState extends State<TagForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _desc = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _desc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);
    var buttonText = widget.formMode == FormTypes.create ? 'ADD' : 'EDIT';
    var formTitle =
        widget.formMode == FormTypes.create ? 'Add tag' : 'Edit tag';

    _name.text = widget.tag.name;
    _desc.text = widget.tag.description ?? '';

    Future<void> onSubmit() async {
      if (!_formKey.currentState!.validate()) {
        return;
      }

      try {
        var inputTagName = _name.text.trim();
        var successDisplay =
            widget.formMode == FormTypes.create
                ? 'New tag $inputTagName successfully added'
                : 'Tag $inputTagName successfully edited';

        if (widget.formMode == FormTypes.create) {
          await provider.addTag(
            name: inputTagName,
            description: _desc.text.trim(),
          );
        } else if (widget.tag.id != null) {
          await provider.updateTag(
            id: widget.tag.id!,
            name: inputTagName,
            description: _desc.text.trim(),
          );
        }

        displayMessage(SnackBar(content: Text(successDisplay)));
      } catch (e) {
        displayMessage(SnackBar(content: Text(e.toString())));
      } finally {
        popContext();
      }
    }

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(formTitle, style: TextStyle(fontSize: 20)),
            const SizedBox(height: 40),

            TextFormField(
              controller: _name,
              decoration: InputDecoration(
                label: Text('Tag name'),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),

            TextFormField(
              controller: _desc,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Tag description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),

            provider.isLoading
                ? Center(child: CircularProgressIndicator())
                : SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          dispose();
                          popContext();
                        },
                        child: Text('CLOSE'),
                      ),
                      ElevatedButton(
                        onPressed: onSubmit,
                        child: Text(buttonText),
                      ),
                    ],
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
