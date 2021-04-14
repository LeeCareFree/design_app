import 'dart:async';
import 'dart:convert';

import 'package:bluespace/globalState/action.dart';
import 'package:bluespace/globalState/store.dart';
import 'package:bluespace/models/chat_list.dart';
import 'package:bluespace/models/message_list.dart';
import 'package:bluespace/net/service_method.dart';
import 'package:bluespace/pages/chat_page/chat_detail_page/view.dart';
import 'package:bluespace/utils/timeUtil.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
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
  var fireDate = DateTime.fromMillisecondsSinceEpoch(
      DateTime.now().millisecondsSinceEpoch + 3000);
  var localNotification = LocalNotification(
    id: 234,
    title: '技术胖的飞鸽传说',
    buildId: 1,
    content: '看到了说明已经成功了',
    fireTime: fireDate,
    subtitle: '一个测试',
  );
  ctx.state.jPush.sendLocalNotification(localNotification).then((res) {
    print(res);
  });
  int time = new DateTime.now().millisecondsSinceEpoch;
  String dateTime;
  if (ctx.state.chatList.detaillist.length != 0) {
    if (time > (ctx.state.chatList.detaillist.last.time + (5 * 60 * 1000))) {
      dateTime = DateTime.now().toString();
    }

    // RelativeDateFormat.format(dateTime);
  }
  if (ctx.state.textEditingController.text != null) {
    ctx.state.socket.emit("sendMessage", {
      "uid": ctx.state.uid,
      // "guid": ctx.state.uid,
      "guid": ctx.state.guid,
      "time": DateTime.now().millisecondsSinceEpoch,
      "message": ctx.state.textEditingController.text,
      "endTime": dateTime != null ? dateTime.toString().substring(0, 16) : null
    });

    ctx.dispatch(ChatDetailActionCreator.setMessage(Detaillist.fromJson({
      "uid": ctx.state.uid,
      "guid": ctx.state.guid,
      "message": ctx.state.textEditingController.text,
      "avatar": ctx.state.myavatar,
      "time": DateTime.now().millisecondsSinceEpoch,
      "endTime": dateTime != null ? dateTime.toString().substring(0, 16) : null
    })));
  }
}

void _onInit(Action action, Context<ChatDetailState> ctx) async {
  ctx.state.jPush = JPush();
  ctx.state.jPush.addEventHandler(
      onReceiveNotification: (Map<String, dynamic> message) async {
    print(">>>>>>>>>>>>>>>>>flutter 接收到推送: $message");
  });
  ctx.state.scrollController = ScrollController();
  ctx.state.textEditingController = TextEditingController();
  ctx.state.focusNode = FocusNode();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final uid = prefs.getString('uid') ?? '';
  final myavatar = prefs.getString('avatar') ?? '';
  ctx.state.myavatar = myavatar;
  ctx.state.uid = uid;
  ctx.state.socket.emit("enterChat", {
    "uid": ctx.state.uid,
    "guid": ctx.state.guid,
  });
  var sumRes = await DioUtil.request('getMessageSum',
      formData: {"uid": uid, "guid": ctx.state.guid});
  sumRes = json.decode(sumRes.toString());
  if (sumRes['code'] == 200) {
    var messageDetailRes = await DioUtil.request('getMessageDetail', formData: {
      "page": 1,
      "size": 10,
      "uid": uid,
      "guid": ctx.state.guid,
      "sum": sumRes['data']['sum']
    });
    messageDetailRes = json.decode(messageDetailRes.toString());
    if (messageDetailRes['code'] == 200) {
      ChatList chatList = ChatList.fromJson(messageDetailRes['data']);
      ctx.dispatch(ChatDetailActionCreator.upDateChatList(chatList));
      print(ctx.state.chatList.detaillist.last.time);
      ctx.state.socket.emit('messageList', ctx.state.uid);
      ctx.state.socket.on(
          'getMessageList',
          (data) => {
                GlobalStore.store.dispatch(
                    GlobalActionCreator.updateMessageList(
                        MessageList.fromJson(data)))
              });
    } else {
      // Fluttertoast.showToast(msg: messageDetailRes['msg'] ?? '获取消息失败！');
    }
  } else {
    Fluttertoast.showToast(msg: sumRes['msg'] ?? '获取消息总数失败！');
  }

  // ctx.state.socket.on(
  //     'getMessage',
  //     (data) => {
  //           ctx.dispatch(
  //               ChatDetailActionCreator.setMessage(Detaillist.fromJson(data)))
  //         });
  // ctx.state.socket.emit("messageDetail", {
  //   "uid": ctx.state.uid,
  //   // "guid": ctx.state.uid,
  //   "guid": ctx.state.guid,
  // });
  // ctx.state.socket.on(
  //     'getMessageDetail',
  //     (data) => {
  //           data != []
  //               ? ctx.dispatch(ChatDetailActionCreator.upDateChatList(
  //                   ChatList.fromJson(data)))
  //               : ''
  //         });
}

void _onDispose(Action action, Context<ChatDetailState> ctx) async {}

void _onInitJpush(Action action, Context<ChatDetailState> ctx) async {
  //监听响应方法的编写

  // if (!mounted) return;

  // setState(() {
  //   debugLable = platformVersion;
  // });
}
