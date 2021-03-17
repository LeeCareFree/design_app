import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum BgAction { action }

class BgActionCreator {
  static Action onAction() {
    return const Action(BgAction.action);
  }
}
