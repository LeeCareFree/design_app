import 'package:bluespace/globalState/state.dart';
import 'package:bluespace/models/account_info.dart';
import 'package:bluespace/models/chat_list.dart';
import 'package:bluespace/models/message_list.dart';
import 'package:bluespace/models/user_info.dart';
import 'package:bluespace/pages/chat_page/chat_detail_page/view.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatDetailState implements GlobalBaseState, Cloneable<ChatDetailState> {
  TextEditingController textEditingController;
  FocusNode focusNode;
  ScrollController scrollController;
  String uid;
  String guid;
  String nickname;
  String avatar;
  String myavatar;
  ChatList chatList;
  @override
  ChatDetailState clone() {
    return ChatDetailState()
      ..socket = socket
      ..nickname = nickname
      ..myavatar = myavatar
      ..avatar = avatar
      ..chatList = chatList
      ..uid = uid
      ..guid = guid
      ..scrollController = scrollController
      ..focusNode = focusNode
      ..textEditingController = textEditingController;
  }

  Color themeColor;
  @override
  UserInfo userInfo;
  @override
  IO.Socket socket;
  // @override
  MessageList messageList;
}

ChatDetailState initState(Map<String, dynamic> args) {
  return ChatDetailState()
    ..chatList = ChatList(detaillist: [])
    ..guid = args['guid']
    ..avatar = args['avatar']
    ..nickname = args['nickname'];
}
