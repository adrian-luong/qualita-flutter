import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualita/data/services/step_services.dart';
import 'package:qualita/utils/custom_builders.dart';
import 'package:qualita/view/home/home_state.dart';
import 'package:qualita/view/home/steps/task_panel.dart';

class StepArea extends StatefulWidget {
  const StepArea({super.key});

  @override
  State<StatefulWidget> createState() => _AreaState();
}

class _AreaState extends State<StepArea> {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<HomeState>(context);
    final services = StepServices();

    if (state.selectedProject != null) {
      return customStreamBuilder(
        stream: services.streamByProject(state.selectedProject!),
        builder: (data) {
          var panels = data.map((row) => TaskPanel(name: row['name']));
          var widgets = <Widget>[];
          panels.toList().asMap().forEach((index, panel) {
            widgets.add(panel);
            widgets.add(SizedBox(width: 16));
          });
          return Row(children: widgets);
        },
      );
    } else {
      return Row(children: [Text('Please select a project')]);
    }
  }
}
