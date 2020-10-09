import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum LikeAction { action }

class LikeActionCreator {
  static Action onAction() {
    return const Action(LikeAction.action);
  }
}
