import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<UserListState> buildReducer() {
  return asReducer(
    <Object, Reducer<UserListState>>{
      UserListAction.action: _onAction,
      UserListAction.updateList: _onUpdateList,
      UserListAction.setLoading: _setLoading,
    },
  );
}

UserListState _onAction(UserListState state, Action action) {
  final UserListState newState = state.clone();
  return newState;
}

UserListState _setLoading(UserListState state, Action action) {
  final bool _loading = action.payload;
  final UserListState newState = state.clone();
  newState.isLoading = _loading;
  return newState;
}

UserListState _onUpdateList(UserListState state, Action action) {
  final UserListState newState = state.clone();
  newState.followFansList.result[action.payload[0]].isFocus = action.payload[1];
  return newState;
}
