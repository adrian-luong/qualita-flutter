import 'package:flutter/material.dart';
import 'package:qualita/utils/custom_builders.dart';
import 'package:qualita/view/home/steps/add_step_button.dart';
import 'package:qualita/view/home/steps/step_column.dart';
import 'package:qualita/view/home/steps/step_controller.dart';

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
    return customStreamBuilder(
      stream: _controller.streamStep(widget.selectedProjectId),
      builder: (data) {
        var panels =
            data
                .map(
                  (row) => StepColumn(
                    id: row['id'],
                    name: row['name'],
                    key: ValueKey(row['position']),
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
