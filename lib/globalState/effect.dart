import 'package:bluespace/pages/chat_page/chat_detail_page/view.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'action.dart';
import 'state.dart';

Effect<GlobalState> buildEffect() {
  return combineEffects(<Object, Effect<GlobalState>>{
    GlobalAction.action: _onAction,
    // Lifecycle.initState: _onInit,
  });
}

void _onAction(Action action, Context<GlobalState> ctx) {}
