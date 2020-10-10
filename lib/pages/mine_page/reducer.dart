import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MineState> buildReducer() {
  return asReducer(
    <Object, Reducer<MineState>>{
      MineAction.action: _onAction,
      MineAction.init: _onInit,
    },
  );
}

MineState _onAction(MineState state, Action action) {
  final MineState newState = state.clone();
  return newState;
}

MineState _onInit(MineState state, Action action) {
  final String name = action.payload[0] ?? '游客';
  final String avatar = action.payload[1] ?? 'assets/images/avatar.png';
  final bool isLogin = action.payload[2] ?? false;
  final MineState newState = state.clone();
  newState.name = name;
  newState.avatar = avatar;
  newState.isLogin = isLogin;
  return newState;
}

