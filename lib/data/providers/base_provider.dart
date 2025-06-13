import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BaseProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> operate(Future<void> Function() operation) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners(); // Notify listeners that loading has started
      await operation();
    } on PostgrestException catch (e) {
      _errorMessage = e.message;
    } catch (e) {
      _errorMessage = 'An unexpected error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify listeners that loading has ended
    }
  }
}
