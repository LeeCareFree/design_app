import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<BgState> buildReducer() {
  return asReducer(
    <Object, Reducer<BgState>>{
      BgAction.action: _onAction,
    },
  );
}

BgState _onAction(BgState state, Action action) {
  final BgState newState = state.clone();
  return newState;
}
