import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualita/utils/display_dialog.dart';
import 'package:qualita/view/common/common_layout.dart';
import 'package:qualita/view/home/home_state.dart';
import 'package:qualita/view/home/panels/add_panel.dart';
import 'package:qualita/view/home/panels/panel_area.dart';
import 'package:qualita/view/home/projects/add_project_form.dart';
import 'package:qualita/view/home/projects/project_select.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<HomeState>(context);

    return CommonLayout(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: ProjectSelect()),
                SizedBox(width: 16),
                IconButton(
                  onPressed: () => displayDialog(context, [AddProjectForm()]),
                  icon: Icon(Icons.add_circle_outline),
                  selectedIcon: Icon(Icons.add_circle),
                ),
              ],
            ),
            SizedBox(height: 32),
            Row(
              children: [
                Expanded(child: PanelArea()),
                if (state.selectedProject != null) AddPanel(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
