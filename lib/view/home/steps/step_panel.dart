import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualita/data/models/step_model.dart';
import 'package:qualita/view/home/home_state.dart';
import 'package:qualita/view/home/steps/step_controller.dart';

class StepPanel extends StatefulWidget {
  final StepModel step;
  final int stepAmount;
  const StepPanel({super.key, required this.step, this.stepAmount = 0});

  @override
  State<StatefulWidget> createState() => _PanelState();
}

class _PanelState extends State<StepPanel> {
  final _controller = StepController();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<HomeState>(context);
    var isEditing =
        state.editingStep == widget.step.id && state.editingStep != null;
    _controller.name.text = widget.step.name;

    return Container(
      width: 300,
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
                        widget.step.name,
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
                            widget.step.id!,
                            value,
                            state.selectedProject!,
                          );
                          state.editStep(null);
                        },
                      ),
            ),
            SizedBox(width: 32),
            IconButton(
              onPressed:
                  () => state.editStep(!isEditing ? widget.step.id : null),
              icon: Icon(!isEditing ? Icons.edit : Icons.edit_off),
            ),
          ],
        ),
      ),
    );
  }
}
