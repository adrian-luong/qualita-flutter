import 'package:flutter/material.dart';
import 'package:qualita/utils/display_dialog.dart';
import 'package:qualita/view/home/steps/add_step_form.dart';

class AddStepButton extends StatelessWidget {
  const AddStepButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
