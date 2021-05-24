import 'package:bluespace/globalState/action.dart';
import 'package:bluespace/globalState/store.dart';
import 'package:bluespace/models/chat_list.dart';
import 'package:bluespace/models/message_list.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'action.dart';
import 'state.dart';

Effect<ChatState> buildEffect() {
  return combineEffects(<Object, Effect<ChatState>>{
    ChatAction.action: _onAction,
    Lifecycle.initState: _onInit,
    ChatAction.refreshPage: _onRefreshPage,
    Lifecycle.build: _onBuild
  });
}

void _onAction(Action action, Context<ChatState> ctx) {}
void _onInit(Action action, Context<ChatState> ctx) async {
  ctx.state.refreshController = RefreshController();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final uid = prefs.getString('uid') ?? '';
  ctx.state.uid = uid;
  ctx.state.socket.emit('messageList', ctx.state.uid);
  ctx.state.socket.on(
      'getMessageList',
      (data) => {
            GlobalStore.store.dispatch(GlobalActionCreator.updateMessageList(
                MessageList.fromJson(data))),
          });
}

void _onRefreshPage(Action action, Context<ChatState> ctx) {
  ctx.state.socket.emit('messageList', ctx.state.uid);
  ctx.state.socket.on(
      'getMessageList',
      (data) => {
            print(data),
            GlobalStore.store.dispatch(GlobalActionCreator.updateMessageList(
                MessageList.fromJson(data))),
            ctx.state.refreshController.refreshCompleted()
          });
}

void _onBuild(Action action, Context<ChatState> ctx) async {
  print('build');
}
