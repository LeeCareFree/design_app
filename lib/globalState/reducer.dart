import 'dart:ui';

import 'package:bluespace/models/user_info.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

import 'action.dart';
import 'state.dart';

Reducer<GlobalState> buildReducer() {
  return asReducer(
    <Object, Reducer<GlobalState>>{
      GlobalAction.action: _onAction,
      GlobalAction.setUser: _onSetUser,
      GlobalAction.changeThemeColor: _onchangeThemeColor,
    },
  );
}

GlobalState _onAction(GlobalState state, Action action) {
  final GlobalState newState = state.clone();
  return newState;
}

GlobalState _onSetUser(GlobalState state, Action action) {
  final UserInfo userInfo = action.payload;
  print(action.payload);
  return state.clone()..userInfo = userInfo;
}

List<Color> _colors = <Color>[
  Colors.green,
  Colors.red,
  Colors.black,
  Colors.blue
];

GlobalState _onchangeThemeColor(GlobalState state, Action action) {
  final Color next =
      _colors[((_colors.indexOf(state.themeColor) + 1) % _colors.length)];
  return state.clone()..themeColor = next;
}
