import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

typedef StreamDataHandler<T> =
    Widget Function(List<QueryDocumentSnapshot<T>> snapshotData);

typedef ExceptionHandler = Widget Function(Object? error);

/// An extension to Material's StreamBuilder that supports custom builder and handler functions
Widget customStreamBuilder<T>({
  required Stream<QuerySnapshot<T>> stream,
  required StreamDataHandler<T> builder,
  ExceptionHandler? onException,
  Widget unauthorizedMsg = const Text("Unauthorized user"),
  Widget waitingIndicator = const CircularProgressIndicator(),
  Widget missingDataMsg = const Text("No data available"),
}) {
  return StreamBuilder(
    stream: stream,
    builder: (context, snapshot) {
      if (FirebaseAuth.instance.currentUser == null) {
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

      if (snapshot.data!.docs.isEmpty) {
        return missingDataMsg;
      }

      return builder(snapshot.data!.docs);
    },
  );
}
