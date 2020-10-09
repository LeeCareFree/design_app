import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CreateState> buildReducer() {
  return asReducer(
    <Object, Reducer<CreateState>>{
      CreateAction.action: _onAction,
    },
  );
}

CreateState _onAction(CreateState state, Action action) {
  final CreateState newState = state.clone();
  return newState;
}
