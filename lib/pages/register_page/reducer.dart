import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<RegisterPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<RegisterPageState>>{
      RegisterPageAction.action: _onAction,
      RegisterPageAction.setPasswordVisible: _onSetPasswordVisible,
      RegisterPageAction.setIsDesigner: _onSetIsDesigner
    },
  );
}

RegisterPageState _onSetPasswordVisible(
    RegisterPageState state, Action action) {
  final RegisterPageState newState = state.clone();
  if (action.payload == 1) {
    newState.passwordVisible = !state.passwordVisible;
  } else if (action.payload == 2) {
    newState.passwordTwoVisible = !state.passwordTwoVisible;
  }

  return newState;
}

RegisterPageState _onSetIsDesigner(RegisterPageState state, Action action) {
  final RegisterPageState newState = state.clone();
  newState.isDesigner = !state.isDesigner;
  return newState;
}

RegisterPageState _onAction(RegisterPageState state, Action action) {
  final RegisterPageState newState = state.clone();
  return newState;
}
