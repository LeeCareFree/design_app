import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<StartState> buildReducer() {
  return asReducer(
    <Object, Reducer<StartState>>{
      StartAction.action: _onAction,
      StartAction.onCheckIsLogin: _onCheckIsLogin
    },
  );
}

StartState _onAction(StartState state, Action action) {
  final StartState newState = state.clone();
  return newState;
}

StartState _onCheckIsLogin(StartState state, Action action) {
  final StartState newState = state.clone();
  newState.isLogin = action.payload;
  return newState;
}
