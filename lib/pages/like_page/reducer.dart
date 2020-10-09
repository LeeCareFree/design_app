import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<LikeState> buildReducer() {
  return asReducer(
    <Object, Reducer<LikeState>>{
      LikeAction.action: _onAction,
    },
  );
}

LikeState _onAction(LikeState state, Action action) {
  final LikeState newState = state.clone();
  return newState;
}
