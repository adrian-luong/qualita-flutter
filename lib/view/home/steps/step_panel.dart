import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualita/data/models/step_model.dart';
import 'package:qualita/data/providers/home_provider.dart';
import 'package:qualita/data/providers/settings_provider.dart';

class StepPanel extends StatefulWidget {
  final StepModel step;
  final int stepAmount;
  const StepPanel({super.key, required this.step, this.stepAmount = 0});

  @override
  State<StatefulWidget> createState() => _PanelState();
}

class _PanelState extends State<StepPanel> {
  final _name = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);
    final settings = Provider.of<SettingsProvider>(context);
    var isEditing =
        provider.selectedStep == widget.step.id &&
        provider.selectedStep != null;
    _name.text = widget.step.name;

    return Container(
      width: 300,
      height: 50,
      color: settings.isDarkMode() ? Colors.grey[800] : Colors.grey[300],
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
                          color:
                              settings.isDarkMode()
                                  ? Colors.white
                                  : Colors.black,
                        ),
                      )
                      : TextField(
                        controller: _name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color:
                              settings.isDarkMode()
                                  ? Colors.white
                                  : Colors.black,
                        ),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(bottom: 8),
                          border: UnderlineInputBorder(),
                        ),
                        onSubmitted: (value) async {
                          await provider.renameStep(widget.step.id!, value);
                          provider.editStep(null);
                        },
                      ),
            ),
            SizedBox(width: 32),
            IconButton(
              onPressed:
                  () => provider.editStep(!isEditing ? widget.step.id : null),
              icon: Icon(!isEditing ? Icons.edit : Icons.edit_off),
            ),
          ],
        ),
      ),
    );
  }
}
