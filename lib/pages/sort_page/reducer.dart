import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SortState> buildReducer() {
  return asReducer(
    <Object, Reducer<SortState>>{
      SortAction.action: _onAction,
    },
  );
}

SortState _onAction(SortState state, Action action) {
  final SortState newState = state.clone();
  return newState;
}
