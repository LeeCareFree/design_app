import 'package:bluespace/models/chat_list.dart';
import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<ChatState> buildEffect() {
  return combineEffects(<Object, Effect<ChatState>>{
    ChatAction.action: _onAction,
    Lifecycle.initState: _onInit
  });
}

void _onAction(Action action, Context<ChatState> ctx) {}
void _onInit(Action action, Context<ChatState> ctx) {}
