import 'package:bluespace/components/message_item.dart';
// import 'package:bluespace/pages/chat_page/model/chat_model.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'action.dart';
import 'state.dart';

Effect<FriendState> buildEffect() {
  return combineEffects(<Object, Effect<FriendState>>{
    FriendAction.action: _onAction,
    Lifecycle.initState: _onInit,
    FriendAction.sendMessage: _onSendMessage,
    Lifecycle.dispose: _onDispose
  });
}

void _onAction(Action action, Context<FriendState> ctx) {}
void _onSendMessage(Action action, Context<FriendState> ctx) async {
  try {
    if (action.payload == null || action.payload.length == 0) {
      return;
    }
    // sendTyping(false);
    // ctx.state.socket.emit(
    //   "message",
    //   ChatModel(
    //     id: ctx.state.socket.id,
    //     message: action.payload,
    //     timestamp: DateTime.now(),
    //     username: 'lee',
    //   ).toJson(),
    // );
    // action.payload.clear();
  } catch (e) {}
}

void _onInit(Action action, Context<FriendState> ctx) async {
  try {
    ctx.state.socket = io('http://192.168.0.107:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });
    ctx.state.socket.connect();
    ctx.state.socket
        .on('connect', (_) => print('connect: ${ctx.state.socket.id}'));
    // socket.on('location', handleLocationListen);
    // ctx.state.socket.on('typing', handleTyping);
    ctx.state.socket.on('message', (data) => print('data$data'));
    ctx.state.socket.on('disconnect', (_) => print('disconnect'));
    ctx.state.socket.on('fromServer', (_) => print(_));

    // gotoMe();
  } catch (e) {
    print(e.toString());
  }
}

void _onDispose(Action action, Context<FriendState> ctx) {
  ctx.state.socket.close();
}

// void handleMessage(Action action, Context<FriendState> ctx) {
//     try {
//       var msg = ChatModel.fromJson(data);
//       ctx.state.messages.insert(
//         0,
//         MessageItem(
//           // isMe: isMe(msg.id),
//           message: msg,
//         ),
//       );
//     } catch (e) {
//       print(e.toString());
//     }
//   }
