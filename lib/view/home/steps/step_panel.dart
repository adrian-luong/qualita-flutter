import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualita/data/models/step_model.dart';
import 'package:qualita/data/providers/settings_provider.dart';
import 'package:qualita/utils/common_types.dart';
import 'package:qualita/utils/display_dialog.dart';
import 'package:qualita/view/home/steps/step_form.dart';

class StepPanel extends StatefulWidget {
  final StepModel step;
  const StepPanel({super.key, required this.step});

  @override
  State<StatefulWidget> createState() => _PanelState();
}

class _PanelState extends State<StepPanel> {
  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);

    return Container(
      width: 300,
      height: 50,
      color: settings.isDarkMode() ? Colors.grey[800] : Colors.grey[300],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.step.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: settings.isDarkMode() ? Colors.white : Colors.black,
                ),
              ),
            ),
            SizedBox(width: 32),
            TextButton(
              onPressed:
                  () => displayDialog(context, [
                    StepForm(formMode: FormTypes.edit, step: widget.step),
                  ]),
              child: Icon(Icons.edit),
            ),
          ],
        ),
      ),
    );
  }
}
