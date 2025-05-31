import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualita/view/home/home_state.dart';
import 'package:qualita/view/home/steps/step_controller.dart';

class StepPanel extends StatefulWidget {
  final String id;
  final String name;
  const StepPanel({super.key, required this.name, required this.id});

  @override
  State<StatefulWidget> createState() => _PanelState();
}

class _PanelState extends State<StepPanel> {
  final _controller = StepController();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<HomeState>(context);
    var isEditing = state.editingStep == widget.id && state.editingStep != null;
    _controller.name.text = widget.name;

    return Container(
      width: 200,
      height: 50,
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child:
                  (!isEditing)
                      ? Text(
                        widget.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                      : TextField(
                        controller: _controller.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(bottom: 8),
                          border: UnderlineInputBorder(),
                        ),
                        onSubmitted: (value) async {
                          await _controller.renameStep(
                            widget.id,
                            value,
                            state.selectedProject!,
                          );
                          state.editStep(null);
                        },
                      ),
            ),
            SizedBox(width: 32),
            IconButton(
              onPressed: () => state.editStep(!isEditing ? widget.id : null),
              icon: Icon(!isEditing ? Icons.edit : Icons.edit_off),
            ),
          ],
        ),
      ),
    );
  }
}
