import 'package:bluespace/models/chat_list.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatState implements Cloneable<ChatState> {
  ChatList chatList;
  @override
  ChatState clone() {
    return ChatState()..chatList = chatList;
  }
}

ChatState initState(Map<String, dynamic> args) {
  return ChatState();
}
