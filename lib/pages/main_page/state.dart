import 'package:bluespace/globalState/state.dart';
import 'package:bluespace/models/message_list.dart';
import 'package:bluespace/models/user_info.dart';
import 'package:bluespace/pages/chat_page/chat_detail_page/view.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MainPageState implements GlobalBaseState, Cloneable<MainPageState> {
  int selectedIndex = 0;
  String uid;
  List<Widget> pages;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  MainPageState clone() {
    return MainPageState()
      ..uid = uid
      ..socket = socket
      ..messageList = messageList
      ..pages = pages
      ..selectedIndex = selectedIndex
      ..scaffoldKey = scaffoldKey;
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

MainPageState initState(Map<String, dynamic> args) {
  return MainPageState()..pages = args['pages'];
}
