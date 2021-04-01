import 'package:bluespace/models/user_info.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MineState> buildReducer() {
  return asReducer(
    <Object, Reducer<MineState>>{
      MineAction.action: _onAction,
      MineAction.init: _onInit,
      MineAction.initAccountInfo: _onInitAccountInfo
    },
  );
}

MineState _onInit(MineState state, Action action) {
  final String name = action.payload[0];
  final String avatar = action.payload[1];
  final String uid = action.payload[2];
  final MineState newState = state.clone();
  newState.name = name;
  newState.avatar = avatar;
  newState.uid = uid;
  return newState;
}

MineState _onInitAccountInfo(MineState state, Action action) {
  final MineState newState = state.clone();
  newState..accountInfo = action.payload;
  return newState;
}

MineState _onAction(MineState state, Action action) {
  final MineState newState = state.clone();
  return newState;
}
