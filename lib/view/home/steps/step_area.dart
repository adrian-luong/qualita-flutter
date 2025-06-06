import 'package:flutter/material.dart';
import 'package:qualita/data/models/step_model.dart';
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
  List<StepModel> steps = [];

  Future<void> fetchSteps() async {
    final queriedSteps = await _controller.listStep(widget.selectedProjectId);
    setState(() => steps = queriedSteps);
  }

  Future<void> reorderStep(int oldPosition, int newPosition) async {
    List<StepModel> newOrder = List.from(steps);
    newOrder.sort((a, b) => a.position.compareTo(b.position));

    if (oldPosition < newPosition) {
      newPosition -= 1;
    }
    final step = newOrder.removeAt(oldPosition);
    newOrder.insert(newPosition, step);

    newOrder.asMap().forEach((index, item) => item.position = index);
    newOrder.sort((a, b) => a.position.compareTo(b.position));
    await _controller.repositionStep(newOrder);
    setState(() => steps = newOrder);
  }

  @override
  void initState() {
    super.initState();
    fetchSteps();
  }

  @override
  Widget build(BuildContext context) {
    var panels =
        steps
            .map(
              (step) => Padding(
                key: ValueKey(step.id),
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

    return ReorderableListView(
      scrollDirection: Axis.horizontal,
      footer: AddStepButton(),
      onReorder:
          (oldIndex, newIndex) async => await reorderStep(oldIndex, newIndex),
      children: panels,
    );
  }
}
