import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualita/data/providers/home_provider.dart';
import 'package:qualita/utils/display_dialog.dart';
import 'package:qualita/view/home/steps/add_step_form.dart';
// import 'package:qualita/view/home/steps/step_controller.dart';
import 'package:qualita/view/home/steps/step_panel.dart';
import 'package:qualita/view/home/tasks/task_area.dart';

class StepArea extends StatefulWidget {
  const StepArea({super.key});

  @override
  State<StatefulWidget> createState() => _AreaState();
}

class _AreaState extends State<StepArea> {
  // final _controller = StepController();

  // Future<void> reorderStep(int oldPosition, int newPosition) async {
  //   List<StepModel> newOrder = List.from(steps);
  //   newOrder.sort((a, b) => a.position.compareTo(b.position));

  //   if (oldPosition < newPosition) {
  //     newPosition -= 1;
  //   }
  //   final step = newOrder.removeAt(oldPosition);
  //   newOrder.insert(newPosition, step);

  //   newOrder.asMap().forEach((index, item) => item.position = index);
  //   newOrder.sort((a, b) => a.position.compareTo(b.position));
  //   await _controller.repositionStep(newOrder);
  //   setState(() => steps = newOrder);
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.errorMessage != null) {
          return Center(
            child: Text(
              provider.errorMessage!,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (provider.selectedProject == null) {
          return const Text('Please select a project');
        }
        if (provider.steps.isEmpty) {
          return const Text('No step available for this project');
        }

        var panels =
            provider.steps
                .map(
                  (step) => Padding(
                    key: ValueKey(step.id),
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        StepPanel(
                          step: step,
                          stepAmount: provider.steps.length,
                        ),
                        SizedBox(height: 16),
                        TaskArea(),
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
            // if (mounted) {
            //   await reorderStep(oldIndex, newIndex);
            // }
          },
          children: panels,
        );
      },
    );
  }
}
