import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualita/data/providers/base_provider.dart';

Consumer<T> customConsume<T extends BaseProvider>({
  required Widget Function(BuildContext context, T provider, Widget? child)
  build,
}) {
  return Consumer<T>(
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

      return build(context, provider, child);
    },
  );
}
