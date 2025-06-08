import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualita/data/models/step_model.dart';
import 'package:qualita/utils/display_dialog.dart';
import 'package:qualita/view/home/home_state.dart';
import 'package:qualita/view/home/steps/add_step_form.dart';
import 'package:qualita/view/home/steps/step_controller.dart';
import 'package:qualita/view/home/steps/step_panel.dart';
import 'package:qualita/view/home/tasks/task_area.dart';

class StepArea extends StatefulWidget {
  const StepArea({super.key});

  @override
  State<StatefulWidget> createState() => _AreaState();
}

class _AreaState extends State<StepArea> {
  final _controller = StepController();
  List<StepModel> steps = [];

  Future<void> fetchSteps(String projectId) async {
    final queriedSteps = await _controller.listStep(projectId);
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
    final state = Provider.of<HomeState>(context, listen: false);
    if (state.selectedProject != null) {
      fetchSteps(state.selectedProject!);
    }
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
                    TaskArea(stepId: step.id!),
                  ],
                ),
              ),
            )
            .toList();

    return ReorderableListView(
      scrollDirection: Axis.horizontal,
      footer: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          color: Colors.grey[200],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: IconButton(
                  onPressed:
                      () => displayDialog<String>(context, [AddStepForm()]),
                  icon: Icon(Icons.add_box_outlined),
                  selectedIcon: Icon(Icons.add_box),
                ),
              ),
            ],
          ),
        ),
      ),
      onReorder: (oldIndex, newIndex) async {
        if (mounted) {
          await reorderStep(oldIndex, newIndex);
        }
      },
      children: panels,
    );
  }
}
