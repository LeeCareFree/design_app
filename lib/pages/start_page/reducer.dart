import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<StartState> buildReducer() {
  return asReducer(
    <Object, Reducer<StartState>>{
      StartAction.action: _onAction,
    },
  );
}

StartState _onAction(StartState state, Action action) {
  final StartState newState = state.clone();
  return newState;
}
