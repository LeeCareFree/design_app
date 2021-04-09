import 'package:bluespace/components/message_item.dart';
import 'package:bluespace/models/chat_list.dart';
import 'package:bluespace/models/chat_model.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ChatDetailAction {
  action,
  sendMessage,
  upDateIsShowSticker,
  setMessage,
  upDateChatList
}

class ChatDetailActionCreator {
  static Action onAction() {
    return const Action(ChatDetailAction.action);
  }

  static Action setMessage(Detaillist detaillist) {
    return Action(ChatDetailAction.setMessage, payload: detaillist);
  }

  static Action upDateChatList(ChatList chatList) {
    return Action(ChatDetailAction.upDateChatList, payload: chatList);
  }

  static Action sendMessage() {
    return Action(ChatDetailAction.sendMessage);
  }

  static Action upDateIsShowSticker(bool isShowSticker) {
    return Action(ChatDetailAction.upDateIsShowSticker, payload: isShowSticker);
  }
}
