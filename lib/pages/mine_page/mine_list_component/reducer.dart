import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MineListState> buildReducer() {
  return asReducer(
    <Object, Reducer<MineListState>>{
      MineListAction.action: _onAction,
    },
  );
}

MineListState _onAction(MineListState state, Action action) {
  final MineListState newState = state.clone();
  return newState;
}
