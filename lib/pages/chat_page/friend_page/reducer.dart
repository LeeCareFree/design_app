import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<FriendState> buildReducer() {
  return asReducer(
    <Object, Reducer<FriendState>>{
      FriendAction.action: _onAction,
    },
  );
}

FriendState _onAction(FriendState state, Action action) {
  final FriendState newState = state.clone();
  return newState;
}
