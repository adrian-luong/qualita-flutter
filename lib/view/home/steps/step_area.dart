import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualita/data/models/step_model.dart';
import 'package:qualita/utils/custom_builders.dart';
import 'package:qualita/view/home/home_state.dart';
import 'package:qualita/view/home/steps/add_step_button.dart';
import 'package:qualita/view/home/steps/step_controller.dart';
import 'package:qualita/view/home/steps/step_panel.dart';
import 'package:qualita/view/home/tasks/task_area.dart';

class StepArea extends StatefulWidget {
  final String selectedProjectId;
  const StepArea({super.key, required this.selectedProjectId});

  @override
  State<StatefulWidget> createState() => _AreaState();
}

class _AreaState extends State<StepArea> {
  final _controller = StepController();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<HomeState>(context);

    return customStreamBuilder(
      stream: _controller.streamStep(widget.selectedProjectId),
      builder: (data) {
        var steps = data.map((row) => StepModel.fromMap(row)).toList();
        //  Store queried data in Provider
        WidgetsBinding.instance.addPostFrameCallback((_) {
          state.storeSteps(steps);
        });

        var panels =
            steps
                .map(
                  (step) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        StepPanel(step: step, stepAmount: steps.length),
                        SizedBox(height: 16),
                        TaskArea(),
                      ],
                    ),
                  ),
                )
                .toList();

        return ListView(
          scrollDirection: Axis.horizontal,
          children: [...panels, AddStepButton()],
        );
      },
    );
  }
}
