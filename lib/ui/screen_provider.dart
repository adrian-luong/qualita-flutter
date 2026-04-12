import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qualita/utils/constant_enums.dart';

final screenProvider = NotifierProvider<ScreenState, Screen>(ScreenState.new);

class ScreenState extends Notifier<Screen> {
  @override
  Screen build() => Screen.home;

  void switchScreen(Screen target) {
    state = target;
  }
}
