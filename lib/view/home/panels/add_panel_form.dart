import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualita/global_keys.dart';
import 'package:qualita/view/home/home_state.dart';
import 'package:qualita/view/home/panels/panel_controller.dart';

class AddPanelForm extends StatefulWidget {
  const AddPanelForm({super.key});

  @override
  State<StatefulWidget> createState() => _FormState();
}

class _FormState extends State<AddPanelForm> {
  final _controller = PanelController();
  bool isLoading = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<HomeState>(context);

    Future<void> onSubmit() async {
      if (!_controller.formKey.currentState!.validate()) {
        return;
      }

      setState(() => isLoading = true);
      await _controller.addPanel(state.selectedProject!).then((value) {
        if (value != 'OK') {
          displayMessage(SnackBar(content: Text(value)));
        }
        popContext();
      });
      setState(() => isLoading = false);
    }

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add project form', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 40),

            TextFormField(
              controller: _controller.name,
              decoration: InputDecoration(
                label: Text('Project title'),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),

            isLoading
                ? Center(child: CircularProgressIndicator())
                : SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          dispose();
                          popContext();
                        },
                        child: Text('CLOSE'),
                      ),
                      ElevatedButton(onPressed: onSubmit, child: Text('ADD')),
                    ],
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
