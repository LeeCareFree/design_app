import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SortAction { action }

class SortActionCreator {
  static Action onAction() {
    return const Action(SortAction.action);
  }
}
