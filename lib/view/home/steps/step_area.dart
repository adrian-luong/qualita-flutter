import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualita/data/services/step_services.dart';
import 'package:qualita/utils/custom_builders.dart';
import 'package:qualita/view/home/home_state.dart';
import 'package:qualita/view/home/steps/add_step_button.dart';
import 'package:qualita/view/home/steps/step_column.dart';

class StepArea extends StatefulWidget {
  const StepArea({super.key});

  @override
  State<StatefulWidget> createState() => _AreaState();
}

class _AreaState extends State<StepArea> {
  final services = StepServices();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<HomeState>(context);

    if (state.selectedProject != null) {
      return customStreamBuilder(
        stream: services.streamByProject(state.selectedProject!),
        builder: (data) {
          var panels = data.map(
            (row) =>
                StepColumn(name: row['name'], key: ValueKey(row['position'])),
          );
          return ReorderableListView(
            footer: AddStepButton(),
            scrollDirection: Axis.horizontal,
            children: panels.toList(),
            onReorder: (oldPos, newPost) {},
          );
        },
      );
    } else {
      return Text('Please select a project');
    }
  }
}
