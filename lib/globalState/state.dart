import 'dart:ui';
import 'package:bluespace/models/message_list.dart';
import 'package:bluespace/models/user_info.dart';
import 'package:bluespace/pages/chat_page/chat_detail_page/view.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

abstract class GlobalBaseState {
  Color get themeColor;
  set themeColor(Color color);
  UserInfo get userInfo;
  set userInfo(UserInfo userInfo);
  IO.Socket get socket;
  set socket(IO.Socket socket);
  MessageList get messageList;
  set messageList(MessageList messageList);
}

class GlobalState implements GlobalBaseState, Cloneable<GlobalState> {
  @override
  Color themeColor;

  @override
  UserInfo userInfo;
  @override
  IO.Socket socket;
  String uid;
  @override
  MessageList messageList;
  @override
  GlobalState clone() {
    return GlobalState()
      ..messageList = messageList
      ..uid = uid
      ..socket = socket
      ..themeColor = themeColor
      ..userInfo = userInfo;
  }
}
