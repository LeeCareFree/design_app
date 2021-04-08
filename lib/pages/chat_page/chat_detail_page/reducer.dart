import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ChatDetailState> buildReducer() {
  return asReducer(
    <Object, Reducer<ChatDetailState>>{
      ChatDetailAction.action: _onAction,
    },
  );
}

ChatDetailState _onAction(ChatDetailState state, Action action) {
  final ChatDetailState newState = state.clone();
  return newState;
}
