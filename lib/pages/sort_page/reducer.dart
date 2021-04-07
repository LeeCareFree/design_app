import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SortState> buildReducer() {
  return asReducer(
    <Object, Reducer<SortState>>{
      SortAction.action: _onAction,
      SortAction.initDesignerList: _onInitDesignerList
    },
  );
}

SortState _onInitDesignerList(SortState state, Action action) {
  final SortState newState = state.clone();
  newState.designerList = action.payload;
  return newState;
}

SortState _onAction(SortState state, Action action) {
  final SortState newState = state.clone();
  return newState;
}
