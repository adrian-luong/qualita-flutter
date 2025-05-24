import 'package:flutter/material.dart';
import 'package:qualita/utils/display_dialog.dart';
import 'package:qualita/view/home/panels/add_panel_form.dart';

class AddPanelButton extends StatelessWidget {
  const AddPanelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.grey[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: IconButton(
              onPressed: () => displayDialog<String>(context, [AddPanelForm()]),
              icon: Icon(Icons.add_box_outlined),
              selectedIcon: Icon(Icons.add_box),
            ),
          ),
        ],
      ),
    );
  }
}
