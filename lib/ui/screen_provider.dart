import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qualita/utils/constant_enums.dart';

final screenProvider = NotifierProvider<ScreenNotifier, Screen>(
  ScreenNotifier.new,
);

class ScreenNotifier extends Notifier<Screen> {
  @override
  Screen build() => Screen.home;

  void switchScreen(Screen target) {
    state = target;
  }
}
