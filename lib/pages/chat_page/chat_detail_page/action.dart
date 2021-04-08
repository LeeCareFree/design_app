import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ChatDetailAction { action, sendMessage, upDateIsShowSticker }

class ChatDetailActionCreator {
  static Action onAction() {
    return const Action(ChatDetailAction.action);
  }

  static Action sendMessage(String type) {
    return Action(ChatDetailAction.sendMessage, payload: type);
  }

  static Action upDateIsShowSticker(bool isShowSticker) {
    return Action(ChatDetailAction.upDateIsShowSticker, payload: isShowSticker);
  }
}
