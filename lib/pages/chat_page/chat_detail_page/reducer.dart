import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ChatDetailState> buildReducer() {
  return asReducer(
    <Object, Reducer<ChatDetailState>>{
      ChatDetailAction.action: _onAction,
      ChatDetailAction.setMessage: _onSetMessage,
      ChatDetailAction.upDateChatList: _onUpDateChatList,
    },
  );
}

ChatDetailState _onSetMessage(ChatDetailState state, Action action) {
  final ChatDetailState newState = state.clone();
  newState.chatList?.detaillist.add(action.payload);
  return newState;
}

ChatDetailState _onUpDateChatList(ChatDetailState state, Action action) {
  final ChatDetailState newState = state.clone();
  newState.chatList = action.payload;
  return newState;
}

ChatDetailState _onAction(ChatDetailState state, Action action) {
  final ChatDetailState newState = state.clone();
  return newState;
}
