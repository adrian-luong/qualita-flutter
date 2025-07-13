import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualita/data/providers/home_provider.dart';
import 'package:qualita/global_keys.dart';

class SearchArea extends StatefulWidget {
  const SearchArea({super.key});

  @override
  State<StatefulWidget> createState() => _AreaState();
}

class _AreaState extends State<SearchArea> {
  final _formKey = GlobalKey<FormState>();
  final _term = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);

    void onSearch() async {
      if (!_formKey.currentState!.validate()) {
        return;
      }

      try {
        var term = _term.text.trim();
        await provider.fetchTasks(term);
      } catch (e) {
        displayMessage(SnackBar(content: Text(e.toString())));
      }
    }

    return SizedBox(
      child: Form(
        key: _formKey,
        child: Row(
          children: [
            SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: _term,
                decoration: InputDecoration(
                  label: Text('Search'),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(width: 8),
            // Preserve for search filters
            IconButton.filled(
              onPressed: onSearch,
              icon: Icon(Icons.search),
              style: ButtonStyle(
                padding: WidgetStateProperty.all(EdgeInsets.all(12)),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.zero),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
