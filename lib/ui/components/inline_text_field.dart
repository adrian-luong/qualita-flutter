import 'package:flutter/material.dart';
import 'package:qualita/utils/type_definitions.dart';

class InlineTextField extends StatefulWidget {
  final String defaultValue;
  final InlineSubmitFunction onSave;

  const InlineTextField({
    super.key,
    required this.defaultValue,
    required this.onSave,
  });

  @override
  State<StatefulWidget> createState() => _InlineTextFieldState();
}

class _InlineTextFieldState extends State<InlineTextField> {
  late TextEditingController _controller;
  bool isEditing = false;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.defaultValue);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        isEditing
            ? Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  onSubmitted: (value) {
                    widget.onSave(value);
                    setState(() => isEditing = false);
                  },
                ),
              )
            : Text(widget.defaultValue),
        Tooltip(
          message: 'Click to edit this field. Press Enter to submit change',
          child: IconButton(
            onPressed: () => setState(() => isEditing = !isEditing),
            icon: Icon(isEditing ? Icons.close : Icons.edit),
          ),
        ),
      ],
    );
  }
}
