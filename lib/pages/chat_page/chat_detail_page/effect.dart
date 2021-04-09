import 'dart:async';
import 'dart:convert';

import 'package:bluespace/components/message_item.dart';
import 'package:bluespace/globalState/action.dart';
import 'package:bluespace/globalState/store.dart';
import 'package:bluespace/models/chat_list.dart';
import 'package:bluespace/models/chat_model.dart';
import 'package:bluespace/pages/chat_page/chat_detail_page/view.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'action.dart';
import 'state.dart';

Effect<ChatDetailState> buildEffect() {
  return combineEffects(<Object, Effect<ChatDetailState>>{
    ChatDetailAction.action: _onAction,
    ChatDetailAction.sendMessage: _onSendMessage,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose
  });
}

void _onAction(Action action, Context<ChatDetailState> ctx) {}

void _onSendMessage(Action action, Context<ChatDetailState> ctx) async {
  // GlobalStore.store.dispatch(GlobalActionCreator.seedMessage(action.payload));
  // print(ctx.state.userInfo?.avatar);
  Detaillist detaillist = Detaillist.fromJson({
    "uid": ctx.state.uid,
    "message": ctx.state.textEditingController.text,
    "avatar": ctx.state.myavatar
  });
  if (ctx.state.textEditingController.text != null) {
    ctx.state.socket.emit("sendMessage", {
      "uid": ctx.state.uid,
      // "guid": ctx.state.uid,
      "guid": ctx.state.guid,
      "message": ctx.state.textEditingController.text
    });
    ctx.dispatch(ChatDetailActionCreator.setMessage(detaillist));
  }
}

void _onInit(Action action, Context<ChatDetailState> ctx) async {
  ctx.state.scrollController = ScrollController();
  ctx.state.textEditingController = TextEditingController();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final uid = prefs.getString('uid') ?? '';
  final myavatar = prefs.getString('avatar') ?? '';
  ctx.state.myavatar = myavatar;
  ctx.state.uid = uid;
  ctx.state.socket.on(
      'getMessage',
      (data) => {
            ctx.dispatch(
                ChatDetailActionCreator.setMessage(Detaillist.fromJson(data)))
          });
  ctx.state.socket.emit("messageDetail", {
    "uid": ctx.state.uid,
    // "guid": ctx.state.uid,
    "guid": ctx.state.guid,
  });
  ctx.state.socket.on(
      'getMessageDetail',
      (data) => {
            ctx.dispatch(
                ChatDetailActionCreator.upDateChatList(ChatList.fromJson(data)))
          });
}

void _onDispose(Action action, Context<ChatDetailState> ctx) {}
