import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum EntranceAction { action }

class EntranceActionCreator {
  static Action onAction() {
    return const Action(EntranceAction.action);
  }
}
