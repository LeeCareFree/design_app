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
  if (action.payload == 'send' &&
      ctx.state.textEditingController.text != null) {
    ctx.state.socket.emit("sendMessage", {
      "uid": ctx.state.uid,
      "guid": '1fbebca0-867b-4f7e-80c0-144f080ed644',
      "message": ctx.state.textEditingController.text
    }
        // ChatModel(
        //   id: ctx.state.socket.id,
        //   message: ctx.state.textEditingController.text,
        //   timestamp: DateTime.now(),
        //   username: 'lee',
        // ).toJson(),
        );
  }

  // sendTyping(false);
}

void _onInit(Action action, Context<ChatDetailState> ctx) async {
  ctx.state.streamSocket = StreamSocket();
  ctx.state.scrollController = ScrollController();
  ctx.state.textEditingController = TextEditingController();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final uid = prefs.getString('uid') ?? '';
  ctx.state.uid = uid;
  try {
    ctx.state.socket = io('http://192.168.0.107:3001', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });
    ctx.state.socket.connect();
    ctx.state.socket.on('connection',
        (_) => {ctx.state.socket.emit('fromServer', (_) => print(_))});
    // socket.on('location', handleLocationListen);
    // ctx.state.socket.on('typing', handleTyping);
    // new user
    print(uid);
    ctx.state.socket.emit('createUser', uid);
    ctx.state.socket.on('getMessage', (data) => print('data$data'));

    ctx.state.socket
        .on('getMessageList', (data) => ctx.state.streamSocket.addResponse);
    ctx.state.socket.on('disconnect', (_) => print('111$_'));
    // ctx.state.socket.on('getMessage', (data) => print(data));
    // ctx.state.socket.on('useLeft', (data) => print(data));
    // gotoMe();
  } catch (e) {
    print(e.toString());
  }
}

void _onDispose(Action action, Context<ChatDetailState> ctx) {
  ctx.state.socket.close();
}
