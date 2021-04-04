import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<AppSettingState> buildReducer() {
  return asReducer(
    <Object, Reducer<AppSettingState>>{
      AppSettingAction.action: _onAction,
    },
  );
}

AppSettingState _onAction(AppSettingState state, Action action) {
  final AppSettingState newState = state.clone();
  return newState;
}
