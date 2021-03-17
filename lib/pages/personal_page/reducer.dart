import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PersonalState> buildReducer() {
  return asReducer(
    <Object, Reducer<PersonalState>>{
      PersonalAction.action: _onAction,
    },
  );
}

PersonalState _onAction(PersonalState state, Action action) {
  final PersonalState newState = state.clone();
  return newState;
}
