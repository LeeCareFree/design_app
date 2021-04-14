import 'package:bluespace/globalState/store.dart';
import 'package:bluespace/models/message_list.dart';
import 'package:bluespace/models/user_info.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum GlobalAction {
  action,
  setUser,
  changeThemeColor,
  updateUserInfo,
  updateSocket,
  updateMessageList,
  setUserMember
}

class GlobalActionCreator {
  static Action onAction() {
    return const Action(GlobalAction.action);
  }

  static Action updateMessageList(MessageList messageList) {
    print(messageList);
    return Action(GlobalAction.updateMessageList, payload: messageList);
  }

  static Action updateSocket(IO.Socket socket) {
    return Action(GlobalAction.updateSocket, payload: socket);
  }

  static Action setUser(UserInfo userInfo) {
    return Action(GlobalAction.setUser, payload: userInfo);
  }

  static Action onChangeThemeColor() {
    return const Action(GlobalAction.changeThemeColor);
  }
}
