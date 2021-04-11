import 'package:bluespace/globalState/state.dart';
import 'package:bluespace/models/chat_list.dart';
import 'package:bluespace/models/message_list.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:bluespace/models/user_info.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatState implements GlobalBaseState, Cloneable<ChatState> {
  @override
  ChatState clone() {
    return ChatState()..messageList = messageList;
  }

  @override
  Color themeColor;
  @override
  UserInfo userInfo;
  @override
  IO.Socket socket;
  @override
  MessageList messageList;
}

ChatState initState(Map<String, dynamic> args) {
  return ChatState()..messageList = MessageList(messlist: []);
}
