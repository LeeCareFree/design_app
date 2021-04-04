import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PersonalSettingState> buildReducer() {
  return asReducer(
    <Object, Reducer<PersonalSettingState>>{
      PersonalSettingAction.action: _onAction,
      PersonalSettingAction.setImg: _onSetImg,
      PersonalSettingAction.setContent: _onSetContent
    },
  );
}

PersonalSettingState _onAction(PersonalSettingState state, Action action) {
  final PersonalSettingState newState = state.clone();
  return newState;
}

PersonalSettingState _onSetImg(PersonalSettingState state, Action action) {
  final PersonalSettingState newState = state.clone();
  switch (action.payload[0]) {
    case 'profile':
      newState.profile = action.payload[1];
      break;
    case 'backgroundImg':
      newState.backgroundImg = action.payload[1];
      break;
    default:
  }
  return newState;
}

PersonalSettingState _onSetContent(PersonalSettingState state, Action action) {
  final PersonalSettingState newState = state.clone();
  switch (action.payload[0]) {
    case 'nickname':
      newState.nickname = action.payload[1];
      break;
    case 'personalShow':
      newState.personalShow = action.payload[1];
      break;
    case 'gender':
      newState.gender = action.payload[1] == '男' ? 1 : 2;
      break;
    case 'location':
      newState.location = action.payload[1];
      break;
    default:
  }
  return newState;
}
