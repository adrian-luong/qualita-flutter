import 'package:flutter/material.dart';
import 'package:qualita/global_keys.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

typedef DataHandler = Widget Function(List<Map<String, dynamic>> data);
typedef ExceptionHandler = Widget Function(Object? error);

/// An extension to Material's StreamBuilder that supports custom builder and handler functions
Widget customStreamBuilder({
  required SupabaseStreamBuilder stream,
  required DataHandler builder,
  ExceptionHandler? onException,
  Widget unauthorizedMsg = const Text("Unauthorized user"),
  Widget waitingIndicator = const Column(
    children: [CircularProgressIndicator()],
  ),
  Widget missingDataMsg = const Text("No data available"),
}) {
  return StreamBuilder(
    stream: stream,
    builder: (context, snapshot) {
      if (getCurrentUser() == null) {
        return unauthorizedMsg;
      }

      if (!snapshot.hasData) {
        return missingDataMsg;
      }

      if (snapshot.hasError) {
        return onException != null
            ? onException(snapshot.error)
            : Text('Something went wrong: ${snapshot.error}');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return waitingIndicator;
      }

      if (snapshot.data!.isEmpty) {
        return missingDataMsg;
      }

      return builder(snapshot.data!);
    },
  );
}
