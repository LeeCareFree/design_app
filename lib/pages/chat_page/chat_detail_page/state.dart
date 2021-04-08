import 'package:bluespace/pages/chat_page/chat_detail_page/view.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatDetailState implements Cloneable<ChatDetailState> {
  IO.Socket socket;
  StreamSocket streamSocket;
  TextEditingController textEditingController;
  FocusNode focusNode;
  ScrollController scrollController;
  String uid;
  @override
  ChatDetailState clone() {
    return ChatDetailState()
      ..uid = uid
      ..scrollController = scrollController
      ..streamSocket = streamSocket
      ..focusNode = focusNode
      ..socket = socket
      ..textEditingController = textEditingController;
  }
}

ChatDetailState initState(Map<String, dynamic> args) {
  return ChatDetailState();
}
