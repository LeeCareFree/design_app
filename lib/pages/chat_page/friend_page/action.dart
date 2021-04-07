import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum FriendAction { action, sendMessage }

class FriendActionCreator {
  static Action onAction() {
    return const Action(FriendAction.action);
  }

  static Action sendMessage(String message) {
    return Action(FriendAction.sendMessage, payload: message);
  }
}
