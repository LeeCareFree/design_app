import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PersonalListState> buildReducer() {
  return asReducer(
    <Object, Reducer<PersonalListState>>{
      PersonalListAction.action: _onAction,
    },
  );
}

PersonalListState _onAction(PersonalListState state, Action action) {
  final PersonalListState newState = state.clone();
  return newState;
}
